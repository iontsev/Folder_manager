#!/bin/bash

echo "# DELETE #" | tee --append "./out.log" 2>&1
echo "$(date +'%Y-%m-%d %H:%M:%S')" | tee --append "./out.log" 2>&1
source "./python/bin/activate"
deactivate

