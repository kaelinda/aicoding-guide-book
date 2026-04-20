# Claude Code 进阶特性

> 本章覆盖 Claude Code 的两类真实进阶能力：**官方 Task / subagent 机制** 和 **通过 MCP 生态扩展的浏览器工具**。

---

## 历史说明（2026-04-20）

本章原初稿包含 "BUDDY AI 伙伴系统""ULTRAPLAN 长期规划""VOICE_MODE 语音控制""Coordinator Mode" 等内容，
经核查**均非 Anthropic 官方 Claude Code 功能**（详见 `docs/TODO.md` B1 项的处置决定）。

已做的处理：

- **删除** 两个纯虚构页面（BUDDY / ULTRAPLAN）
- **重写** 两个有真实内核但叙述偏离的页面（Multi-Agent → Task/subagent；语音与浏览器 → MCP 浏览器生态）

如果你曾根据之前版本的本章做过选型或记忆，请以当前版本为准。

---

## 章节导航

| 文档 | 讲什么 |
|------|------|
| [01-Task 工具与 Subagent](./01-Task工具与Subagent.md) | Claude Code 官方多 Agent 机制：`Task` 工具、subagent 上下文隔离与并行派发、`.claude/agents/` 自定义 Agent 定义 |
| [02-浏览器工具与 MCP 生态](./02-浏览器工具与MCP生态.md) | 浏览器能力的真实实现路径（playwright / chrome-devtools MCP），以及语音交互目前只有社区方案的现状 |

---

## 本章不讲什么

避免和其他章节撞车：

- **Skills / Slash Commands 写法** → 进入 [实战篇/01-05 常用 Skills](../../实战篇/01-ClaudeCode实战/05-ClaudeCode常用Skills.md)
- **CLAUDE.md 写法** → 进入 [09-Claude Code 写法教程](../09-ClaudeCode写法教程/README.md)
- **MCP 通用概念** → 进入 [02-MCP 协议](../02-MCP协议/README.md)
- **环境变量 / 配置文件** → 进入 [10-Claude Code 环境配置](../10-ClaudeCode环境配置/README.md)
- **手工多 Agent 协作流程** → 进入 [实战篇/01-10 多 Agent 协作](../../实战篇/01-ClaudeCode实战/10-ClaudeCode多Agent协作.md)

---

## 快速速记

| 你想做什么 | 看哪页 |
|------|------|
| "我想让 AI 并行干几件互不相关的事" | [01-Task 工具与 Subagent](./01-Task工具与Subagent.md) |
| "我想把主会话的上下文保持干净" | [01-Task 工具与 Subagent](./01-Task工具与Subagent.md) |
| "我想让 AI 开浏览器操作真实页面" | [02-浏览器工具与 MCP 生态](./02-浏览器工具与MCP生态.md) |
| "我想语音控制 Claude Code" | [02-浏览器工具与 MCP 生态 § 语音](./02-浏览器工具与MCP生态.md#语音交互目前只有社区方案) |

---

## 原则

本章所有功能描述**以 Anthropic 官方 Claude Code 文档为准**：<https://docs.claude.com/claude-code>。
如果你发现本章叙述和官方最新文档有出入，请以官方为准并提 issue。
