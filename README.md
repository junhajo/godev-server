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
### 1. git
```bash
$ git clone https://github.com/junhajo/godev-server.git
```

### 2. Dockerfile
* path: ./docker/Dockerfile
* UID/GID: 5000/2000 추천
```
ARG GO_VERSION=1.25.5 \
    UID=5000 \
    GID=2000
...
```
* ssh port: 22
```
EXPOSE 22
```

### 3. docker-compose.yaml
* path: ./docker-compose.yaml
* image name
```
    image: godev-server:${GO_VERSION}
```
* volumes
```
    volumes:
    - /home/jjuna/docker/container/godev-server/home:/home
    - /home/jjuna/docker/container/godev-server/go:/go
```

### 4. .env
* .env path: ./.env
* Go version & ssh port forwarding
```bash
$ cat ./.env
GO_VERSION=1.25.5
HOST_PORT=2603
```

## Usage
```bash
# image build
$ ./svc build

# container run
$ ./svc run

# local access via ssh
$ ./svc ssh

# external access via ssh
$ ssh <host-ip> -p 2603

# container stop
$ ./svc stop

# image remove
$ ./svc clean
```
