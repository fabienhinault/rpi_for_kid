#!/bin/bash

# run as root

set -euf -o pipefail

read -p 'KID=' KID

echo "root's password"
passwd root

for d in {0..9}
do
  for u in {0..9}
  do
    useradd -m ${KID}$d$u
    usermod -a -G video,audio ${KID}$d$u
  done
done

echo "${KID}99's password"
passwd ${KID}99

cp -a /etc/lidghtdm/lightdm.conf /etc/lidghtdm/lightdm.conf~origin

sed -i "s/\(^autologin-user=.*$\)/#>>>\n# https:\/\/github.com\/fabienhinault\/rpi_for_kid\n# \1\nautologin-user=${KID}99\n#<<</" /etc/lightdm/lightdm.conf
sed -i "s/User_Alias      KID =/\1 ${KID}99/" ./etc/sudoers.d/kid


cp -r ./etc /etc
