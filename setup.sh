touch ~/.hushlogin
pkg update -y
apt -o Dpkg::Options::="--force-confold" upgrade -y
pkg install -y proot-distro
proot-distro install heywoodlh/archlinux --override-alias archlinux
echo "exec proot-distro login archlinux --user kagamimochi" >> ~/.bashrc
proot-distro login archlinux -- bash -c "pacman -Syu --noconfirm sudo nano && \
useradd -m kagamimochi && \
echo 'kagamimochi ALL=(ALL:ALL) ALL' > /etc/sudoers.d/kagamimochi && \
chmod 440 /etc/sudoers.d/kagamimochi && \
visudo -c && \
cat > /home/kagamimochi/.bashrc <<'EOF'
export XDG_RUNTIME_DIR=\"/run/user/\$(id -u)\"
mkdir -p \"\$XDG_RUNTIME_DIR\"
chmod 700 \"\$XDG_RUNTIME_DIR\"
EOF
passwd kagamimochi" && \
exit