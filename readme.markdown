# Server-Sent Events

[Github project: sinatra_sse_02](https://github.com/CootCraig/sinatra_sse_02)

## Run With JRuby and Trinidad Server

    $ bundle exec ruby --1.9 --debug -S trinidad

## Stand Alone test with curl

### Celluloid actor based server-sent events

    $ curl -i http://localhost:4000/actor/bubba

#### Output

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    X-Frame-Options: sameorigin
    X-XSS-Protection: 1; mode=block
    Transfer-Encoding: chunked
    Content-Type: text/event-stream;charset=utf-8
    Transfer-Encoding: chunked
    Date: Wed, 14 Dec 2011 23:20:09 GMT

    data: {"source":"actor","time":"2011-12-14 15:20:09 -0800","id":"bubba"}

    data: {"source":"actor","time":"2011-12-14 15:20:14 -0800","id":"bubba"}

    data: {"source":"actor","time":"2011-12-14 15:20:22 -0800","id":"bubba"}

### Timer based server-sent events

    $ curl -i http://localhost:4000/timer/A_Label

#### Output

    HTTP/1.1 200 OK
    Server: Apache-Coyote/1.1
    X-Frame-Options: sameorigin
    X-XSS-Protection: 1; mode=block
    Transfer-Encoding: chunked
    Content-Type: text/event-stream;charset=utf-8
    Transfer-Encoding: chunked
    Date: Thu, 15 Dec 2011 00:21:06 GMT

    data: {"source":"timer","id":"A_Label","loop":1}

    data: {"source":"timer","id":"A_Label","loop":2}

    data: {"source":"timer","id":"A_Label","loop":3}


