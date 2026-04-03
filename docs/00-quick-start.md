# 5 分钟快速体验 AI 编程

> 还没准备好？先来个 5 分钟快速体验，感受 AI 编程的魅力！

## 🎯 目标

用最短的时间，体验 AI 辅助编程的完整流程。

## 📋 前置条件

- macOS 系统
- 已安装 Xcode（iOS 开发者）
- 有 GitHub 账号

## 🚀 开始体验

### 方案一：Cursor（推荐新手）

1. **下载安装 Cursor**
   - 访问：https://cursor.sh
   - 下载 macOS 版本
   - 安装并打开

2. **打开一个 iOS 项目**
   ```bash
   # 如果没有现成项目，创建一个简单的
   cd ~/Desktop
   mkdir DemoApp
   cd DemoApp
   # 用 Cursor 打开
   cursor .
   ```

3. **开始对话**
   - 按 `Cmd + L` 打开 AI 对话框
   - 输入：`帮我创建一个简单的 Swift 文件，输出 Hello World`
   - 回车，等待 AI 生成代码

4. **体验智能补全**
   - 在编辑器中输入 `func `（注意空格）
   - 观察 AI 如何自动补全

### 方案二：Claude Code（推荐进阶）

1. **安装 Claude Code**
   ```bash
   # 需要先安装 Node.js（后续章节详细讲）
   npm install -g @anthropic-ai/claude-code
   ```

2. **在项目中启动**
   ```bash
   cd ~/Desktop/DemoApp
   claude
   ```

3. **提出需求**
   ```
   你：创建一个 Swift 文件，实现一个简单的计数器类
   ```

4. **观察 Claude 执行**
   - Claude 会自动创建文件
   - 编写代码
   - 甚至运行测试（如果有）

### 方案三：Codex CLI（OpenAI 粉丝）

1. **安装 Codex**
   ```bash
   npm install -g @openai/codex
   ```

2. **启动并登录**
   ```bash
   codex
   # 按提示登录 ChatGPT 账号
   ```

3. **开始编程**
   ```
   你：帮我写一个 Swift 扩展，为 String 添加 md5 方法
   ```

## ✨ 你刚才体验了什么

| 功能 | 说明 |
|------|------|
| 自然语言编程 | 用中文描述需求，AI 生成代码 |
| 智能补全 | AI 预测你的下一步操作 |
| 上下文理解 | AI 理解你的项目结构 |
| 自动执行 | AI 直接修改文件，不用复制粘贴 |

## 🎓 下一步

觉得有意思？继续学习：

- **系统学习** → [基础篇：环境搭建](./基础篇/01-环境搭建/README.md)
- **深入了解概念** → [进阶篇：Agent 概念](./进阶篇/01-Agent概念/README.md)
- **选择工具深入** → [实战篇](./实战篇/)

## 💡 常见问题

### Q: 哪个工具最好？
**A:** 没有最好，只有最适合：
- 新手入门 → Cursor（界面友好）
- 重度终端用户 → Claude Code（命令行体验好）
- OpenAI 生态用户 → Codex CLI（与 ChatGPT 打通）

### Q: 需要付费吗？
**A:** 
- Cursor：有免费额度，Pro 版 $20/月
- Claude Code：需要 Claude Pro 订阅（$20/月）
- Codex CLI：需要 ChatGPT Plus 订阅（$20/月）

### Q: AI 会取代程序员吗？
**A:** 不会。AI 是工具，提升效率，但：
- 需求分析仍需人工
- 架构设计需要经验
- 代码审查需要判断
- 复杂问题需要创造力

**AI 是助手，不是替代。**

---

**准备好了吗？** → [开始系统学习](./基础篇/01-环境搭建/README.md)
