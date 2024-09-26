#!/bin/sh
# This will remove all the worker containers. NOTE: removing the 
# master will also stop/remove all the workers. This script is
# for purging the workers and leaving the master in place.
docker ps | awk '/locust_worker/ { print $1}' | \
  while read container
    do
      echo "Removing container ${container}..."
      docker rm -f "${container}"
    done
