#!/bin/bash

root=/apps/openresty

dir=$root/nginx/conf/httptables

if [ ! -x "$dir"]; then
    mkdir $dir
fi

/bin/cp -rf ci $dir
/bin/cp -rf lua $dir
/bin/cp -f restart.sh $dir
/bin/cp -f startup.sh $dir
/bin/cp -f nginx.conf $root/nginx/conf/
