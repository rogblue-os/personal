[![build-rogblue](https://github.com/rogblue-os/personal/actions/workflows/build.yml/badge.svg)](https://github.com/rogblue-os/personal/actions/workflows/build.yml)

# Personal Silverblue image for Asus ROG Zephyrus G14 (2022)


## Howto use

- Install Fedora Silverblue 37
- Rebase using this image:
```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/rogblue-os/personal:latest
```
## What is this
This is my personal image, which I decided to share. This has been made specifically for the Asus ROG Zephyrus G14 laptop (2022 model - GA402)

This includes pretty much the base Silverblue image and then my modifications on top of that. If you want a "base" image for your ROG laptop with the needed [asus-linux project](https://www.asus-linux.org) tools included, i recommend you use the [laptop](https://github.com/rogblue-os/laptop) image.

## Includes
- Everything from the [base](https://github.com/rogblue-os/base) image
- Papirus icon theme
- adw-gtk3 theme, dark theme set as default after install
- asusctl, supergfxctl and asusctl-rog-gui from [asus-linux.org](https://www.asus-linux.org) project
- Stock kernel replaced with kernel 6.1 (final) from [Kernel Vanilla Repo](https://fedoraproject.org/wiki/Kernel_Vanilla_Repositories)
- Added ProtonVPN client + ProtonMail Bridge
- Added Solaar for configure Logitech mice
- dconf modifications to get the desktop ready after following reboot from rebase

## Thanks
- [Jorge Castro](https://www.github.com/castrojo) for the inspiration and guidance, these are based mostly to his scripts and groundwork
- The whole Fedora Silverblue / ostree team

