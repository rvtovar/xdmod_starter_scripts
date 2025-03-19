#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <container_name> <work_directory_path> <port_number>"
    exit 1
fi

# Assign arguments to variables
CONTAINER_NAME=$1
WORK_DIR_PATH=$2
PORT_NUMBER=$3

# Run the Docker command with the provided arguments
docker run -it \
--rm \
--name "$CONTAINER_NAME" \
-v "$WORK_DIR_PATH:/root/xdmod" \
-v ~/scratch:/scratch \
-p "$PORT_NUMBER:443" \
tools-int-01.ccr.xdmod.org/xdmod:aarch64-rockylinux8.9.20231119-v11.0.0-1.0-04 /bin/bash
