FROM ubuntu:22.04

ARG GO_VERSION=1.25.5 \
    UID=5000 \
    GID=2000 \
    DEBIAN_FRONTEND=noninteractive

COPY ./etc /etc

RUN \
# 1. 패키지 설치
    apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:jonathonf/vim \
    && apt-get update && apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    iproute2 \
    iputils-ping \
    locales \
    net-tools \
    openssh-server \
    sudo \
    tcpdump \
    tzdata \
    vim \
    zsh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN \
# Go 1.25.5 설치
    curl -OL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

RUN \
# 1. 사용자(5000) 및 그룹(2000) 설정
    printf "#%s ALL=(ALL) NOPASSWD:ALL" "${UID}" > /etc/sudoers.d/super_user \
    && chmod 0440 /etc/sudoers.d/super_user \
# 2. SSH 서버 설정
    && mkdir /var/run/sshd \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
# 3. GOPATH 디렉토리 생성 및 권한 부여
    && mkdir -p /go && chown ${UID}:${GID} /go \
# 4. 두 가지 언어팩 모두 생성 (시스템 안정성 확보)
    && locale-gen en_US.UTF-8 \
    && locale-gen ko_KR.UTF-8 \
    && update-locale LANG=ko_KR.UTF-8 \
# 5. Docker ENV 유지
    && echo "GOPATH=/go" >> /etc/environment \
    && echo "LANG=ko_KR.UTF-8" >> /etc/environment \
    && echo "LC_ALL=ko_KR.UTF-8" >> /etc/environment \
    && sed -i 's|^PATH="|PATH="/usr/local/go/bin:/go/bin:|' /etc/environment \
# 6. vim-plug
    && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ENV GOPATH=/go \
    PATH=$PATH:/usr/local/go/bin:/go/bin \
    LANG=ko_KR.UTF-8 \
    LC_ALL=ko_KR.UTF-8

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
