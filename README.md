# Tuxbuntu 🐧

**Tuxbuntu 26.04 LTS** is a custom Ubuntu-based Linux distribution built from Ubuntu 26.04 LTS (Resolute) with a reproducible ISO build system.

> 🚧 Early development — the first goal is a bootable, installable amd64 ISO. Expect rough edges while the project evolves.

## What is Tuxbuntu?

Tuxbuntu keeps Ubuntu as the foundation while adding a small set of developer, VM, troubleshooting, and desktop defaults. The project is intentionally built from scripts and configuration rather than modifying a running installation by hand.

### Included

- Ubuntu 26.04 LTS base
- GNOME desktop via `ubuntu-desktop-minimal`
- Linux kernel and firmware
- NetworkManager
- Git, Python 3, pip, and build-essential
- Fastfetch, btop, htop, Vim, and Nano
- QEMU guest agent and SPICE agent for VM testing
- Tuxbuntu OS branding
- Custom Tuxbuntu wallpaper
- Live ISO build configuration
- GitHub Actions CI build

## Build locally

Tuxbuntu uses `live-build`.

On an Ubuntu/Debian build machine, install the required tooling:

```bash
sudo apt update
sudo apt install live-build debootstrap ubuntu-keyring squashfs-tools xorriso \
  grub-pc-bin grub-efi-amd64-bin grub-efi-amd64-signed mtools dosfstools \
  isolinux syslinux-common rsync ca-certificates
```

Then build:

```bash
chmod +x build.sh
sudo ./build.sh
```

The resulting image is:

```text
Tuxbuntu-26.04-amd64.iso
```

## GitHub Actions

Every push that changes the build configuration can run the ISO build automatically. You can also start it manually from the **Actions** tab with **Build Tuxbuntu ISO**.

The workflow publishes the ISO and build log as GitHub Actions artifacts.

## Repository layout

```text
tuxbuntu/
├── .github/workflows/build-iso.yml
├── assets/
│   └── tuxbuntu-wallpaper.svg
├── config/
│   ├── hooks/normal/
│   ├── includes.chroot/
│   └── package-lists/
├── build.sh
└── README.md
```

## Roadmap

- [x] Ubuntu 26.04 LTS base
- [x] Reproducible ISO build script
- [x] GitHub Actions ISO build
- [x] Tuxbuntu branding
- [x] Custom wallpaper
- [ ] Custom icon/theme pack
- [ ] More desktop defaults
- [ ] Installer branding
- [ ] Tuxbuntu first-run setup
- [ ] Release checksums and signed releases
- [ ] VirtualBox/QEMU automated boot testing

## License

The Tuxbuntu project configuration and original assets are provided under the repository's chosen license. Ubuntu and its packages remain under their respective upstream licenses and trademarks.
