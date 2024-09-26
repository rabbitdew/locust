#!/bin/sh
set -x
[ $1 == 'email' ] && STRESS_SCRIPT=stress_email-signups.py
[ $1 == 'get' ] && STRESS_SCRIPT=stress_simple-get.py

docker run \
  -v /usr/local/bin/locust-files:/mnt/locust:ro \
  --name=locust_master \
  --rm \
  -p 5557:5557 \
  -p 8089:8089 \
  locustio/locust \
  -f /mnt/locust/${STRESS_SCRIPT} \
  --master 2>&1 | tee -a locust.log
