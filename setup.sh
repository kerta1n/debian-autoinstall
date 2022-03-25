#!/bin/bash
# welcome to the desert of the real

# check if file has been run
FILE=/root/complete.done     
if [ -f $FILE ]; then
   echo "File $FILE exists. Exiting."
   exit 1
else
   echo "File $FILE does not exist. Continuing."
fi

## install sudo
apt install sudo
/sbin/usermod -aG sudo debian

### install docker
# add keyring
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# add stable repo to apt
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## install docker engine
apt update
apt install docker-ce docker-ce-cli containerd.io

docker run hello-world

## install docker compose
# download latest compose cuz not in repository
# credit https://geraldonit.com/2019/01/15/how-to-download-the-latest-github-repo-release-via-command-line/
LOCATION=$(curl -s https://api.github.com/repos/docker/github/releases/latest \
| grep "tag_name" \
| awk '{print "https://github.com/docker/compose/releases/latest/tag/" substr($2, 2, length($2)-3)}') \
; curl -L -o /home/debian/cli-plugins/docker-compose $LOCATION

mkdir /home/debian/docker/
touch complete.done