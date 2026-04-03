# 快速开始

> 5 分钟快速体验 AI 编程

## 🚀 一键安装环境

如果你是 macOS 用户，可以使用我们的一键安装脚本：

```bash
# 下载并运行安装脚本
curl -fsSL https://raw.githubusercontent.com/kaelinda/aicoding-guide-book/main/scripts/setup.sh | bash

# 或克隆仓库后运行
git clone https://github.com/kaelinda/aicoding-guide-book.git
cd aicoding-guide-book
./scripts/setup.sh
```

**安装内容**：
- ✅ Homebrew（包管理器）
- ✅ nvm（Node.js 版本管理）
- ✅ Node.js LTS（运行环境）
- ✅ Git（版本控制）
- ✅ 常用开发工具

**预计时间**：10-15 分钟

---

## ✅ 验证环境

安装完成后，验证环境是否正常：

```bash
# 运行验证脚本
./scripts/verify.sh

# 或手动验证
node -v    # 应显示 v18+
npm -v     # 应显示 9+
git --version  # 应显示 git version 2.x
```

---

## 🎯 快速体验 AI 编程

### 方案 A：Claude Code（推荐）

```bash
# 安装 Claude Code
npm install -g @anthropic-ai/claude-code

# 启动
claude

# 第一次运行会提示登录
# 按 Enter 打开浏览器登录 Claude 账号
```

**试用示例**：
```
你：创建一个简单的 Swift 结构体，表示一个用户，包含 id、name、email

Claude：
[生成代码]
struct User {
    let id: UUID
    var name: String
    var email: String
}
```

### 方案 B：Cursor（最简单）

```bash
# 下载 Cursor
open https://cursor.sh

# 安装后打开
# 按 Cmd + L 打开 AI 对话
# 开始使用
```

### 方案 C：Codex（ChatGPT 用户）

```bash
# 安装 Codex CLI
npm install -g @openai/codex

# 启动（需要 ChatGPT Plus 订阅）
codex

# 登录 ChatGPT 账号
```

---

## 📚 完整学习路径

```
1️⃣ 环境搭建（30-60分钟）
   ├─ Homebrew 安装
   ├─ nvm 安装
   ├─ Node.js 配置
   └─ Git 配置

2️⃣ 工具安装（20-30分钟）
   ├─ Claude Code
   ├─ Cursor
   └─ Codex

3️⃣ 第一个项目（1-2小时）
   └─ TodoApp 实战

4️⃣ 深入学习（按需）
   ├─ Agent 概念
   ├─ MCP 协议
   └─ Prompt 技巧
```

---

## 🆘 遇到问题？

### 安装失败

**问题**：Homebrew 安装慢或失败  
**解决**：使用国内镜像
```bash
/bin/bash -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
```

**问题**：npm install 很慢  
**解决**：使用国内镜像
```bash
npm config set registry https://registry.npmmirror.com
```

**问题**：权限被拒绝  
**解决**：修改 npm 全局路径
```bash
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

### 验证失败

运行验证脚本查看具体问题：
```bash
./scripts/verify.sh
```

### 其他问题

查看 [故障排查指南](./docs/FAQ.md) 或 [提交 Issue](https://github.com/kaelinda/aicoding-guide-book/issues)

---

## 📖 继续学习

- [基础篇：环境搭建 →](./docs/基础篇/01-环境搭建/README.md)
- [基础篇：工具安装 →](./docs/基础篇/02-工具安装/README.md)
- [基础篇：第一个项目 →](./docs/基础篇/03-第一个项目/README.md)

---

**开始你的 AI 编程之旅！** 🚀
