#!/bin/bash

touch ~/.hushlogin

pkg update -y
apt -o Dpkg::Options::="--force-confold" upgrade -y

pkg install -y x11-repo
pkg install -y termux-x11-nightly
pkg install -y proot-distro
proot-distro install heywoodlh/archlinux --override-alias archlinux

proot-distro login archlinux -- bash -c '
pacman -Syu --noconfirm sudo nano
useradd -m user
echo "user:password" | chpasswd
echo "user ALL=(ALL:ALL) ALL" > /etc/sudoers.d/user
chmod 440 /etc/sudoers.d/user
visudo -c

cat << "EOF" > /home/user/.bashrc
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"
EOF
chown user:user /home/user/.bashrc
'

echo 'echo "Press Ctrl+C to cancel Arch Linux login..." && sleep 2 && clear && exec proot-distro login archlinux --user user' >> ~/.bashrc

exit
