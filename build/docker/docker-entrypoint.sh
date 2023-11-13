#!/bin/sh

command=$1

if [ $command = "start" ]; then
    export config=\$config
    envsubst < /fbcallrouter/build/docker/docker-config.php > config.php
    php fbcallrouter run
else
    exec "$@"
fi