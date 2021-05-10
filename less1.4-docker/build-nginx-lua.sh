#!/bin/bash

mkdir nginx-lua 
cd nginx-lua

echo 1. get distrs..
wget -qc http://nginx.org/download/nginx-1.20.0.tar.gz 
wget -qc https://github.com/openresty/luajit2/archive/refs/tags/v2.1-20201229.tar.gz
wget -qc https://github.com/vision5/ngx_devel_kit/archive/refs/tags/v0.3.1.tar.gz
wget -qc https://github.com/openresty/lua-nginx-module/archive/refs/tags/v0.10.19.tar.gz

echo 2. unpack
tar -xf v0.10.19.tar.gz && LUANGINX_PATH=lua-nginx-module-0.10.19
tar -xf v0.3.1.tar.gz && DEVNGINX_PATH=ngx_devel_kit-0.3.1
tar -xf  v2.1-20201229.tar.gz && LUA_PATH=&& NGINX_PATH=luajit2-2.1-20201229
tar -xf nginx-1.20.0.tar.gz && NGINX_PATH=nginx-1.20.0

echo 3. build luajit
cd $LUA_PATH
make -j4 install

echo 4. build nginx
cd $NGINX_PATH
LUAJIT_LIB=/usr/local/lib LUAJIT_INC=/usr/local/include/luajit-2.1 \
./configure \
--user=nobody                          \
--group=nobody                         \
--prefix=/etc/nginx                   \
--sbin-path=/usr/sbin/nginx           \
--conf-path=/etc/nginx/nginx.conf     \
--pid-path=/var/run/nginx.pid         \
--lock-path=/var/run/nginx.lock       \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module        \
--with-http_stub_status_module        \
--with-http_ssl_module                \
--with-pcre                           \
--with-file-aio                       \
--with-http_realip_module             \
--without-http_scgi_module            \
--without-http_uwsgi_module           \
--without-http_fastcgi_module ${NGINX_DEBUG:+--debug} \
--with-cc-opt=-O2 --with-ld-opt='-Wl,-rpath,/usr/local/lib' \
--add-module=../ngx_devel_kit-0.3.1 \
--add-module=../lua-nginx-module-0.10.19
