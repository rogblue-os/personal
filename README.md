# personal


## Usage

- Install Fedora Silverblue 37
- Rebase using this image:
```
sudo rpm-ostree rebase --experimental ostree-unverified-registry:ghcr.io/rogblue-os/personal:latest
```
## What is this
This is my personal image, which I decided to share.

This includes pretty much the base image and then my modifications on top of that. If you want a "base" image for your ROG laptop with the needed asusctl tools included, i recommend you use the [LAPTOP](https://github.com/rogblue-os/laptop) image.

## Includes
- Everything from the [base](https://github.com/rogblue-os/base) image
- Papirus icon theme
- adw-gtk3 theme, dark theme set as default after install
- asusctl, supergfxctl and asusctl-rog-gui from [asus-linux.org](https://www.asus-linux.org) project
- Stock kernel replaced with kernel 6.1rc
- some settings which I cant remember all :D

## Thanks
- [Jorge Castro](https://www.github.com/castrojo) for the inspiration and guidance, these are based mostly to his scripts and groundwork
- The whole Fedora Silverblue / ostree team

