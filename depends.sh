#!/bin/bash

sudo yum -y install epel-release
sudo yum -y groupinstall development tools
sudo yum install -y pcre pcre-devel
sudo yum install -y openssl openssl-devel
