See [ngx_http_proxy_connect_module](https://github.com/chobits/ngx_http_proxy_connect_module) for details.

Testing auth with curl, and `user/pass` creds defined in ``/etc/nginx/.htpasswd``:
```
curl --proxy "http://${http_proxy:-localhost}:55161" --proxy-user 'user:pass' -kvL https://foo.bar.local
