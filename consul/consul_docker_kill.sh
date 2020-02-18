#!/bin/sh
for h in `sudo docker ps -a | grep consul | cut -d' ' -f1`; do sudo docker stop $h && sudo docker rm $h; done
