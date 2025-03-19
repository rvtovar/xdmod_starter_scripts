!#/bin/bash
echo "Running the code grabbing"

rm -rf ~/Work/code_coverage/code_coverage

docker exec -w /root/xdmod xdmod /root/xdmod/tools/dev/code_coverage/codeCoverageProcess.sh -i /root/code_coverage_raw

docker exec -it xdmod sh -c "tar -czvf ~/code_coverage/report.tgz ~/code_coverage_raw"

docker cp xdmod:root/code_coverage ~/Work/code_coverage/



exit 0

