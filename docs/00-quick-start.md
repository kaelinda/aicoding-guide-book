# 🚀 快速开始

> 5 分钟上手 AI 编程

---

## 你能学到什么

- ✅ 安装 Claude Code / Codex
- ✅ 运行第一个 AI 编程任务
- ✅ 理解基本工作流程
- ✅ 获得第一个编程成果

---

## 第一步：安装工具（1分钟）

### Claude Code（推荐）

```bash
# macOS
brew install --cask claude

# 验证安装
claude --version
```

### Codex

```bash
# pip 安装
pip install openai-codex

# 验证安装
codex --version
```

---

## 第二步：登录账号（1分钟）

```bash
# Claude Code 登录
claude auth

# Codex 登录
codex auth
```

按提示打开浏览器完成授权。

---

## 第三步：运行第一个任务（2分钟）

### 启动 Claude Code

```bash
# 进入项目目录
cd ~/Projects/MyApp

# 启动 Claude Code
claude
```

### 输入你的第一个指令

```
帮我添加一个用户登录页面，使用 SwiftUI
```

Claude Code 会自动：
1. 📖 分析现有代码结构
2. ✨ 生成登录页面代码
3. 📝 解释做了什么

---

## 第四步：验收结果（1分钟）

```
代码完成了，看看是否满足需求：

✅ 已创建 LoginView.swift
✅ 使用 SwiftUI TextField 和 SecureField
✅ 添加了登录按钮
⚠️ 需要添加表单验证逻辑
```

**你说："可以，运行测试看看"</p>

Claude Code 会运行测试并汇报结果。

---

## 下一步

| 章节 | 内容 |
|------|------|
| [📦 工具安装](./基础篇/02-工具安装/README.md) | 详细安装指南 |
| [📝 第一个项目](./基础篇/03-第一个项目/README.md) | 创建完整项目 |
| [💡 Prompt 技巧](./进阶篇/03-Prompt技巧/README.md) | 写出好指令 |

---

## 常见问题

**Q: 需要联网吗？**
A: 是的，AI 编程需要网络连接。

**Q: 代码安全吗？**
A: Claude Code 代码不上传，仅用于生成响应。

**Q: 支持哪些语言？**
A: Swift、Python、JavaScript、TypeScript 等主流语言。
