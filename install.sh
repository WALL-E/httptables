#!/bin/bash

root=/apps/openresty

if [ $# != 1 ] ; then 
    echo "USAGE: $0 dir" 
    echo " e.g.: $0 /apps/openresty" 
    exit 1; 
else
    root=$1
fi 

cd `dirname $0`
./openresty-depends.sh
cd -

dir=$root/nginx/conf/httptables

if [ ! -x "$dir" ]; then
    OLD=`pwd`
    cd /tmp/
    wget https://openresty.org/download/openresty-1.9.15.1.tar.gz
    tar zxvf openresty-1.9.15.1.tar.gz
    cd openresty-1.9.15.1/
    ./configure --prefix=$root --with-http_realip_module 
    gmake
    gmake install
    cd $OLD
    mkdir $dir
fi

cat>startup.sh<<EOF
#!/bin/bash

cd $root/nginx/
sbin/nginx -c conf/nginx.conf
cd -
EOF
chmod +x startup.sh

cat>restart.sh<<EOF
#!/bin/bash

cd $root/nginx/
sbin/nginx -t && sbin/nginx -s reload
cd -
EOF
chmod +x restart.sh

/bin/cp -rf lua $dir
/bin/cp -f restart.sh $root/nginx/sbin/
/bin/cp -f startup.sh $root/nginx/sbin/
/bin/cp -f nginx.conf $root/nginx/conf/

echo "install to $dir: ok"
echo "run $root/nginx/sbin/startup.sh to start"
