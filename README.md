> This is an experimental image and is not optimized yet.

# What you get

- srtla_rec from https://github.com/BELABOX
- srt-live-transmit from https://github.com/BELABOX
- srt-live-server from https://gitlab.com/mattwb65/srt-live-server/
- NOALBS for automatic bitrate switching from https://github.com/715209/nginx-obs-automatic-low-bitrate-switching

# Getting Started

## Check out this repository

```sh
$ git clone https://github.com/kezzkezzkezz/belabox-receiver.git
```

If you don't have Git installed on your machine, you can download this repository directly from [here](https://github.com/kezzkezzkezz/belabox-receiver/archive/refs/heads/main.zip).

## Firewall / Port Forwarding
Open the following ports in your firewall / router to make belabox-receiver available from outside of your private network:

- 5000:5000/udp
- 8181/8181/tcp (Optional, if you want your srt stats to be published)
- 8282/8282/udp

## Make the run script executable

> Only needs to be done after initial checkout

```sh
$ chmod +x run.sh
```

## Configuration

### NOALBS
- Configure NOALBS according to it's [Configuration Guide](https://github.com/NOALBS/nginx-obs-automatic-low-bitrate-switching?tab=readme-ov-file#configure-noalbs) and put your `config.json` and `.env` files into this folder

Make sure to set your streamServers Config to the following:

```json
    "streamServers": [
      {
        "streamServer": {
          "type": "SrtLiveServer",
          "statsUrl": "http://127.0.0.1:8181/stats",
          "publisher": "live/stream/belabox"
        },
        "name": "SRT Server",
        "priority": 0,
        "overrideScenes": null,
        "dependsOn": null,
        "enabled": true
      }
    ]
```

#### Connecting to OBS
If you want your belabox-receiver server to connect to your local OBS instance, do the following:

- Port-Forward your OBS's Websocket-Port `4455/tcp`
- Make sure to configure NOALBS to this port-forwarded port, eg:
```json
  "software": {
    "type": "Obs",
    "host": "<your obs ip / dyndns>",
    "password": "<your obs websocket password>",
    "port": 4455,
    "collections": {
      "twitch": {
        "profile": "twitch_profile",
        "collection": "twitch_scenes"
      }
    }
  },
```

> For this example to work, make sure you have created the configured Scenes (eg. "Starting") inside a scene collection named "twitch_scenes"

### BELABOX
- Configure SRT receiver and SRT port within belabox to point to the docker container's IP address (or a port-forward on your firewall / router).
- Within Belabox, set "live/stream/belabox" as SRT streamid.

### OBS / VLC
- To retrieve the SRT-Stream (via OBS, VLC etc.), open the following URL: srt://your-public-container-ip:8282/?streamid=play/stream/belabox

You can find your public Statistics-URL at http://your-public-container-ip:8181/stats

## Security

Please keep in mind that using the default Stream-ID "live/stream/belabox" and forwarding these ports to the internet is a potential security risk. Port-Scanners that find your SRT-Server can potential try out this default and hijack your stream.

We have added a utility-Script which helps you to generate a hard-to-guess Stream-ID. To use it, just run:

```sh
$ chmod +x generate-streamid.sh
$ ./generate-streamid.sh
```

This script will then give you your SRT(LA) Connection-string for your source (eg. Moblin) and your target (eg. OBS).

It will also give you a preconfigured "streamServers" configuration object for your NOALBS config.json file which you can just copy.

You can always regenerate this streamid to get a new "credential". However, also make sure then to reconfigure your source, target and NOALBS Config.

## Start your Belabox-Receiver Server

```sh
$ ./run.sh
```

# Updating

If a new version is released in this repository, make sure to run the `build-nocache.sh` script once after your `git pull` / download of the ZIP file:

```sh
$ chmod +x build-nocache.sh
$ ./build-nocache.sh
```

# Credit

All Credit to rmoriz for creating the now outdated noalbs-belabox-receiver package https://github.com/rmoriz/bbox-receiver/tree/noalbs2
