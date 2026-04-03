# 术语表

> AI 编程常用术语速查

---

## A

### Agent
AI Agent（人工智能代理），能够自主执行任务的 AI 系统。
- **组成**：大语言模型 + 工具 + 记忆 + 规划
- **示例**：Claude Code、Codex CLI

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
Anthropic 推出的终端 AI 编程助手。
- **特点**：自主性强，可自动执行
- **模型**：Claude 3.5 Sonnet
- **价格**：$20/月

### Codex CLI
OpenAI 推出的命令行编程工具。
- **特点**：GPT-5 驱动，推理能力强
- **模型**：GPT-5-Codex
- **要求**：ChatGPT Plus 订阅

### Cursor
AI 增强的代码编辑器，基于 VS Code。
- **特点**：上手简单，可视化操作
- **模型**：支持多种模型
- **价格**：$20/月

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

### Reasoning
推理能力，AI 处理复杂问题的能力。
- **等级**：low、medium、high
- **适用**：复杂问题需要高推理

---

## S

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
