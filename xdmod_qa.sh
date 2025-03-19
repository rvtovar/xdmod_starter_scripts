!#/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "${GREEN}Beginning QA Setup ${NC}"
branch=${1:-v2}

docker exec -w /root xdmod git clone --depth=1 --branch="${branch}" https://github.com/rvtovar/xdmod-qa.git /root/.qa


docker exec -w /root/xdmod xdmod /root/.qa/scripts/install.sh

docker exec -w /root/xdmod xdmod git config --global --add safe.directory /xdmod-qa
docker exec -w /root/xdmod xdmod git config --global --add safe.directory /root/xdmod
docker exec -w /root/xdmod xdmod git remote add upstream https://github.com/rvtovar/xdmod.git

docker exec xdmod cp /etc/xdmod/portal_settings.ini /root/xdmod/configuration/portal_settings.ini

docker exec -w /root/xdmod xdmod /root/.qa/scripts/build.sh








