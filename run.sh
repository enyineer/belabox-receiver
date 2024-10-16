#!/bin/bash

chmod +x check-files.sh
./check-files.sh

docker compose build
docker compose up -d

echo "Successfully started your belabox-receiver Server, if you encounter any issues, please check the 'logs' folder."

# SLS stats page:
# http://localhost:8181/stats
#
# Belabox
# host: <ip>
# port: 5000
# stream-id: live/stream/belabox
#
# OBS MediaSource:
# srt://<ip>:8282/?streamid=play/stream/belabox
#
