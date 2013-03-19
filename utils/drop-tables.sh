#!/bin/bash
MUSER="$1"
MPASS="$2"
MDB="$3"
MHOST="$4"

if [ "x$MHOST" == "x" ]; then
  MHOST="localhost"
fi

# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)
 
if [ $# -lt 3 ]
then
	echo "Usage: $0 {MySQL-User-Name} {MySQL-User-Password} {MySQL-Database-Name} [{MySQL-Database-Host}]"
	echo "Drops all tables from a MySQL database"
	exit 1
fi
 
TABLES=$($MYSQL -h $MHOST -u $MUSER -p$MPASS $MDB -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )
 
for t in $TABLES
do
	echo "Deleting $t table from $MDB database on $MHOST"
	$MYSQL -h $MHOST -u $MUSER -p$MPASS $MDB -e "SET FOREIGN_KEY_CHECKS = 0;DROP TABLE IF EXISTS $t;SET FOREIGN_KEY_CHECKS = 1;"
done
