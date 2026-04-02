# `Godev-server`
Go 개발 서버

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
* basic: 새 계정 생성
* advanced: 기존 계정을 재사용

### 1. Git
```bash
$ git clone https://github.com/junhajo/godev-server.git
$ cd ./godev-server
$ git checkout advanced
$ git branch -a
* advanced
  basic
  main
  remotes/origin/HEAD -> origin/main
  remotes/origin/advanced
  remotes/origin/basic
  remotes/origin/main
```

```bash
$ tree ./
./
├── docker
│   ├── Dockerfile
│   └── etc
│       ├── group
│       ├── passwd
│       └── shadow
├── docker-compose.yaml
├── .env
├── .gitignore
├── LICENSE
├── README.md
└── svc.sh
```

* `./docker/etc/`
* group, passwd, shadow 파일을 복사
```bash
$ cp group ./docker/etc/
$ cp passwd ./docker/etc/
$ cp group ./docker/etc/
```

### 2. Dockerfile
* `./docker/Dockerfile`
* ./etc/ 디렉토리 COPY 확인
```vim
$ vi ./docker/Dockerfile
...
COPY ./etc /etc
```

### 3. Host volume 생성
```bash
$ mkdir -p ~/container/godev-server/home/<username>
$ mkdir -p ~/container/godev-server/home/go
```

```bash
$ sudo chown 5000:2000 ~/container/godev-server/home/
$ sudo chown 5000:2000 ~/container/godev-server/go/
$ ls -al ~/container/godev-server/
drwxr-xr-x 4 5000 2000 4096 Apr  2 15:32 home
drwxr-xr-x 4 5000 2000 4096 Apr  2 15:32 go
```

```bash
$ sudo chown 5000:2000 ~/container/godev-server/home/<username>
$ ls -al ~/container/godev-server/home/
drwxr-xr-x  2 5000 2000 4096 Apr  2 15:32 <username>
```

### 4. docker-compose.yaml
* `./docker-compose.yaml`
* image name
```yaml
    image: godev-server:${GO_VERSION}
```
* volumes
```yaml
    volumes:
    - ~/container/godev-server/home:/home
    - ~/container/godev-server/go:/go
```

### 5. .env
* `./.env`
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
