#!/bin/bash

[ ! -f $PWD/config.json ] && echo "config.json missing! (see Configuration section of README)" && exit 1
[ ! -f $PWD/.env ] && echo ".env missing! (see Configuration section of README)" && exit 1