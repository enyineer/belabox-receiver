> [!NOTE]
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

> [!TIP]
> If you don't have Git installed on your machine, you can download this repository directly from [here](https://github.com/kezzkezzkezz/belabox-receiver/archive/refs/heads/main.zip).

## Make the scripts executable

> Only needs to be done after initial checkout

```sh
$ chmod +x run.sh generate-streamid.sh build-nocache.sh
```

## Configuration

### NOALBS
> [!NOTE]
> Configure NOALBS according to it's [Configuration Guide](https://github.com/NOALBS/nginx-obs-automatic-low-bitrate-switching?tab=readme-ov-file#configure-noalbs) and put your `config.json` and `.env` files into the checked out folder

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

#### Connecting NOALBS to OBS
If you want your belabox-receiver server to connect to your local OBS instance, do the following:

Enable your OBS Websocket-Server:
- Click on the Tools menu
- Click on obs-websocket Settings
- Enable authentication and set your own password

Setup NOALBS:
- Port-Forward your OBS's Websocket-Port, per default `4455:4455/tcp`
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

> [!TIP]
> For this example to work, make sure you have created the configured NOALBS Scenes (eg. "Starting") inside a OBS scene collection named "twitch_scenes"
>
> See [this article](https://obsproject.com/kb/scene-collections) for more info about Scene Collections in OBS

### Sender (BELABOX / Moblin / IRL Pro)

#### Belabox
- Configure SRT receiver and SRT port within belabox to point to the docker container's public IP address
- Within Belabox, set "live/stream/belabox" as SRT streamid.

#### Moblin / IRL Pro
- Configure the following SRTLA-Connection to your belabox-receiver server: `srtla://<your-container-public-ip>:5000?streamid=live/stream/belabox`

### Receiver (OBS / VLC)
- To retrieve the SRT-Stream (via OBS, VLC etc.), open the following URL: `srt://<your-container-public-ip>:8282/?streamid=play/stream/belabox`

### Stats
You can find your public Statistics-URL at `http://<your-container-public-ip>:8181/stats`

## Security
> [!CAUTION]
> Please keep in mind that using the default Stream-ID `live/stream/belabox` and forwarding your ports to the internet is a potential security risk. Port-Scanners that find your SRT-Server can potentially try out this default and hijack your stream.

We have added a utility-Script which helps you to generate a hard-to-guess Stream-ID. To use it, just run:

```sh
$ ./generate-streamid.sh
```

This script will then give you your SRT(LA) Connection-string for your sender (eg. Moblin / IRL Pro / Belabox) and your receiver (eg. OBS).

It will also give you a preconfigured "streamServers" configuration object for your NOALBS config.json file which you can just copy.

You can always regenerate this streamid to get a new "credential". However, also make sure then to reconfigure your source, target and NOALBS Config.

## Firewall / Port Forwarding
Open the following ports in your firewall / router to make belabox-receiver available from outside of your private network:

- 5000:5000/udp
- 8282:8282/udp

> [!CAUTION]
> Port-forwarding `8181:8181/tcp` is optional.
> 
> This is a security risk as it exposes your confidential Stream-ID to the internet!
>
> If you're running this container on a public VPS, make sure to enable a firewall (eg. `ufw`) to block public access to this port and only allow the ports mentioned above.

## Start your Belabox-Receiver Server

```sh
$ ./run.sh
```

# Updating

If a new version is released in this repository, make sure to run the `build-nocache.sh` script once after your `git pull` / download of the ZIP file:

```sh
$ ./build-nocache.sh
```

# Credit

All Credit to rmoriz for creating the now outdated noalbs-belabox-receiver package https://github.com/rmoriz/bbox-receiver/tree/noalbs2
