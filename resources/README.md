# 资源汇总

> 精选资源，持续更新

## 📚 官方文档（最可信）

> ⭐ 优先参考官方文档，信息最权威、最新

### AI 编程工具

| 工具 | 文档链接 | 可信度 | 说明 |
|------|----------|--------|------|
| Claude Code | [docs.anthropic.com](https://docs.anthropic.com/claude-code) | ⭐⭐⭐⭐⭐ | Anthropic 官方文档 |
| Codex CLI | [developers.openai.com/codex](https://developers.openai.com/codex/cli) | ⭐⭐⭐⭐⭐ | OpenAI Codex 文档 |
| OpenClaw | [docs.openclaw.ai](https://docs.openclaw.ai/) | ⭐⭐⭐⭐⭐ | OpenClaw 官方文档 |
| Cursor | [cursor.com/docs](https://cursor.com/docs) | ⭐⭐⭐⭐⭐ | Cursor IDE 文档 |

### iOS 开发（官方）

| 资源 | 链接 | 可信度 | 说明 |
|------|------|--------|------|
| Apple Developer | [developer.apple.com](https://developer.apple.com/) | ⭐⭐⭐⭐⭐ | Apple 官方开发者门户 |
| Swift 文档 | [swift.org/documentation](https://swift.org/documentation/) | ⭐⭐⭐⭐⭐ | Swift 官方文档 |
| SwiftUI 教程 | [developer.apple.com/tutorials/swiftui](https://developer.apple.com/tutorials/swiftui) | ⭐⭐⭐⭐⭐ | Apple 官方 SwiftUI 教程 |

### 协议与标准

| 协议 | 文档链接 | 可信度 | 说明 |
|------|----------|--------|------|
| MCP | [modelcontextprotocol.io](https://modelcontextprotocol.io/) | ⭐⭐⭐⭐⭐ | Model Context Protocol 官方 |

## 📦 GitHub 官方仓库（次优先）

> 源码最真实，示例最可靠

| 项目 | 链接 | 说明 |
|------|------|------|
| [openai/codex](https://github.com/openai/codex) | Codex CLI 源码 | 包含完整文档和示例 |
| [anthropics/claude-code](https://github.com/anthropics/claude-code) | Claude Code 源码 | 官方配置示例 |
| [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) | MCP 服务器集合 | 官方实现参考 |
| [openclaw/openclaw](https://github.com/openclaw/openclaw) | OpenClaw 源码 | 开源源码和文档 |

## 🌟 社区资源（需验证）

> 优质社区内容，建议与官方文档交叉验证

## 🛠 开发工具

### 必备工具

- [Homebrew](https://brew.sh/) - macOS 包管理器
- [nvm](https://github.com/nvm-sh/nvm) - Node.js 版本管理
- [Git](https://git-scm.com/) - 版本控制
- [VS Code](https://code.visualstudio.com/) - 代码编辑器

### iOS 开发

- [Xcode](https://developer.apple.com/xcode/) - Apple 官方 IDE
- [Swift Documentation](https://swift.org/documentation/) - Swift 官方文档
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui) - Apple 官方教程

## 📖 学习资源

### AI 编程教程

- [Prompt Engineering Guide](https://www.promptingguide.ai/) - Prompt 工程指南
- [Learn Prompting](https://learnprompting.org/) - 免费 Prompt 课程
- [OpenAI Cookbook](https://github.com/openai/openai-cookbook) - OpenAI 实践指南

### iOS 开发

- [Stanford CS193p](https://cs193p.sites.stanford.edu/) - 斯坦福 SwiftUI 课程
- [Hacking with Swift](https://www.hackingwithswift.com/) - Swift 教程
- [Swift by Sundell](https://www.swiftbysundell.com/) - Swift 博客

## 🌟 社区资源

### GitHub 仓库

- [Awesome AI Coding](https://github.com/topics/ai-coding) - AI 编程资源汇总
- [MCP Servers](https://github.com/modelcontextprotocol/servers) - 官方 MCP 服务器
- [Awesome MCP](https://github.com/punkpeye/awesome-mcp-servers) - MCP 服务器收集

### 社区论坛

- [OpenClaw Discord](https://discord.gg/clawd) - OpenClaw 社区
- [Cursor Forum](https://forum.cursor.sh/) - Cursor 官方论坛
- [Reddit r/LocalLLaMA](https://www.reddit.com/r/LocalLLaMA/) - 本地 LLM 社区

## 🎬 视频教程

### YouTube 频道

- [Anthropic](https://www.youtube.com/@AnthropicAI) - Claude 官方频道
- [Cursor](https://www.youtube.com/@cursorsh) - Cursor 官方频道
- [Swift by Sundell](https://www.youtube.com/@swiftbysundell) - Swift 教程

### B 站频道（中文）

- AI 编程相关视频持续更新中...

## 📰 博客与文章

### 推荐博客

- [Anthropic Blog](https://www.anthropic.com/blog) - Claude 最新动态
- [OpenAI Blog](https://openai.com/blog) - GPT 最新研究
- [Addy Osmani](https://addyosmani.com/blog/) - 前端与 AI 编程

### 精选文章

- [AGENTS.md 最佳实践](https://agentsmd.io/agents-md-best-practices)
- [MCP 协议入门](https://modelcontextprotocol.io/docs/getting-started/intro)
- [多 Agent 协作模式](https://addyosmani.com/blog/code-agent-orchestra/)

## 🔧 配置模板

### AGENTS.md 模板

```markdown
# 项目配置

## 技术栈
- Swift 5.9
- SwiftUI
- MVVM 架构

## 编码规范
- 使用 4 空格缩进
- 函数命名使用 camelCase
- 添加必要的注释

## 项目结构
- Views/ - 视图层
- ViewModels/ - 视图模型
- Models/ - 数据模型
- Services/ - 服务层

## 常用命令
- 构建：`xcodebuild -scheme MyProject`
- 测试：`xcodebuild test -scheme MyProject`
```

### .nvmrc 模板

```
18.19.0
```

### .gitignore 模板（iOS）

```
# Xcode
*.xcodeproj/*
!*.xcodeproj/project.pbxproj
!*.xcodeproj/xcshareddata/

# CocoaPods
Pods/

# Swift Package Manager
.build/

# Carthage
Carthage/Build/

# fastlane
fastlane/report.xml
```

## 🎯 按场景推荐

### 新手入门

1. 阅读：[基础篇：环境搭建](../docs/基础篇/01-环境搭建/README.md)
2. 安装：Homebrew → nvm → Node.js
3. 体验：[5 分钟快速体验](../docs/00-quick-start.md)
4. 学习：[Agent 概念](../docs/进阶篇/01-Agent概念/README.md)

### 进阶提升

1. 深入：[MCP 协议](../docs/进阶篇/02-MCP协议/README.md)
2. 实践：[Claude Code 实战](../docs/实战篇/01-ClaudeCode实战/README.md)
3. 优化：Prompt 技巧
4. 扩展：自定义 MCP Server

### 大师之路

1. 架构：[多 Agent 协作](../docs/大师篇/01-多Agent协作/README.md)
2. 自动化：CI/CD 集成
3. 远程：[OpenClaw 远程 Coding](../docs/大师篇/02-OpenClaw远程Coding/README.md)
4. 创新：探索新的工作流

---

**持续更新中...**

有好的资源推荐？欢迎提交 PR！
