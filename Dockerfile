FROM debian:latest
RUN apt -y update && apt -y install gcc make git curl libpcre3 libpcre3-dev zlib1g zlib1g-dev
RUN cd /var/tmp && git clone https://github.com/chobits/ngx_http_proxy_connect_module && cd ngx_http_proxy_connect_module && curl -L http://nginx.org/download/nginx-1.18.0.tar.gz > nginx-1.18.0.tar.gz && tar -xzvf nginx-1.18.0.tar.gz && cd nginx-1.18.0/ && curl -L https://raw.githubusercontent.com/chobits/ngx_http_proxy_connect_module/master/patch/proxy_connect_rewrite_1018.patch > proxy_connect_rewrite_1018.patch && patch -p1 < proxy_connect_rewrite_1018.patch && ./configure --add-dynamic-module=../ && make && make install
RUN mkdir -p /var/log/nginx && ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log
CMD /usr/local/nginx/sbin/nginx
