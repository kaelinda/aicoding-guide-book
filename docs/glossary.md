# 术语表

> AI 编程常用术语速查

---

## A

### Agent
AI Agent（智能体），能够自主执行任务的 AI 系统。
- **组成**：大语言模型 + 工具 + 记忆 + 规划
- **示例**：Claude Code、Codex CLI
- **书内译名钦定**：正文一律写作 **Agent**（英文保留），首次出现时附注「（智能体）」。复数形式"多 Agent" / "Multi-Agent"均可，**中文词与英文词之间留一个空格**。避免把 Agent 译为"代理 / 代理人 / 智能体"单独使用，以免和别的章节口径冲突

### API Key
API 密钥，用于认证 API 请求的凭证。
- **获取**：OpenAI Platform、Anthropic Console
- **安全**：不要提交到 Git，使用环境变量

### AGENTS.md
项目配置文件，定义项目规则、技术栈、编码规范等。
- **作用**：让 AI 了解项目上下文
- **示例**：技术栈、禁止事项、测试要求

---

## C

### CI/CD
持续集成/持续部署，自动化软件开发流程。
- **CI**：自动测试、代码检查
- **CD**：自动构建、自动部署
- **工具**：GitHub Actions、Fastlane

### Claude Code
Anthropic 推出的终端 AI 编程助手（CLI）。
- **特点**：自主性强，可在终端内读写文件、执行命令
- **默认模型**：Claude 4.x 系列（Sonnet / Opus，随订阅等级变化）
- **定价**：Pro / Max 多档，以官网为准（[claude.com/claude-code](https://claude.com/claude-code)）

### Codex CLI
OpenAI 推出的命令行编程工具。
- **特点**：GPT-5 系列模型驱动，推理能力强
- **模型**：GPT-5-Codex（随 OpenAI 迭代更新）
- **要求**：ChatGPT Plus 或同等订阅

### Context Engineering
上下文工程——系统性地组织 AI 会话中的上下文（指令、记忆、工具输出）。
- **要点**：压缩旧对话、选择性注入文档、跨会话记忆
- **对应**：进阶篇的长对话压缩、记忆管理章节

### Cursor
AI 增强的代码编辑器，基于 VS Code。
- **特点**：上手简单，可视化操作，支持 Multi-Agent / Cloud Agents
- **模型**：支持 Claude / GPT / Gemini 等多家
- **定价**：Pro / Business 多档，以官网为准

### Cloud Agents
Cursor 的云端代理功能——在远端运行长任务，完成后回传结果。
- **用途**：大规模重构、跨仓库改动
- **相关章节**：进阶篇/07-Cursor 进阶功能

### Custom Roles
Cursor 的自定义角色功能——预设不同系统提示给同一会话。
- **用途**：PM / 开发 / 审查等角色切换

---

## B

### Bugbot
Cursor 的自动修复机器人——把测试失败 / CI 报错丢给它自动修。
- **用途**：小改动的免人工 bug 修复
- **相关章节**：进阶篇/07-Cursor 进阶功能

---

## F

### Few-shot Prompting
少样本提示，在 Prompt 中提供少量示例。
- **作用**：帮助 AI 理解任务格式
- **示例**：给出输入输出示例

---

## G

### Git Hook
Git 提供的钩子机制，在特定事件触发时执行脚本。
- **常用**：pre-commit、commit-msg
- **工具**：Husky

### GitHub Actions
GitHub 提供的 CI/CD 服务。
- **文件**：.github/workflows/*.yml
- **触发**：push、pull_request、schedule

---

## H

### Hook（Claude Code Hook）
Claude Code 的事件钩子机制——在 `SessionStart` / `UserPromptSubmit` / `PreToolUse` 等节点注入脚本。
- **区别于 Git Hook**：Git Hook 挂在 git 生命周期；Claude Code Hook 挂在 AI 会话生命周期
- **配置**：`~/.claude/settings.json` 的 `hooks` 字段

### Homebrew
macOS 的包管理器。
- **安装**：`/bin/bash -c "$(curl ...)"`
- **镜像**：gitee.com/cunkai/HomebrewCN

### Husky
Git Hooks 管理工具。
- **安装**：`npm install -D husky`
- **配置**：.husky/ 目录

---

## M

### MCP (Model Context Protocol)
模型上下文协议，让 AI 连接外部工具和数据源。
- **作用**：标准化 AI 与外部系统的交互
- **官方**：modelcontextprotocol.io
- **示例**：数据库连接、文件系统访问

### Model
大语言模型，AI 编程的核心。
- **Claude**：Claude 3.5 Sonnet
- **GPT**：GPT-4、GPT-5-Codex
- **GLM**：GLM-5

### MVVM
Model-View-ViewModel，一种架构模式。
- **Model**：数据层
- **View**：视图层
- **ViewModel**：视图模型层

---

## N

### nvm
Node Version Manager，Node.js 版本管理器。
- **安装**：`curl -o- ... | bash`
- **使用**：`nvm install 20`、`nvm use 20`

### npm
Node Package Manager，Node.js 包管理器。
- **全局安装**：`npm install -g`
- **镜像**：registry.npmmirror.com

---

## O

### OpenClaw
远程 AI Agent 网关，支持多平台访问。
- **特点**：随时随地 AI 编程
- **支持**：Telegram、Signal、Discord

---

## P

### Prompt
提示词，给 AI 的指令。
- **组成**：背景 + 任务 + 约束 + 示例
- **技巧**：具体、清晰、可验证

### Prompt Engineering
提示工程，设计和优化 Prompt 的技术。
- **方法**：角色扮演、思维链、少样本

---

## R

### Rules
各编辑器的"项目规则"文件——告诉 AI 本仓库怎么写代码。
- **Cursor**：`.cursorrules` 或 `.cursor/rules/*.mdc`
- **Claude Code**：`CLAUDE.md`（全局 / 项目两层）
- **Codex**：`AGENTS.md`
- **相关章节**：进阶篇/04-Rules 与 Skill

### Reasoning
推理能力，AI 处理复杂问题的能力。
- **等级**：low、medium、high
- **适用**：复杂问题需要高推理

---

## S

### Skill（Claude Code Skill）
Claude Code 的技能插件——把一段 `SKILL.md` + 可选脚本打包给 Claude 调用。
- **和 Hook 的区别**：Skill 由 AI 主动调用；Hook 由事件被动触发
- **存放**：`~/.claude/skills/` 或项目 `.claude/skills/`
- **相关章节**：进阶篇/04-Rules 与 Skill、实战篇/01-ClaudeCode 实战/03-常用 Skills

### Subagent（子代理）
在同一会话中派生的独立子 Agent，用于拆分任务或隔离上下文。
- **Claude Code**：通过 `Agent` 工具 + `subagent_type` 派发
- **用途**：并行探索、独立代码评审、保护主上下文

### Sandbox（沙箱）
受限执行环境——限制 AI 可触碰的文件、网络、命令。
- **形式**：Docker、VM、macOS 沙箱 API、权限白名单
- **目的**：降低"AI 执行了不该执行的命令"风险

### SwiftData
Apple 推出的数据持久化框架。
- **特点**：声明式 API，Swift 原生
- **要求**：iOS 17+

### SwiftUI
Apple 推出的声明式 UI 框架。
- **特点**：实时预览，代码简洁
- **要求**：iOS 13+

### SwiftLint
Swift 代码风格检查工具。
- **安装**：`brew install swiftlint`
- **配置**：.swiftlint.yml

---

## T

### Token
AI 处理文本的最小单位。
- **概念**：约 4 个字符 = 1 token
- **限制**：模型有 token 限制

---

## V

### ViewModel
视图模型，MVVM 架构中的核心组件。
- **作用**：连接 Model 和 View
- **特点**：可测试、可复用

---

## 其它高频概念

### Agentic Loop
"Agent 主循环"——AI 在 `感知 → 推理 → 调用工具 → 观察结果 → 再推理` 中往复直到完成任务。
- **关键点**：每一轮都可能消耗上下文，轮次越多成本越高
- **控制**：工具调用预算、最大轮次、任务分解

### Artifact
AI 会话产出的独立对象（代码、文档、图表），可独立引用、版本化。
- **例**：Claude 的 Artifacts UI、Cursor 的 Composer 输出

### MCP Server
实现 MCP 协议的具体服务——给 AI 提供某一类能力。
- **官方示例**：`filesystem` / `github` / `playwright` / `context7`
- **自建**：任意语言（Node / Python / Go）都可实现
- **相关章节**：进阶篇/02-MCP 协议

---

## Z

### Zero-shot Prompting
零样本提示，不给 AI 提供示例。
- **特点**：直接描述任务
- **适用**：简单任务

---

## 缩写速查

| 缩写 | 全称 | 含义 |
|------|------|------|
| AI | Artificial Intelligence | 人工智能 |
| API | Application Programming Interface | 应用程序接口 |
| CLI | Command Line Interface | 命令行界面 |
| IDE | Integrated Development Environment | 集成开发环境 |
| LLM | Large Language Model | 大语言模型 |
| MCP | Model Context Protocol | 模型上下文协议 |
| MVP | Minimum Viable Product | 最小可行产品 |
| PR | Pull Request | 拉取请求 |
| SDK | Software Development Kit | 软件开发工具包 |
| UI | User Interface | 用户界面 |

---

**持续更新中...**
