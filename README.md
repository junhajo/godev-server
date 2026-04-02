# `Godev-server`
Go 언어 개발 서버

## Host environment
* OS: ubuntu 22.04.5
* docker
* docker compose

## Container environment
* OS: ubuntu 22.04.5
* Go: v1.25.5
* GOPATH=/go/bin
* PATH=/usr/local/go/bin:$PATH

## Setup
### Dockerfile
* path: ./docker/Dockerfile
* UID/GID: 5000/2000 추천
```
ARG GO_VERSION=1.25.5 \
    UID=5000 \
    GID=2000
...
```

### docker-compose.yaml
* path: ./docker-compose.yaml
* change volumes
```
    volumes:
    - /home/jjuna/docker/container/godev-server/home:/home
    - /home/jjuna/docker/container/godev-server/go:/go
```

## Usage

```sh
# image build
$ ./svc build

#container run
$ ./svc run

# connect via ssh
$ ./svc ssh

# container stop
$ ./svc stop

# image remove
$ ./svc clean
```
