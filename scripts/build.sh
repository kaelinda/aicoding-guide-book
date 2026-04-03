#!/bin/bash

# ============================================
# 构建 GitBook 静态文件
# ============================================

set -e

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}======================================"
echo "   GitBook 构建"
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

# 构建
echo -e "${BLUE}[INFO]${NC} 构建 GitBook..."
gitbook build . _book

echo ""
echo -e "${GREEN}✅ 构建完成！${NC}"
echo ""
echo "📁 输出目录: _book/"
echo "📄 首页文件: _book/index.html"
echo ""
echo "下一步："
echo "  - 本地预览: cd _book && python -m http.server 8080"
echo "  - 部署到 GitHub Pages: 推送到 gh-pages 分支"
echo "  - 部署到服务器: 上传 _book 目录"
echo ""
