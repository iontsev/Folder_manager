#!/bin/bash

echo "# ATTACH #" | tee --append "./out.log" 2>&1
echo "$(date +'%Y-%m-%d %H:%M:%S')" | tee --append "./out.log" 2>&1
source "./python/bin/activate"
nohup jupyter lab --no-browser --notebook-dir="./folder" --ip=0.0.0.0 --port=9876 | tee --append "./out.log" 2>&1 &
echo "${!}" | tee --append "./pid.key" 2>&1
sleep 1
echo "$(cat ./screen/$(date +'%Y-%m-%d').log | grep -B5 'token')" | tail -n 5 | grep -B5 'token' | tee --append "./url.key" 2>&1
deactivate

