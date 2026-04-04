#!/bin/bash

# ============================================
# AI 编程环境一键安装脚本
# 适用于 macOS
# ============================================

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查是否为 macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "此脚本仅支持 macOS"
        exit 1
    fi
    log_success "检测到 macOS 系统"
}

# 安装 Homebrew
install_homebrew() {
    log_info "检查 Homebrew..."
    
    if command -v brew &> /dev/null; then
        log_success "Homebrew 已安装"
        brew --version
    else
        log_info "正在安装 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # 添加到 PATH（Apple Silicon）
        if [[ $(uname -m) == 'arm64' ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        
        log_success "Homebrew 安装完成"
    fi
}

# 安装 nvm
install_nvm() {
    log_info "检查 nvm..."
    
    if command -v nvm &> /dev/null; then
        log_success "nvm 已安装"
        nvm --version
    else
        log_info "正在安装 nvm..."
        
        # 下载并安装 nvm
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        
        # 添加到配置文件
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        log_success "nvm 安装完成"
    fi
}

# 安装 Node.js
install_nodejs() {
    log_info "检查 Node.js..."
    
    if command -v node &> /dev/null; then
        log_success "Node.js 已安装"
        node --version
        npm --version
    else
        log_info "正在安装 Node.js LTS..."
        
        # 使用 nvm 安装最新 LTS 版本
        source ~/.nvm/nvm.sh
        nvm install --lts
        nvm use --lts
        nvm alias default lts/*
        
        log_success "Node.js 安装完成"
    fi
}

# 配置 Git
configure_git() {
    log_info "检查 Git..."
    
    if command -v git &> /dev/null; then
        log_success "Git 已安装"
        git --version
    else
        log_info "正在安装 Git..."
        brew install git
        log_success "Git 安装完成"
    fi
    
    # 检查 Git 配置
    if [ -z "$(git config --global user.name)" ]; then
        log_warning "Git 用户名未配置"
        read -p "请输入你的名字: " git_name
        git config --global user.name "$git_name"
    fi
    
    if [ -z "$(git config --global user.email)" ]; then
        log_warning "Git 邮箱未配置"
        read -p "请输入你的邮箱: " git_email
        git config --global user.email "$git_email"
    fi
    
    log_success "Git 配置完成"
}

# 安装常用工具
install_tools() {
    log_info "安装常用开发工具..."
    
    # 安装 wget
    if ! command -v wget &> /dev/null; then
        brew install wget
    fi
    
    # 安装 jq（JSON 处理）
    if ! command -v jq &> /dev/null; then
        brew install jq
    fi
    
    log_success "常用工具安装完成"
}

# 验证环境
verify_environment() {
    log_info "验证开发环境..."
    
    echo ""
    echo "======================================"
    echo "       环境验证报告"
    echo "======================================"
    echo ""
    
    # 检查 Homebrew
    if command -v brew &> /dev/null; then
        echo -e "✅ Homebrew: $(brew --version | head -1)"
    else
        echo -e "❌ Homebrew: 未安装"
    fi
    
    # 检查 nvm
    if command -v nvm &> /dev/null || [ -s "$HOME/.nvm/nvm.sh" ]; then
        echo -e "✅ nvm: 已安装"
    else
        echo -e "❌ nvm: 未安装"
    fi
    
    # 检查 Node.js
    if command -v node &> /dev/null; then
        echo -e "✅ Node.js: $(node --version)"
        echo -e "✅ npm: $(npm --version)"
    else
        echo -e "❌ Node.js: 未安装"
    fi
    
    # 检查 Git
    if command -v git &> /dev/null; then
        echo -e "✅ Git: $(git --version)"
        git_name=$(git config --global user.name)
        git_email=$(git config --global user.email)
        if [ -n "$git_name" ] && [ -n "$git_email" ]; then
            echo -e "   用户: $git_name <$git_email>"
        fi
    else
        echo -e "❌ Git: 未安装"
    fi
    
    echo ""
    echo "======================================"
    
    # 统计
    total=4
    installed=0
    
    command -v brew &> /dev/null && ((installed++))
    (command -v nvm &> /dev/null || [ -s "$HOME/.nvm/nvm.sh" ]) && ((installed++))
    command -v node &> /dev/null && ((installed++))
    command -v git &> /dev/null && ((installed++))
    
    if [ $installed -eq $total ]; then
        log_success "所有核心工具已安装 ($installed/$total)"
    else
        log_warning "部分工具未安装 ($installed/$total)"
    fi
}

# 主函数
main() {
    echo ""
    echo "======================================"
    echo "   AI 编程环境一键安装脚本"
    echo "======================================"
    echo ""
    
    check_macos
    
    log_info "开始安装..."
    echo ""
    
    install_homebrew
    echo ""
    
    install_nvm
    echo ""
    
    install_nodejs
    echo ""
    
    configure_git
    echo ""
    
    install_tools
    echo ""
    
    verify_environment
    echo ""
    
    log_success "安装完成！"
    echo ""
    echo "下一步："
    echo "1. 重启终端或运行: source ~/.zshrc"
    echo "2. 验证环境: node -v && npm -v"
    echo "3. 安装 AI 工具: 访问基础篇第二章"
    echo ""
}

# 运行主函数
main
