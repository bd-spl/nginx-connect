FROM debian:latest
RUN apt -y update && apt -y install gcc make git curl libpcre3 libpcre3-dev zlib1g zlib1g-dev
RUN apt -y install libssl-dev && cd /var/tmp && \
git clone https://github.com/chobits/ngx_http_proxy_connect_module && cd ngx_http_proxy_connect_module && \
curl -L https://openresty.org/download/openresty-1.19.3.1.tar.gz > openresty-1.19.3.1.tar.gz && tar -zxvf openresty-1.19.3.1.tar.gz && \
cd openresty-1.19.3.1 && ./configure --add-module=/var/tmp/ngx_http_proxy_connect_module && \
patch -d build/nginx-1.19.3/ -p 1 < /var/tmp/ngx_http_proxy_connect_module/patch/proxy_connect_rewrite_101504.patch && \
make && make install && \
mkdir -p /var/log/nginx && ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log
CMD /usr/local/openresty/nginx/sbin/nginx
