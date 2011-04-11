# Setting up the Drupal Site Backup Script #

## 1: Make user and home directory ##

As root, run:

    useradd -b /srv -c "User for the website backup daemon" -m -r -s /bin/sh webbackupd


## 2: Copy binaries and directory structure, initialize some log files ##

As root, run:

    cp -r srv/webbackupd/backups /srv/webbackupd/backups
    cp -r srv/webbackupd/bin /srv/webbackupd/bin
    touch /var/log/webbackupd-db-error.log
    touch /var/log/webbackupd-fs-error.log


## 3: Set permissions properly ##

As root, run:

    chown -R webbackupd:admin /srv/webbackupd
    chown webbackupd:admin /var/log/webbackupd-db-error.log
    chown webbackupd:admin /var/log/webbackupd-fs-error.log
    chmod ug+x /srv/webbackupd/bin/backup-fs.sh
    chmod ug+x /srv/webbackupd/bin/backup-db.sh


## 4: Set up cron so that it backs up the site regularly without your intervention ##

As webbackupd, run

    crontab -e

Set the contents of the file as follows:

    # m  h     dom mon dow   command
      0  8,18   *   *   *    /srv/webbackupd/bin/backup-db.sh 2>> /var/log/webbackupd-db-error.log
     30  0      *   *   1    /srv/webbackupd/bin/backup-fs.sh 2>> /var/log/webbackupd-fs-error.log

