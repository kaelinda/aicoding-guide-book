# 03-Codex 实战

> OpenAI 的命令行编程助手，GPT-5 系列驱动。**和 Claude Code 是一类工具，不同家的取舍**。

---

## Codex CLI 是什么

OpenAI 推出的命令行 AI 编程工具，内置 GPT-5 / GPT-5.4 / GPT-5-Codex 等模型。

**核心优势**：

- 🧠 GPT-5 系列推理能力强
- ⚡ Rust 编写，启动和响应快
- 🔒 代码在本地分析，不必上传到云端
- 🛠 支持自动执行 shell 命令（可审批）
- 🤝 和 ChatGPT 登录态打通，订阅可复用

**典型用法**：

- 快速原型 / 脚手架生成
- 代码重构和审查
- Bug 排查和修复
- 测试用例批量生成
- 文档生成

---

## 安装

### 前置条件

- Node.js 20+（见 [00-快速开始](../../00-quick-start.md)）
- ChatGPT Plus / Pro / Team 订阅（或独立的 `OPENAI_API_KEY`）

### 装

```bash
# 全局安装
npm install -g @openai/codex

# 验证
codex --version
```

### 登录

```bash
codex

# 按提示选择：
# 1. ChatGPT 账号登录（推荐，走浏览器授权）
# 2. API Key 登录（设置 OPENAI_API_KEY 环境变量）
```

登录失败见 [FAQ § 2 登录与认证](../../FAQ.md#2-登录与认证)。

---

## 本章四个子页

| 文档 | 讲什么 | 读完能做到 |
|------|------|------|
| [01-基本使用](01-基本使用.md) | 启动、三个核心斜杠命令（`/help` / `/model` / `/reasoning`）、3 个基础案例 | 流畅用 Codex 写代码和审查 |
| [02-高级功能](02-高级功能.md) | `AGENTS.md` 配置 / Subagents 并行 / 网络搜索 / CI/CD 集成 | 把 Codex 嵌进团队工作流 |
| [03-iOS 开发实战](03-iOS开发实战.md) | 4 个 iOS 场景（原型 / 性能优化 / 测试 / 文档），每个带 review 要点 | iOS 场景下稳定使用 Codex |
| [04-安全与配置](04-安全与配置.md) | 审批模式 / 黑名单 / 常见问题 / 推荐工作流 | 安全地跑 Codex，不被它误伤 |

---

## 快速速记

| 情况 | 看哪页 |
|------|------|
| "斜杠命令 / 模型怎么切" | [01-基本使用](01-基本使用.md) |
| "AGENTS.md 怎么写" | [02-高级功能](02-高级功能.md) |
| "Codex 生成 SwiftUI / SwiftData 怎么避坑" | [03-iOS 开发实战](03-iOS开发实战.md) |
| "怕它乱跑命令" | [04-安全与配置 § 审批模式](04-安全与配置.md#审批模式) |
| "登录不上 / 响应慢" | [FAQ](../../FAQ.md) 对应章节 |

---

## 和 Claude Code 的对比

| 维度 | Codex CLI | Claude Code |
|------|-----------|-------------|
| 主力模型 | GPT-5 系列 | Claude Sonnet / Opus 系列 |
| 推理模式 | `/reasoning high/medium/low` 可调 | `--think` / `--think-hard` / `ultrathink` 标志 |
| 计费 | 包含在 ChatGPT 订阅 或 API 按量 | Anthropic 订阅 或 API 按量 |
| 配置文件 | `AGENTS.md` | `CLAUDE.md` |
| Subagent | ✅ | ✅（Task 工具） |
| MCP | ✅ | ✅（更成熟的生态） |

**我的选择**：

- **个人主力**：根据订阅选，哪个顺手用哪个
- **团队项目**：两个都装着，遇到一家卡壳换另一家问一遍
- **企业 / 合规场景**：按公司采购走；两家都有企业版

详见 [04-安全与配置 § 推荐工作流](04-安全与配置.md#推荐工作流)。

---

## 小结

- Codex CLI = OpenAI 的终端编程助手，GPT-5 驱动
- 核心三个斜杠命令：`/help` / `/model` / `/reasoning`
- `AGENTS.md` 放项目规则（类似 CLAUDE.md）
- 支持 Subagent / 网络搜索 / CI 非交互模式
- 安全默认：用 `interactive` 审批，配合 `AGENTS.md` 黑名单

---

## 相关资源

- 官方：[developers.openai.com/codex/cli](https://developers.openai.com/codex/cli)
- 最佳实践：[Codex 官方 best-practices](https://developers.openai.com/codex/learn/best-practices)
- 配合阅读：[基础篇/02-03 Codex 安装](../../基础篇/02-工具安装/03-codex.md)、[基础篇/04-03 Agents 概念](../../基础篇/04-Agent与工具/03-Agents.md)

---

**下一步：** [Prompt 技巧 →](../../进阶篇/03-Prompt技巧/README.md)
