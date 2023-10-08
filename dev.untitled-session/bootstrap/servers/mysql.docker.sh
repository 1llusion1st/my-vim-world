#!/bin/bash

tag=latest
password=my-secret-pw

if [[ $1 = "--help" ]]; then
    echo "usage: $0 [name port volume-path [password]]"
    exit 0
fi
if [[ $1 = "-h" ]]; then
    echo "usage: $0 [name port volume-path [password]]"
    exit 0
fi

if [[ $# -eq 5 ]]; then
    name=$1
    port=$2
    persistance_location=$3
    password=$4
    echo "creating private instance($persistance_location) with password $password"
    docker run --name $name -p$port:3306 -v $persistance_location:/var/lib/mysql \
        -e MYSQL_DATABASE=db \
        -e MYSQL_USER=user \
        -e MYSQL_PASSWORD=$password \
        -e MYSQL_ROOT_PASSWORD=$password \
        -d mysql:$tag
elif [[ $# -eq 4 ]]; then 
    name=$1
    port=$2
    persistance_location=$3
    echo "creating private($name) at 127.0.0.1:$port instance($persistance_location) with default password $password"
    docker run --name $name -p$port:3306 -v $persistance_location:/var/lib/mysql \
        -e MYSQL_DATABASE=db \
        -e MYSQL_USER=user \
        -e MYSQL_PASSWORD=$password \
        -e MYSQL_ROOT_PASSWORD=$password \
        -d mysql:$tag
else
    echo "creating dummy instance with default password and no volumes"

    docker run --rm -it -p3306:3306 \
        -e MYSQL_DATABASE=db \
        -e MYSQL_USER=user \
        -e MYSQL_PASSWORD=$password \
        -e MYSQL_ROOT_PASSWORD=$password \
        -d mysql:$tag
fi
