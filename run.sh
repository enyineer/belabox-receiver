#!/bin/bash

[ ! -f $PWD/config.json ] && echo "config.json missing! (see Configuration section of README)" && exit 1
[ ! -f $PWD/.env ] && echo ".env missing! (see Configuration section of README)" && exit 1

docker compose build
docker compose up -d

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
