# api.addressbook

api.addressbook.g0v.tw endpoint source and utiltity scripts.

demo site: [http://pgrest.io/hychen/api.addressbook/v0/collections/](http://pgrest.io/hychen/api.addressbook/v0/collections/)

## Installation 

Install Postgresql 9.3 in your laptop and the run the following instructions:

```
$ git clone https://github.com/g0v/api.addressbook
$ cd api.addressbook && npm i
$ createdb testdb
$ lsc app.lsc --db testdb
```

### Demo Box

#### Docker

get an image.

```
$ docker pull hychen/api.addressbook
```

start service.

```
$ docker run -d -p 8888:80 hychen/api.addressbook /sbin/my_init
```

### Vagrant

bootstrap vagrant box.

```
$ cd cookbooks/addressbook.g0v.tw && vagrant up
```

## Play with the server

```
$ curl 0.0.0.0:8888/v0/collections/
```
