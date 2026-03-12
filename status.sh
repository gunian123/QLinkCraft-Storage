#!/bin/bash

# 检测系统架构
ARCH=$(uname -m)
case $ARCH in
    x86_64) ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    armv7l) ARCH="armv7" ;;
    *) echo "不支持的架构: $ARCH"; exit 1 ;;
esac

# 检测操作系统
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
case $OS in
    linux) OS="linux" ;;
    darwin) OS="darwin" ;;
    *) echo "不支持的系统: $OS"; exit 1 ;;
esac

# 设置镜像源和仓库
MIRROR="https://github.yuansi.xyz"
REPO="gunian123/QLinkCraft-Storage"

# 获取最新版本号
echo "正在获取最新版本..."
VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)

if [ -z "$VERSION" ]; then
    echo "无法获取最新版本，使用 latest"
    DOWNLOAD_URL="${MIRROR}/${REPO}/releases/latest/download/QLinkCraft-${OS}-${ARCH}"
else
    echo "最新版本: $VERSION"
    DOWNLOAD_URL="${MIRROR}/${REPO}/releases/download/${VERSION}/QLinkCraft-${OS}-${ARCH}"
fi

# 下载文件
echo "下载 QLinkCraft for ${OS}-${ARCH}..."
curl -L -o QLinkCraft "${DOWNLOAD_URL}"

# 设置执行权限
chmod +x QLinkCraft

echo "下载完成！"
