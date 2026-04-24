#!/bin/bash

# 변수 설정
#COMPOSE_FILE="docker-compose.yml"
#CONTAINER_NAME="godev-container"
#USER_UID=5000
#USER_GID=2000

# 헬프 메뉴
usage() {
    echo "Usage: $0 {build|run|stop|clean|re|ssh}"
    echo "  build : 이미지를 빌드합니다."
    echo "  run   : 컨테이너를 백그라운드에서 실행합니다."
    echo "  stop  : 컨테이너를 정지하고 삭제합니다."
    echo "  clean : 이미지와 컨테이너를 모두 삭제합니다."
    echo "  re    : 정지 -> 빌드 -> 실행을 한 번에 수행합니다."
    echo "  ssh   : 컨테이너에 SSH로 접속합니다."
    exit 1
}

# 1. Image Build
build_image() {
    echo "[INFO] Building godev Image..."
    docker compose build
}

# 2. Image Run (권한 설정 포함)
run_container() {
    echo "[INFO] Starting godev Container..."
    docker compose up -d --no-build
    docker compose ps
}

# 3. Image Stop & Remove
stop_container() {
    echo "[INFO] Stopping and Removing godev Container..."
    docker compose rm --force -v --stop
    docker compose down --remove-orphans
}

# 전체 삭제 (이미지 포함)
clean_all() {
    echo "[INFO] Cleaning up all resources..."
    docker compose down --rmi all
}

# 실행 로직 분기
case "$1" in
    build) build_image ;;
    run)   run_container ;;
    stop)  stop_container ;;
    clean) clean_all ;;
    re)    stop_container && build_image && run_container ;;
    ssh)   ssh localhost -p 26041 ;;
    *)     usage ;;
esac
