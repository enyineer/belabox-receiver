This is an experimental image and is not optimized yet, it is VERY large.

    srtla_rec from https://github.com/BELABOX
    srt-live-transmit from https://github.com/BELABOX
    srt-live-server from https://gitlab.com/mattwb65/srt-live-server/
    noalbs for automatic bitrate switching from https://github.com/715209/nginx-obs-automatic-low-bitrate-switching

It requires the following ports to be published:

    5000:5000/udp
    8181/8181/tcp
    8282/8282/udp

Modify everything in bold below, then start with:
docker run -d --name belabox-receiver -p 5000:5000/udp -p 8181:8181/tcp -p 8282:8282/udp -v <path-to-noalbs-config.json>:/app/config.json kezzkezz/belabox-receiver:2.11.2

    Configure SRT receiver and SRT port within belabox to point to the docker container's IP address (or a port-forward on your router).
    Within Belabox, set "live/stream/belabox" as SRT streamid.
    To retrieve the SRT-Stream (via OBS, VLC etc.), open the following URL: srt://your-public-container-ip:8282/?streamid=play/stream/belabox
    Public Statistics-URL: http://your-public-container-ip:8181/stats
    Your noalbs config should contain the following - DO NOT change anything below.

    "rtmp": {
            "server": "srt-live-server",
            "stats": "http://127.0.0.1:8181/stats",
            "publisher": "live/stream/belabox"
    },


All Credit to rmoriz https://github.com/rmoriz/bbox-receiver/tree/noalbs2 all i did was change ARG to latest version of NOALBS
