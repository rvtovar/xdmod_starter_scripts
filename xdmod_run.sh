!#/bin/bash

projectPath=~/Work/xdmod/
dockerPath=${projectPath}/tests/playwright/Docker/docker-compose.yml

install_type=${1:-fresh_install}

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo "${GREEN}Turning On Docker Containers ${NC}"

docker compose -f $dockerPath up -d

echo "${GREEN} removing and making directories ${NC}"
rm -rf ~/phpunit
mkdir ~/phpunit 
rm -rf /tmp/screenshots 
mkdir /tmp/screenshots


echo "${YELLOW} setting up directoreis for phpunit, playwright, and code coverage ${NC}"

docker exec xdmod mkdir /root/phpunit 
docker exec xdmod mkdir /tmp/screenshots
docker exec xdmod mkdir /root/code_coverage_raw
docker exec xdmod mkdir /root/code_coverage

echo "${BLUE} Composer Install ${NC}"

docker exec -w /root/xdmod xdmod composer install

echo "${BLUE} Building XDMOD ${NC}"

docker exec -w /root/xdmod xdmod /root/bin/buildrpm xdmod

echo "${BLUE} bootstraping XDMOD ${NC}"

docker exec -e XDMOD_TEST_MODE=$install_type xdmod /root/xdmod/tests/ci/bootstrap.sh


echo "${GREEN} Creating database user ${NC}"
docker exec -it xdmod mysql -e "CREATE USER 'xdmod'@'192.168.65.1' IDENTIFIED BY 'xdmod123'; GRANT ALL PRIVILEGES ON *.* TO 'xdmod'@'192.168.65.1' WITH GRANT OPTION; FLUSH PRIVILEGES;"
exit 0
