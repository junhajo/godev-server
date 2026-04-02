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

### 1. git
```bash
$ git clone https://github.com/junhajo/godev-server.git
$ cd ./godev-server
$ git checkout basic
$ git branch -a
  advanced
* basic
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
│   └── Dockerfile
├── docker-compose.yaml
├── .env
├── .gitignore
├── LICENSE
├── README.md
└── svc.sh
```

### 2. Dockerfile
* `./docker/Dockerfile`
* 계정 이름, UID, 기본 비밀번호 확인
* 그룹 이름, GID 확인
* 필요시 변경
```vim
$ vi ./docker/Dockerfile
...
    USERNAME=5gcf \
    GROUPNAME=core \
    UID=5000 \
    GID=2000
...
    && echo "${USERNAME}:contela" | chpasswd \
```
> [!IMPORTANT]
> 변경한 Dockerfile을 commit/push 하지 말 것!!!

### 3. host volume 생성
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
drwxr-xr-x  2 5000 2000 4096 Apr  2 15:32 5gcf
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
> [!TIP]
> 처음 접속한 경우 다음의 명령을 수행
```bash
$ passwd
$ cp /etc/skel/.bashrc /etc/skel/.profile .
$ source ./.bashrc
```
