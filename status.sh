#!/bin/bash

# 检测系统架构和文件名
ARCH=$(uname -m)
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

case $OS in
    linux)
        case $ARCH in
            x86_64) ASSET="QLinkCraft_linux_amd64" ;;
            aarch64|arm64) ASSET="QLinkCraft_linux_arm64" ;;
            armv7l) ASSET="QLinkCraft_linux_arm" ;;
            *) echo "不支持的架构: $ARCH"; exit 1 ;;
        esac
        ;;
    *android*)
        ASSET="QLinkCraft_android_arm64"
        ;;
    *)
        echo "不支持的系统: $OS"
        exit 1
        ;;
esac

# 设置镜像源和仓库
MIRROR="https://github.yuansi.xyz"
REPO="gunian123/QLinkCraft-Storage"

# 获取最新版本号
echo "正在获取最新版本..."
VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)

if [ -z "$VERSION" ]; then
    echo "无法获取最新版本，使用 latest"
    DOWNLOAD_URL="${MIRROR}/https://github.com/${REPO}/releases/latest/download/${ASSET}"
else
    echo "最新版本: $VERSION"
    DOWNLOAD_URL="${MIRROR}/https://github.com/${REPO}/releases/download/${VERSION}/${ASSET}"
fi

# 下载文件
echo "下载 ${ASSET}..."
curl -L -o QLinkCraft "${DOWNLOAD_URL}"

# 设置最高权限
chmod 777 QLinkCraft
echo "启动命令 ./QLinkCraft"
echo "下载完成！正在启动..."
./QLinkCraft
