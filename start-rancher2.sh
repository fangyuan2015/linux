#!/bin/bash
#description: install rancher2.0
docker run -d --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher
