#!/bin/bash

cd /apps/openresty/nginx/
sbin/nginx -t && sbin/nginx -s reload
cd -
