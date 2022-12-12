#!/bin/bash -ex

# https://api.os.uk/downloads/v1/products/OpenNames/downloads?area=GB&format=CSV&redirect

if [ $# -eq 0 ]
  then
    echo "supply database name as argument"
    exit 1;
fi


cd $(dirname "$0")



mysql $1 < opennames_create.sql

for f in os_opennames/Data/* ; do mysql $1 -e "LOAD DATA LOCAL INFILE '$f' INTO TABLE opennames CHARACTER SET utf8mb4 COLUMNS TERMINATED by ',' OPTIONALLY ENCLOSED BY '\"';" ; done

mysql $1 < opennames_indexes.sql

