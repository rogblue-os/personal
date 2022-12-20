FROM ghcr.io/rogblue-os/base:latest
# See https://pagure.io/releng/issue/11047 for final location

COPY etc /etc
COPY usr /usr

### Kernel 6.1
RUN rpm-ostree cliwrap install-to-root /
RUN rpm-ostree override replace https://repos.fedorapeople.org/repos/thl/kernel-vanilla-mainline/fedora-38/x86_64/kernel-6.1.0-65.vanilla.1.fc38.x86_64.rpm \
	https://repos.fedorapeople.org/repos/thl/kernel-vanilla-mainline/fedora-38/x86_64/kernel-core-6.1.0-65.vanilla.1.fc38.x86_64.rpm \
	https://repos.fedorapeople.org/repos/thl/kernel-vanilla-mainline/fedora-38/x86_64/kernel-modules-6.1.0-65.vanilla.1.fc38.x86_64.rpm \
	https://repos.fedorapeople.org/repos/thl/kernel-vanilla-mainline/fedora-38/x86_64/kernel-modules-extra-6.1.0-65.vanilla.1.fc38.x86_64.rpm

# Install ProtonVPN repo package
RUN rpm-ostree install https://repo.protonvpn.com/fedora-36-stable/release-packages/protonvpn-stable-release-1.0.1-1.noarch.rpm

#RUN /usr/libexec/rpm-ostree/wrapped/dracut --tmpdir /tmp/ --no-hostonly --kver 6.1.0-0.rc8.20221209git0d1409e4ff08.62.vanilla.1.fc37.x86_64 --reproducible -v --add ostree -f /tmp/initramfs2.img
#RUN mv /tmp/initramfs2.img /lib/modules/6.1.0-0.rc8.20221209git0d1409e4ff08.62.vanilla.1.fc37.x86_64/initramfs.img

# Asus-Linux kernel
# Add Asus-linux copr repo
#RUN cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/lukenukem/asus-kernel/repo/fedora-37/lukenukem-asus-kernel-fedora-37.repo
#RUN rpm-ostree cliwrap install-to-root /
#RUN sudo rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:lukenukem:asus-kernel kernel kernel-core kernel-modules kernel-modules-extra

# Add vscode repo
RUN echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/code.repo

# Add Asus-linux copr repo
RUN cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/lukenukem/asus-linux/repo/fedora-37/lukenukem-asus-linux-fedora-37.repo

# Add Gnome-VRR repo
RUN sudo wget https://copr.fedorainfracloud.org/coprs/kylegospo/gnome-vrr/repo/fedora-$(rpm -E %fedora)/kylegospo-gnome-vrr-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr_kylegospo-gnome-vrr.repo

# Add ADW-GTK3 theme copr
RUN sudo wget -P /etc/yum.repos.d/ https://copr.fedorainfracloud.org/coprs/nickavem/adw-gtk3/repo/fedora-37/nickavem-adw-gtk3-fedora-37.repo

# Install gnome-vrr patches
RUN rpm-ostree override replace --experimental --from repo=copr:copr.fedorainfracloud.org:kylegospo:gnome-vrr mutter gnome-control-center gnome-control-center-filesystem

# Install apps
RUN rpm-ostree install \
	# virt-manager and needed stuff
	libvirt-daemon-config-network libvirt-daemon-kvm qemu-kvm util-linux-user \
    virt-install virt-manager virt-viewer \
    # zsh & neofetch
    zsh neofetch \
    # logitech mouse stuff
    solaar \
    # vscode
    code \
    # adw-gtk3 theme
    adw-gtk3 \
    # appindicator and dash to dock extensions
    gnome-shell-extension-appindicator gnome-shell-extension-dash-to-dock openssl nautilus-gsconnect\
    # distrobox
    distrobox \
    # asusctl, supergfxctl and asusctl-rog-gui
    asusctl supergfxctl asusctl-rog-gui \
    # better cli editor
    micro \
    # icon theme
    papirus-icon-theme \
    # protonvpn stuff
    protonvpn python-pip \
    # gnome-tweaks
    gnome-tweaks 


# Final housekeeping
RUN	systemctl enable supergfxd && \
	systemctl unmask dconf-update.service && \
    systemctl enable dconf-update.service && \
    fc-cache -f /usr/share/fonts/ubuntu && \
    fc-cache -f /usr/share/fonts/meslo && \
    rm -rf /var/lib/unbound && \
    ostree container commit
