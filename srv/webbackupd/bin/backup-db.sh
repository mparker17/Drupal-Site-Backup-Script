#!/bin/bash
date=`date "+%Y-%m-%dT%H-%M-%S"`
remote_host='mysql.example.com'
remote_user='mysql_username'
remote_pass='mysql_password'
remote_shma='mysql_database'
temp_folder='/tmp'
destination="$HOME/backups/database"

# echo BEGIN database dump
mysqldump -h "$remote_host" -u "$remote_user" --password="$remote_pass" "$remote_shma" -r "$destination/$date.sql"
