FROM alpine:latest

RUN apk add rclone --no-cache

COPY --chmod=0755 ./entrypoint.sh /entrypoint.sh
COPY --chmod=0755 ./sync.sh /sync.sh
COPY --chmod=0755 ./sync-abort.sh /sync-abort.sh

ENV SYNC_DEST= \
    SYNC_OPTS=-v \
    RCLONE_OPTS="--config /config/rclone.conf --log-file /tmp/sync.log" \
    CRON= \
    CRON_ABORT= \
    FORCE_SYNC= \
    CHECK_URL= \
    TZ=

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
