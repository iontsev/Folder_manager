#!/bin/bash

echo "# UPDATE #" | tee --append "./out.log" 2>&1
echo "$(date +'%Y-%m-%d %H:%M:%S')" | tee --append "./out.log" 2>&1
source "./python/bin/activate"
pip install --upgrade pip | tee --append "./out.log" 2>&1
pip install --upgrade $(pip freeze | cut -d '=' -f 1) | tee --append "./out.log" 2>&1
deactivate

