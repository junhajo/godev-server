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
각 branch의 README 참고
* basic: 새 계정 생성
* advanced: 기존 계정을 재사용

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
