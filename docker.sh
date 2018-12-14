#!/bin/sh
docker start $(docker ps -a)

clear

while read i; do
    docker exec $i service apache2 restart
    echo "$i" ... "\033[33mOK\033[0m"
done < apache.txt

while read i; do
    docker exec $i service nginx restart
    echo "$i" ... "\033[33mOK\033[0m"
done < nginx.txt

while read i; do
    docker stop $i
    echo "$i" ... "STOPPED"
done < stop.txt

clear

docker ps -a
