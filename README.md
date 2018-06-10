# mruby-remote-checker-api

This is a tool to create an API server to check communication on various layers.

Currently implemented are the following:

  * L3
    - ICMP (using [matsumotory/mruby-fast-remote-check](https://github.com/matsumotory/mruby-fast-remote-check) `FastRemoteCheck::ICMP`)
  * L4
    - Port Number (using [matsumotory/mruby-fast-remote-check](https://github.com/matsumotory/mruby-fast-remote-check) `FastRemoteCheck`)


### example

- code

  for ICMP

  ```ruby
  url = "http://localhost/?ipaddr=8.8.8.8&timeout=1&max_tries=2"
  # or /?ipaddr=8.8.8.8&timeout=1&max_tries=2

  puts RemoteChecker::ICMP.new(url).execute
  ```

  for Port Number

  ```ruby
  url = "http://localhost/?ipaddr=8.8.8.8&port=53&timeout=1&max_tries=2"

  puts RemoteChecker::Port.new(url).execute
  ```


- response 

  JSON format

  ```
  {
    "status":true,
    "error":""
  }
  ```

  for error

  ```
  {
    "status":false,
    "error":"error string"
  }
  ```

### example for ngx_mruby

- nginx.conf

  ```
  server {
    listen 443 ssl default_server;
    server_name localhost;

    location /icmp {
      mruby_content_handler_code 'Nginx.echo RemoteChecker::ICMP.new(Nginx::Request.new.unparsed_uri).execute';
    }

    location /port {
      mruby_content_handler_code 'Nginx.echo RemoteChecker::Port.new(Nginx::Request.new.unparsed_uri).execute';
    }
  }
  ```

- request

  ```
  https://localhost/icmp/?ipaddr=8.8.8.8
  https://localhost/port/?ipaddr=8.8.8.8&port=53
  ```
