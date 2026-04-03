# Codex 安装

> OpenAI 的命令行编程助手，GPT-5 驱动

## 📦 安装步骤

### 步骤 1：通过 npm 安装

```bash
# 全局安装 Codex CLI
npm install -g @openai/codex

# 验证安装
codex --version
```

### 步骤 2：首次启动

```bash
# 启动 Codex
codex
```

首次启动会提示登录：

```
Welcome to Codex!

Choose your authentication method:
1. ChatGPT account (Recommended)
2. OpenAI API Key

Enter your choice [1-2]:
```

### 步骤 3：完成认证

**方式 1：ChatGPT 账号（推荐）**

```
1. 选择 1
2. 按 Enter 打开浏览器
3. 登录你的 ChatGPT 账号
4. 授权 Codex 访问
5. 回到终端
```

**方式 2：API Key**

```
1. 访问 https://platform.openai.com/api-keys
2. 创建新的 API Key
3. 复制 Key
4. 粘贴到终端
```

看到以下提示表示成功：

```
✓ Successfully authenticated!
You're ready to start coding with Codex.
```

## 🔧 基础配置

### 设置默认模型

```bash
# 在 Codex 交互模式中
/model gpt-5-codex
```

### 配置 AGENTS.md

在项目根目录创建 `AGENTS.md`：

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
mkdir test-codex
cd test-codex

# 启动 Codex
codex

# 测试对话
你：创建一个 Swift 结构体表示用户，包含 id、name、email

Codex：
[生成代码]
```

## 🎯 核心命令

| 命令 | 功能 |
|------|------|
| `/help` | 查看帮助 |
| `/model` | 切换模型 |
| `/reasoning` | 调整推理等级 |
| `/clear` | 清空对话 |

## ⚠️ 常见问题

### 问题 1：npm install 失败

```bash
# 尝试清除缓存
npm cache clean --force

# 使用国内镜像
npm config set registry https://registry.npmmirror.com

# 重新安装
npm install -g @openai/codex
```

### 问题 2：认证失败

```bash
# 退出登录
codex --logout

# 重新登录
codex
```

### 问题 3：需要 ChatGPT Plus 订阅

```
Codex 需要 ChatGPT Plus / Pro 订阅：

订阅链接：https://chat.openai.com/subscribe

价格：
- ChatGPT Plus: $20/月
- ChatGPT Pro: $200/月
```

## 📚 下一步

- [工具对比与选择 →](./04-对比选择.md)
- [Codex 实战教程 →](../../实战篇/03-Codex实战/README.md)

## 🔗 相关资源

### 官方文档
- [Codex CLI 文档](https://developers.openai.com/codex/cli) ⭐⭐⭐⭐⭐
- [Codex 最佳实践](https://developers.openai.com/codex/learn/best-practices) ⭐⭐⭐⭐⭐

### GitHub
- [openai/codex](https://github.com/openai/codex) ⭐⭐⭐⭐⭐
