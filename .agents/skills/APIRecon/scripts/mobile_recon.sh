#!/usr/bin/env bash
# API Reconnaissance — Mobile Static Analysis
# Decompiles APK, extracts endpoints, secrets (masked), and manifest configs.
# ⚠️ Dynamic interception requires explicit authorization + owned device.

set -euo pipefail

APK_PATH="${1:-}"

if [ -z "$APK_PATH" ] || [ ! -f "$APK_PATH" ]; then
    echo "[!] Usage: $0 <path-to-app.apk>"
    echo "    Skipping mobile recon — no APK provided."
    exit 0
fi

echo "[+] Phase 11: Mobile Static Analysis"
mkdir -p mobile

# Decompile
jadx -d mobile/jadx_out "$APK_PATH" 2>/dev/null || true
apktool d "$APK_PATH" -o mobile/apktool_out 2>/dev/null || true

# Automated surfacing (mask any secrets it prints!)
apkleaks -f "$APK_PATH" -o mobile/apkleaks.txt 2>/dev/null || true
# Mask secrets in apkleaks output
sed -i -E 's/([A-Za-z0-9]{4})[A-Za-z0-9_-]{10,}([A-Za-z0-9]{4})/\1****...****\2/g' mobile/apkleaks.txt 2>/dev/null || true

# Base URLs & API paths from decompiled sources
rg -oN 'https?://[a-zA-Z0-9.-]+(/[a-zA-Z0-9_./-]*)?' mobile/jadx_out 2>/dev/null \
  | rg -i 'api|graphql|gateway' 2>/dev/null | sort -u > mobile/base_urls.txt || true

rg -oN -e '/api/[a-zA-Z0-9_./-]+' -e '/v[0-9]+/[a-zA-Z0-9_./-]+' mobile/jadx_out 2>/dev/null \
  | sort -u > mobile/mobile_endpoints.txt || true

# strings fallback
strings "$APK_PATH" | rg -i 'api|graphql|/v[0-9]' 2>/dev/null | sort -u > mobile/strings_api.txt || true

# Manifest & config review
echo "[+] Phase 11: Manifest Review"
rg -i 'android:scheme|android:host|intent-filter' mobile/apktool_out/AndroidManifest.xml 2>/dev/null > mobile/deep_links.txt || true

if [ -f mobile/apktool_out/res/xml/network_security_config.xml ]; then
    cp mobile/apktool_out/res/xml/network_security_config.xml mobile/network_security_config.xml
fi

# MobSF via Docker (static only)
echo "[+] Phase 11: Optional — MobSF static analysis"
echo "    docker run -it --rm -p 8000:8000 opensecurity/mobile-security-framework-mobsf"

echo "[+] Mobile recon complete."
echo "    - Base URLs:       $(wc -l < mobile/base_urls.txt 2>/dev/null || echo 0)"
echo "    - Endpoints:       $(wc -l < mobile/mobile_endpoints.txt 2>/dev/null || echo 0)"
echo "    - Deep links:      $(wc -l < mobile/deep_links.txt 2>/dev/null || echo 0)"
