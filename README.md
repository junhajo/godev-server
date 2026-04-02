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
초기 setup시 1, 2, 5번은 반드시 실행

### 1. git
```bash
$ git clone https://github.com/junhajo/godev-server.git

$ tree ./godev-server
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

### 2. Dockerfile
### 2.1. 새로 계정과 그룹을 생성하는 경우
* `./docker/Dockerfile` 변경
* UID 5000, GID 2000 추천
```diff
ARG GO_VERSION=1.25.5 \
-    USERNAME=user \
-    GROUPNAME=group \
+    USERNAME=5gcf \
+    GROUPNAME=core \
    UID=5000 \
    GID=2000
...
-COPY ./etc /etc
+# COPY ./etc /etc
...
-    # groupadd -g ${GID} core \
-    # && useradd -m -u ${UID} -g core -s /bin/bash ${USERNAME} \
-    printf "#%s ALL=(ALL) NOPASSWD:ALL" "${UID}" > /etc/sudoers.d/super_user \
+    groupadd -g ${GID} core \
+    && useradd -m -u ${UID} -g core -s /bin/bash ${USERNAME} \
+    && printf "#%s ALL=(ALL) NOPASSWD:ALL" "${UID}" > /etc/sudoers.d/super_user \
```
> [!IMPORTANT]
> 변경한 Dockerfile을 commit/push 하지 말 것!!!

### 2.2. 기존 계정과 그룹을 사용하는 경우
* `./docker/etc/`
* group, passwd, shadow 파일을 복사
```bash
$ cp group ./docker/etc/
$ cp passwd ./docker/etc/
$ cp group ./docker/etc/
```
* `~/container/godev-server/home/<username>`
* 기존 계정의 home directory가 있는지 확인하고, 없으면 복사하거나 생성

### 3. docker-compose.yaml
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

### 4. .env
* `./.env`
* Go version & ssh port forwarding
```bash
$ cat ./.env
GO_VERSION=1.25.5
HOST_PORT=2603
```

### 5. host volume 생성
```bash
$ mkdir -p ~/container/godev-server/home/<username>
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
>
> cp /etc/skel/.bashrc /etc/skel/.profile .
