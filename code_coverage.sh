#!/bin/bash
GREEN='\033[0;32m'
echo "${GREEN} Running Code Coverage ${NC}"
docker exec -w /root/xdmod xdmod /root/xdmod/tools/dev/code_coverage/codeCoverageSetup.sh -b . -x /root/xdmod/tools/dev/code_coverage/start_xdebug.php -p /root/xdmod/tools/dev/code_coverage/combine_xdebug.php


exit 0:
