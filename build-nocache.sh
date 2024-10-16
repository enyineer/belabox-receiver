#!/bin/bash

chmod +x check-files.sh
./check-files.sh

docker compose build --no-cache

echo "Successfully rebuilt your image"