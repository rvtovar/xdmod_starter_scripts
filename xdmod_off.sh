!#/bin/bash

dockerPath=~/Work/xdmod/tests/playwright/Docker/docker-compose.yml

GREEN='\033[0;32m'

echo "${GREEN} Turning Off Docker Containers ${NC}"

docker compose -f $dockerPath down

echo "${GREEN} Done ${NC}"



exit 0
