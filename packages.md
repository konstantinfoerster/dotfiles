# Base

pacman -S base-devel bash-completion openssh gnupg gcr git
> systemctl enable sshd

## Hints

gvim for +clipboard support

# Desktop

pacman -S gnome gnome-tweaks gdm gnome-software-packagekit-plugin
> systemctl enable gdm

# Terminal

pacman -S tmux gvim the_silver_searcher

# Drivers

pacman -S mesa mesa-vdpau mesa-libgl libva-utils

## Thinkpad W520 (i965)

pacman -S libva-intel-driver

# Audio

pacman -S pipewire pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire libpulse wireplumber
> systemctl enable --user pipewire-pulse.service

# Fonts

pacman -S ttf-dejavu ttf-droid ttf-hack powerline-fonts

# Develop

pacman -S jdk8-openjdk openjdk8-doc openjdk8-src \
  jdk11-openjdk openjdk11-doc openjdk11-src \
  jdk17-openjdk openjdk17-doc openjdk17-src \
  go \
  docker docker-compose \
  kubectl kubectx \
  ansible-core
> systemctl enable docker

