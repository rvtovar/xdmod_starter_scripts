#!/bin/bash



echo "Running Test Suite"



docker exec -e XDMOD_TEST_MODE=fresh_install -w /root/xdmod xdmod /root/xdmod/tests/regression/runtests.sh


docker exec xdmod mv /root/xdmod/configuration/organization.json /root/xdmod/configuration/organization.json.old
docker exec xdmod mv /root/xdmod/configuration/portal_settings.ini /root/xdmod/configuration/portal_settings.ini.old
docker exec xdmod cp /etc/xdmod/portal_settings.ini /root/xdmod/configuration/portal_settings.ini
docker exec xdmod cp /etc/xdmod/organization.json /root/xdmod/configuration/organization.json


docker exec -w /root/xdmod xdmod /root/xdmod/tests/integration/runtests.sh --junit-output-dir /root/phpunit

docker exec -w /root/xdmod xdmod /root/xdmod/tests/unit/runtests.sh --junit-output-dir /root/phpunit

docker exec -w /root/xdmod xdmod /root/xdmod/tests/regression/post_ingest_test.sh --junit-output-dir /root/phpunit

docker exec -w /root/xdmod xdmod /root/xdmod/tests/component/runtests.sh --junit-output-dir /root/phpunit

docker exec xdmod sed -i 's/ServerName localhost/ServerName xdmod/g' /etc/httpd/conf.d/xdmod.conf

docker exec xdmod /root/bin/services restart

docker exec -w /root/xdmod/tests/playwright playwright /root/xdmod/tests/playwright/runtests.sh -j rocky8






exit 0
