FROM golang:1.16.3-buster

WORKDIR /go/src/app/factoriocalc

RUN apt-get update && apt-get install liblua5.3-dev libzzip-dev lua5.3 luarocks -y
RUN luarocks install luafilesystem
RUN luarocks install luazip
RUN go get -u github.com/gobuffalo/packr/packr

COPY . /go/src/app

RUN go get
RUN packr build

VOLUME /factorio
VOLUME /mods

ENTRYPOINT factoriocalc -gamedir /factorio -moddir /mods -browser=false -verbose -http-addr :8080