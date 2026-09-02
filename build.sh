#!/usr/bin/env bash
set -Eeuo pipefail

# Tuxbuntu 26.04 LTS ISO builder
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run this builder as root (for example: sudo ./build.sh)."
  exit 1
fi

command -v lb >/dev/null 2>&1 || {
  echo "live-build is required. Install it with: apt install live-build"
  exit 1
}

rm -rf config/binary config/bootstrap config/chroot config/common config/installer config/source config/stages
rm -f Tuxbuntu-26.04-amd64.iso

# GitHub's contents API stores scripts as regular files; make live-build hooks executable.
find config/hooks -type f -name '*.hook.chroot' -exec chmod +x {} +

lb clean --purge || true

# live-build 3.0~a57 does not accept --updates/--backports on lb config.
# Ubuntu's update/security repositories are selected through its Ubuntu mode defaults.
lb config \
  --mode ubuntu \
  --distribution resolute \
  --architectures amd64 \
  --archive-areas "main restricted universe multiverse" \
  --binary-images iso-hybrid \
  --debian-installer live \
  --debian-installer-gui true \
  --memtest none \
  --bootappend-live "boot=live components quiet splash" \
  --apt-recommends true \
  --security true \
  --firmware-binary true \
  --firmware-chroot true

lb build 2>&1 | tee tuxbuntu-build.log

ISO=""
for candidate in *.iso; do
  if [[ -f "$candidate" ]]; then
    ISO="$candidate"
    break
  fi
done

if [[ -z "$ISO" ]]; then
  echo "Build completed but no ISO was found."
  exit 1
fi

FINAL="Tuxbuntu-26.04-amd64.iso"
if [[ "$ISO" != "$FINAL" ]]; then
  mv -f "$ISO" "$FINAL"
fi

echo "Built: $ROOT_DIR/$FINAL"
