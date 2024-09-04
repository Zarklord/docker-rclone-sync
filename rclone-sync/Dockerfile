FROM alpine:latest

MAINTAINER Zarklord

ARG TARGETPLATFORM

ENV INST_RCLONE_VERSION=current
ENV SYNC_DEST=
ENV SYNC_OPTS=-v
ENV RCLONE_OPTS="--config /config/rclone.conf --log-file /tmp/sync.log"
ENV CRON=
ENV CRON_ABORT=
ENV FORCE_SYNC=
ENV CHECK_URL=
ENV TZ=

RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; else ARCHITECTURE=arm64; fi \
    && apk -U add ca-certificates fuse wget dcron tzdata \
    && rm -rf /var/cache/apk/* \
    && cd /tmp \
    && wget -q http://downloads.rclone.org/rclone-${INST_RCLONE_VERSION}-linux-${ARCHITECTURE}.zip \
    && unzip /tmp/rclone-${INST_RCLONE_VERSION}-linux-${ARCHITECTURE}.zip \
    && mv /tmp/rclone-*-linux-${ARCHITECTURE}/rclone /usr/bin \
    && rm -r /tmp/rclone*

COPY entrypoint.sh /
COPY sync.sh /
COPY sync-abort.sh /

VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
