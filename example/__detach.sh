#!/bin/bash

echo "# DETACH #" | tee --append "./out.log" 2>&1
echo "$(date +'%Y-%m-%d %H:%M:%S')" | tee --append "./out.log" 2>&1
source "./python/bin/activate"
ps aux | grep -e 'jupyter' | cut -d ' ' -f 2 | xargs kill --KILL | tee --append "./out.log" 2>&1
cat "./pid.key" | xargs kill --KILL | tee --append "./out.log" 2>&1
rm "./pid.key" | tee --append "./out.log" 2>&1
deactivate

