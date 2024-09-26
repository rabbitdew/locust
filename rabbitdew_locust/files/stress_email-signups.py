#!/usr/bin/env python3
# This locustfile generates random email addresses, POSTs them
# to an API endpoint to simulate event signups, and logs them.

import json
import random
import socket
import time
from locust import FastHttpUser, task, between
myhostname = socket.gethostname()
class QuickstartUser(FastHttpUser):
    today = time.strftime("%Y-%m-%d", time.localtime())
    f = open('/tmp/locust-email_' + today + '_' + myhostname + '.csv','a')
    def on_start(self):
        """ on_start is called when a Locust start before any task is scheduled """
        if self.f.closed:
            self.today = time.strftime("%Y-%m-%d", time.localtime())
            self.f = open('/tmp/locust-email_' + today + '_' + myhostname + '.csv','a')
    def on_stop(self):
        """ on_stop is called when the TaskSet is stopping """
        self.f.close()

    wait_time = between(1, 5)
    @task
    def subscribe(self):
        mylist = '0123456789abcdefghijklmnopqrstuvwxyz'
        username = ''
        for i in range(22):
          username += random.choice(mylist)
        myemail = username + '@catchalldomain.com'
        print(myemail)
        payload={"email":myemail, "field2-key":"field2-value" }
        self.client.post("/someEndpoint", data=json.dumps(payload))
        self.f.write(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + ',' + myhostname + ' ' + myemail +'\n')
