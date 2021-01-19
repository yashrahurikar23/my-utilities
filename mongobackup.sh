#!/bin/sh

#Database Name ot backup
MONGO_DATABASE="customercli"

#Database host name
MONGO_HOST="127.0.0.1"

#Database port
MONGO_PORT="27017"

#Backup directory
BACKUPS_DIR="/var/backups/$MONGO_DATABASE"

# Database user name
DBUSERNAME=""

#Database password
DBPASSWORD=""

#Authentication database name
DBAUTBDB=""

#Days to keep the backup
DAYSTORETAINBACKUP="14"

TIMESTAMP=`date +%F-%H%M`
BACKUP_NAME="$MONGO_DATABASE-$TIMESTAMP"

echo "Performing backup of $MONGO_DATABASE"

echo "----------------------------------------------"

#Create backup directory
if ! mkdir -p $BACKUPS_DIR; then
        echo "Can't create backup directory in $BACKUPS_DIR. Go and fix it" 1>&2
        exit 1;
fi;
#Create dump
mongodump -db $MONGO_DATABASE --out $BACKUPS_DIR/$BACKUP_NAME

#Rename dump directory to backup name
#mv dump $BACKUP_NAME

#Compress backup
#tar -zcvf $BACKUPS_DIR/$BACKUP_NAME.tgz $BACKUP_NAME

#Delete uncocmpressed backup
#rm -rf $BACKUP_NAME

#Delete backups other than retendtion period
find $BACKUPS_DIR -type f -mtime +$DAYSTORETAINBACKUP -exec rm {} +

echo "----------------------------------------------"
echo "Database backup complete!"
