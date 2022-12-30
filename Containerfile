FROM ghcr.io/rogblue-os/base:latest
# See https://pagure.io/releng/issue/11047 for final location

COPY etc /etc
COPY usr /usr

### Add all needed repos
    # 1Password
    RUN rpm-ostree install https://repo.protonvpn.com/fedora-36-stable/release-packages/protonvpn-stable-release-1.0.1-1.noarch.rpm
    # vscode
    RUN echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/code.repo
    # Blackbox-terminal repo
    RUN wget https://copr.fedorainfracloud.org/coprs/lyessaadi/blackbox/repo/fedora-37/lyessaadi-blackbox-fedora-37.repo -O /etc/yum.repos.d/lyessaadi-blackbox.repo
    # Add Asus-linux copr repo
    RUN cd /etc/yum.repos.d/ && curl -LO https://copr.fedorainfracloud.org/coprs/lukenukem/asus-linux/repo/fedora-37/lukenukem-asus-linux-fedora-37.repo
    # Add Gnome-VRR repo
    RUN sudo wget https://copr.fedorainfracloud.org/coprs/kylegospo/gnome-vrr/repo/fedora-$(rpm -E %fedora)/kylegospo-gnome-vrr-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr_kylegospo-gnome-vrr.repo
    # Add ADW-GTK3 theme copr
    RUN sudo wget -P /etc/yum.repos.d/ https://copr.fedorainfracloud.org/coprs/nickavem/adw-gtk3/repo/fedora-37/nickavem-adw-gtk3-fedora-37.repo
    
### Kernel 6.1
RUN rpm-ostree cliwrap install-to-root /

RUN rpm-ostree override replace --experimental --from repo=kernel-vanilla-stable kernel kernel-core kernel-modules kernel-modules-extra

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
    gnome-shell-extension-appindicator gnome-shell-extension-dash-to-dock openssl nautilus-gsconnect gnome-shell-extension-gsconnect \ 
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
    # Blackbox terminal
    blackbox-terminal \
    # gnome-tweaks
    gnome-tweaks
    
# Install latest 1Password
RUN sudo rpm-ostree install https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm

# remove toolbox
RUN rpm-ostree override remove toolbox
# Final housekeeping
RUN	systemctl enable supergfxd && \
	systemctl unmask dconf-update.service && \
    systemctl enable dconf-update.service && \
    fc-cache -f /usr/share/fonts/ubuntu && \
    fc-cache -f /usr/share/fonts/meslo && \
    rm -rf /var/lib/unbound && \
    ostree container commit
