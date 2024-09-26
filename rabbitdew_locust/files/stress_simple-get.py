#!/usr/bin/env python3
# This locustfile makes a bunch of GET requests.
import time
from locust import FastHttpUser, task, between
class QuickstartUser(FastHttpUser):
    wait_time = between(1, 2)
    @task
    def index(self):
        self.client.get("/")
        self.client.get("/path2/")
        self.client.get("/path3/")
        self.client.get("/media-2/")

