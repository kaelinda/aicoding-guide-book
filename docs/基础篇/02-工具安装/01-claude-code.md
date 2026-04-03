# Claude Code 安装

> 终端里的 AI 编程助手

## 📦 安装步骤

### 步骤 1：通过 npm 安装

```bash
# 全局安装 Claude Code
npm install -g @anthropic-ai/claude-code

# 验证安装
claude --version
```

### 步骤 2：首次启动

```bash
# 启动 Claude Code
claude
```

首次启动会提示登录：

```
Welcome to Claude Code!

To get started, you'll need to authenticate.
Press Enter to open your browser and log in...
```

### 步骤 3：完成认证

1. 按 Enter 打开浏览器
2. 登录你的 Claude 账号
3. 授权 Claude Code 访问
4. 回到终端

看到以下提示表示成功：

```
✓ Authentication successful!
You're ready to start using Claude Code.
```

## 🔧 基础配置

### 设置默认模型

```bash
# 在 Claude Code 交互模式中
/model claude-3.5-sonnet
```

### 配置 AGENTS.md

在项目根目录创建 `AGENTS.md` 或 `CLAUDE.md`：

```markdown
# 项目配置

## 技术栈
- Swift 5.9
- SwiftUI

## 编码规范
- 使用 4 空格缩进
- 遵循 Swift API 设计指南
```

## ✅ 验证安装

```bash
# 创建测试项目
mkdir test-claude
cd test-claude

# 启动 Claude Code
claude

# 测试对话
你：创建一个简单的 Swift 文件，输出 Hello World

Claude：
[生成代码]
```

## ⚠️ 常见问题

### 问题 1：npm install 失败

```bash
# 尝试清除缓存
npm cache clean --force

# 使用国内镜像
npm config set registry https://registry.npmmirror.com

# 重新安装
npm install -g @anthropic-ai/claude-code
```

### 问题 2：认证失败

```bash
# 退出登录
claude --logout

# 重新登录
claude
```

### 问题 3：命令找不到

```bash
# 检查 npm 全局路径
npm config get prefix

# 添加到 PATH
echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## 📚 下一步

- [Cursor 安装 →](./02-cursor.md)
- [Claude Code 实战教程 →](../../实战篇/01-ClaudeCode实战/README.md)

## 🔗 相关资源

### 官方文档
- [Claude Code 文档](https://docs.anthropic.com/claude-code) ⭐⭐⭐⭐⭐

### GitHub
- [claude-code](https://github.com/anthropics/claude-code) ⭐⭐⭐⭐⭐
