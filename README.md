# docker-rclone
# Creds to bcardiff for the work for this docker container (this is a forked version)

Docker image to perform a [rclone](http://rclone.org) sync based on a cron schedule, with [healthchecks.io](https://healthchecks.io) monitoring.

rclone is a command line program to sync files and directories to and from:

* Google Drive
* Amazon S3
* Openstack Swift / Rackspace cloud files / Memset Memstore
* Dropbox
* Google Cloud Storage
* Amazon Drive
* Microsoft OneDrive
* Hubic
* Backblaze B2
* Yandex Disk
* SFTP
* FTP
* HTTP
* The local filesystem


## Usage

### Configure rclone

rclone needs a configuration file where credentials to access different storage
provider are kept.

By default, this image uses a file `/config/rclone.conf` and a mounted volume may be used to keep that information persisted.

A first run of the container can help in the creation of the file, but feel free to manually create one.

```
$ mkdir config
$ docker run --rm -it -v $(pwd)/config:/config zarklord/rclone-sync:latest
```

### Perform sync in a daily basis

A few environment variables allow you to customize the behavior of the sync:

* `SYNC_DEST` destination location for `rclone sync` command
* `CRON` crontab schedule `0 0 * * *` to perform sync every midnight
* `CRON_ABORT` crontab schedule `0 6 * * *` to abort sync at 6am
* `FORCE_SYNC` set variable to perform a sync upon boot
* `CHECK_URL` [healthchecks.io](https://healthchecks.io) url or similar cron monitoring to perform a `GET` after a successful sync
* `SYNC_OPTS` additional options for `rclone sync` command. Defaults to `-v`
* `TZ` set the [timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) to use for the cron and log `America/Argentina/Buenos_Aires`

```services:
  rclone:
    container_name: rclone
    image: zarklord/rclone-sync:latest
    restart: unless-stopped
    volumes:
      - /path/to/config/folder:/config
      - /path/to/sync/folder:/data
    environment:
      - SYNC_DEST="destination:folder"
      - CRON=0 0 * * *
      - CRON_ABORT=0 6 * * *
      - FORCE_SYNC=1
      - TZ=Etc/UTC
```

See [rclone sync docs](https://rclone.org/commands/rclone_sync/) for source/dest syntax and additional options.
