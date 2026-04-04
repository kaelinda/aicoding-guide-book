#!/bin/bash

# ============================================
# 本地预览 GitBook
# ============================================

set -e

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}======================================"
echo "   GitBook 本地预览"
echo -e "======================================${NC}"
echo ""

# 检查 GitBook CLI
if ! command -v gitbook &> /dev/null; then
    echo -e "${BLUE}[INFO]${NC} 安装 GitBook CLI..."
    npm install -g gitbook-cli
fi

# 安装插件
echo -e "${BLUE}[INFO]${NC} 安装 GitBook 插件..."
if [ -f book.json ]; then
    gitbook install
fi

# 构建并预览
echo -e "${BLUE}[INFO]${NC} 启动本地服务器..."
echo ""
echo -e "${GREEN}✅ GitBook 已启动${NC}"
echo ""
echo "📖 访问地址: http://localhost:4000"
echo "🛑 按 Ctrl+C 停止"
echo ""

gitbook serve
