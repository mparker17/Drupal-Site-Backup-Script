#!/bin/sh
date=`date "+%Y-%m-%dT%H-%M-%S"`
remote_ptcl='ftp://'
remote_host='ftp.example.com'
remote_path='/public_html'
remote_user='ftp_user'
remote_pass='ftp_password'
temp_folder='/tmp' # on the local machine
temp_source="$temp_folder/$remote_host"
destination="$HOME/backups/filesystem"

# echo BEGIN change to temp folder
cd $temp_folder

# echo BEGIN get remote files
wget -q -m -t 10 --user="$remote_user" --password="$remote_pass" "$remote_ptcl$remote_host$remote_path"

# echo BEGIN rsync
rsync -aP --link-dest="$destination/current" "$temp_source" "$destination/$date"

# Reset the current symlink
# echo BEGIN remove current symlink
rm -f "$destination/current"
# echo BEGIN create new current symlink
ln -s "$destination/$date" "$destination/current"

# Remove our temporary cache of files created by wget
# echo BEGIN remove temporary cache of remote files
rm -Rf "$temp_source"

