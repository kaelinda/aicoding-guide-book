#!/bin/bash

# ============================================
# 环境验证脚本
# ============================================

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo "======================================"
echo "      开发环境验证报告"
echo "======================================"
echo ""

# 1. 检查 Homebrew
echo -e "${BLUE}[1/5] 检查 Homebrew...${NC}"
if command -v brew &> /dev/null; then
    brew_version=$(brew --version | head -1)
    echo -e "   ${GREEN}✅${NC} $brew_version"
else
    echo -e "   ${RED}❌ 未安装${NC}"
    echo "   安装: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
fi
echo ""

# 2. 检查 nvm
echo -e "${BLUE}[2/5] 检查 nvm...${NC}"
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    source "$HOME/.nvm/nvm.sh"
    nvm_version=$(nvm --version)
    echo -e "   ${GREEN}✅${NC} nvm $nvm_version"
else
    echo -e "   ${RED}❌ 未安装${NC}"
    echo "   安装: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash"
fi
echo ""

# 3. 检查 Node.js
echo -e "${BLUE}[3/5] 检查 Node.js...${NC}"
if command -v node &> /dev/null; then
    node_version=$(node --version)
    npm_version=$(npm --version)
    echo -e "   ${GREEN}✅${NC} Node.js $node_version"
    echo -e "   ${GREEN}✅${NC} npm $npm_version"
    
    # 检查版本是否符合要求
    major_version=$(echo $node_version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ $major_version -ge 18 ]; then
        echo -e "   ${GREEN}✅${NC} 版本符合要求 (≥ v18)"
    else
        echo -e "   ${YELLOW}⚠️${NC} 建议升级到 v18+"
    fi
else
    echo -e "   ${RED}❌ 未安装${NC}"
    echo "   安装: nvm install --lts"
fi
echo ""

# 4. 检查 Git
echo -e "${BLUE}[4/5] 检查 Git...${NC}"
if command -v git &> /dev/null; then
    git_version=$(git --version)
    echo -e "   ${GREEN}✅${NC} $git_version"
    
    # 检查配置
    git_name=$(git config --global user.name)
    git_email=$(git config --global user.email)
    
    if [ -n "$git_name" ] && [ -n "$git_email" ]; then
        echo -e "   ${GREEN}✅${NC} 用户: $git_name <$git_email>"
    else
        echo -e "   ${YELLOW}⚠️${NC} 用户信息未配置"
        echo "   配置: git config --global user.name \"你的名字\""
        echo "   配置: git config --global user.email \"你的邮箱\""
    fi
else
    echo -e "   ${RED}❌ 未安装${NC}"
    echo "   安装: brew install git"
fi
echo ""

# 5. 检查 SSH 密钥
echo -e "${BLUE}[5/5] 检查 SSH 密钥...${NC}"
if [ -f "$HOME/.ssh/id_ed25519" ] || [ -f "$HOME/.ssh/id_rsa" ]; then
    echo -e "   ${GREEN}✅${NC} SSH 密钥已存在"
    ls -la ~/.ssh/*.pub 2>/dev/null | awk '{print "      " $NF}'
else
    echo -e "   ${YELLOW}⚠️${NC} SSH 密钥不存在"
    echo "   生成: ssh-keygen -t ed25519 -C \"你的邮箱\""
fi
echo ""

# 总结
echo "======================================"
echo ""

total=5
passed=0

command -v brew &> /dev/null && ((passed++))
[ -s "$HOME/.nvm/nvm.sh" ] && ((passed++))
command -v node &> /dev/null && ((passed++))
command -v git &> /dev/null && ((passed++))
([ -f "$HOME/.ssh/id_ed25519" ] || [ -f "$HOME/.ssh/id_rsa" ]) && ((passed++))

if [ $passed -eq $total ]; then
    echo -e "${GREEN}🎉 恭喜！所有检查通过 ($passed/$total)${NC}"
    echo ""
    echo "下一步："
    echo "  → 安装 AI 编程工具: 基础篇/02-工具安装"
    echo "  → 开始第一个项目: 基础篇/03-第一个项目"
elif [ $passed -ge 3 ]; then
    echo -e "${YELLOW}⚠️ 环境基本就绪 ($passed/$total)${NC}"
    echo ""
    echo "建议："
    echo "  → 完成剩余工具的安装"
    echo "  → 重新运行此脚本验证"
else
    echo -e "${RED}❌ 环境需要配置 ($passed/$total)${NC}"
    echo ""
    echo "建议："
    echo "  → 运行一键安装脚本: ./scripts/setup.sh"
    echo "  → 或按上述提示手动安装"
fi

echo ""
