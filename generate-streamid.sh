#!/bin/bash

RANDOM_STREAMID=$(shuf -er -n32  {A..Z} {a..z} {0..9} | tr -d '\n')

echo $RANDOM_STREAMID

echo "This utility will generate a random Stream-ID for you which prevents hijacking of your stream which could occur if you use the default "belabox" Stream-ID"
echo ""
echo "Use this SRT-Connection in your sending application (eg. Moblin):"
echo "srtla://<your-container-public-ip>:5000?streamid=live/stream/$RANDOM_STREAMID"
echo ""
echo "Use this SRT-Connection in your receiving application (eg. OBS):"
echo "srt://<your-container-public-ip>:8282/?streamid=play/stream/$RANDOM_STREAMID"
echo ""
echo "Use this streamServers configuration in your NOALBS's config.json:"
cat << EOF
    "streamServers": [
      {
        "streamServer": {
          "type": "SrtLiveServer",
          "statsUrl": "http://127.0.0.1:8181/stats",
          "publisher": "live/stream/$RANDOM_STREAMID"
        },
        "name": "SRT Server",
        "priority": 0,
        "overrideScenes": null,
        "dependsOn": null,
        "enabled": true
      }
    ]
EOF