#!/bin/bash

touch ~/.hushlogin

pkg update -y
apt -o Dpkg::Options::="--force-confold" upgrade -y

pkg install -y proot-distro
proot-distro install heywoodlh/archlinux --override-alias archlinux

echo "exec proot-distro login archlinux --user user" >> ~/.bashrc

proot-distro login archlinux -- bash -c "pacman -Syu --noconfirm sudo nano && \
useradd -m user && \
echo 'user ALL=(ALL:ALL) ALL' > /etc/sudoers.d/user && \
chmod 440 /etc/sudoers.d/user && \
visudo -c && \
cat > /home/user/.bashrc <<'EOF'
export XDG_RUNTIME_DIR=\"/run/user/\$(id -u)\"
mkdir -p \"\$XDG_RUNTIME_DIR\"
chmod 700 \"\$XDG_RUNTIME_DIR\"
EOF
passwd user"

exit
