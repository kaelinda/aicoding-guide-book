# 02-MCP 协议

> Model Context Protocol — AI 与外部世界的"USB 接口"。**不是 Anthropic 的私家花园，是行业标准**。

---

## 一句话

**MCP 让任何 AI 工具（Claude / GPT / Cursor / Codex …）用同一套接口调用外部能力（文件 / 数据库 / API / 浏览器 / ...）。** 一次开发、到处使用。

没装 MCP：AI 只能看到训练数据里的东西。
装了 MCP：AI 能读文件、查数据库、调 API、开浏览器、访问 GitHub 等等。

---

## 本章四个子页

| 文档 | 讲什么 | 适合谁看 |
|------|------|------|
| [01-MCP 是什么](01-MCP是什么.md) | 架构、三种资源类型（Resource / Tool / Prompt）、和插件 / 函数调用的区别 | 首次了解 MCP 的人 |
| [02-常见 MCP 生态](02-常见MCP生态.md) | 在 Claude Code / Cursor 里配置方式、常用 Server 清单、典型场景、安全考虑、常见坑 | 想装 MCP 用的人 |
| [03-自建 MCP Server](03-自建MCP-Server.md) | 什么时候该自建、最简 TypeScript 示例、5 步开发流程、安全检查清单 | 想开发自己 Server 的人 |
| [04-iOS 开发者的 MCP 清单](04-iOS开发者的MCP清单.md) | iOS 场景必装三件套（Context7 / filesystem / github）、配置示例、iOS 特有安全注意 | iOS 开发者（推荐先看） |

---

## 快速速记

| 情况 | 看哪页 |
|------|------|
| "MCP 到底是啥" | [01-MCP 是什么](01-MCP是什么.md) |
| "我该装哪些 MCP" | [04-iOS 开发者的 MCP 清单](04-iOS开发者的MCP清单.md)（iOS 专属）或 [02-常见 MCP 生态](02-常见MCP生态.md)（通用） |
| "装了但没生效" | [02-常见 MCP 生态 § 常见坑](02-常见MCP生态.md#常见坑) |
| "想写自己的 MCP" | [03-自建 MCP Server](03-自建MCP-Server.md) |

---

## 小结

- MCP 是 AI 连接外部世界的标准协议
- 一次开发、所有 AI 工具都能用
- 三种资源类型：Resources / Tools / Prompts
- 可以开发自己的 MCP Server
- **iOS 读者**：优先装 Context7 + filesystem + github 三件套

---

## 相关资源

- 官方：[modelcontextprotocol.io](https://modelcontextprotocol.io/)
- Anthropic 公告：[Anthropic news](https://www.anthropic.com/news/model-context-protocol)
- SDK：[typescript-sdk](https://github.com/modelcontextprotocol/typescript-sdk)
- 社区合集：[awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers)、[Smithery](https://smithery.ai/)

---

**下一步：** [Prompt 技巧 →](../03-Prompt技巧/README.md)
