-- check Proxy-Authorization for https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/407
local http_method = ngx.var.request_method
if not ngx.var.http_proxy_authorization and http_method == "CONNECT" then
        ngx.header["Proxy-Authenticate"] = "Basic realm=\"Access to internal site\""
        ngx.exit(407)
end

-- transfer Proxy-Authorization header to Authorization for auth basic module
if http_method == "CONNECT" then
        ngx.req.set_header("Authorization", ngx.var.http_proxy_authorization)
end
