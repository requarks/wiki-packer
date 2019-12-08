#!/bin/bash

cloud-init status --wait

cp ./files/var/lib/cloud/scripts/per-instance/001_onboot.sh /var/lib/cloud/scripts/per-instance/001_onboot.sh
cp ./files/etc/update-motd.d/99-one-click.sh /etc/update-motd.d/99-one-click.sh
chmod +x /var/lib/cloud/scripts/per-instance/001_onboot.sh
chmod +x /etc/update-motd.d/99-one-click.sh

apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade

sh ./scripts/10-install_docker.sh
sh ./scripts/80-firewall.sh
sh ./scripts/90-cleanup.sh
sh ./scripts/99-img_check.sh
