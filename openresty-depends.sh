#!/bin/bash

rpm -qa|grep "epel-release" || yum -y install epel-release
rpm -qa|grep "pcre" || yum install -y pcre
rpm -qa|grep "pcre-devel" || yum install -y pcre-devel
rpm -qa|grep "openssl" || yum install -y openssl 
rpm -qa|grep "openssl-devel" || yum install -y openssl-devel
rpm -qa|grep "wget" || yum install -y wget

yum -y groupinstall development tools
