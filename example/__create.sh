#!/bin/bash

echo "# CREATE #" | tee --append "./out.log" 2>&1
echo "$(date +'%Y-%m-%d %H:%M:%S')" | tee --append "./out.log" 2>&1
mkdir "./folder" | tee --append "./out.log" 2>&1
python3 -m venv 'python' | tee --append "./out.log" 2>&1
source "./python/bin/activate"
pip install --upgrade pip | tee --append "./out.log" 2>&1
pip install jupyterlab | tee --append "./out.log" 2>&1
deactivate

