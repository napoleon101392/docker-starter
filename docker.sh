#!/bin/sh
docker start $(docker ps -aq)

clear

while read i; do
    docker exec $i service apache2 restart
    echo "$i" ... "\033[33mOK\033[0m"
done < apache.txt

while read i; do
    docker exec $i service nginx restart
    docker exec $i service php7.1-fpm restart
    docker exec $i service memcached start
    echo "$i" ... "\033[33mOK\033[0m"
done < nginx.txt

while read i; do
    docker exec $i service nginx restart
    docker exec $i service php7.2-fpm start
    docker exec $i service php7.2-fpm restart
done < nginx7-2.txt

while read i; do
    docker stop $i
    echo "$i" ... "STOPPED"
done < stop.txt

clear

docker ps -a
