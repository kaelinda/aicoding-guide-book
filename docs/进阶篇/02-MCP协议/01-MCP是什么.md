# 01-MCP 是什么

> Model Context Protocol — AI 和外部世界之间的"USB 接口"标准。

---

## 一句话讲清楚

**MCP 是一个开源协议，让任何 AI 工具（Claude / GPT / Cursor / Codex…）能用同一套接口调用外部能力（文件 / 数据库 / API / 浏览器 / ...）。**

不装 MCP：

```
AI 模型 → [孤立] → 只能访问训练数据里的内容
```

装上 MCP：

```
AI 模型 → [MCP 端口] → 文件系统 / 数据库 / GitHub / 浏览器 / ...
```

可以类比 **USB-C 接口**：

- 统一连接标准
- 插上就能用
- 不同厂商都支持

---

## 为什么要有 MCP

### 没 MCP 之前：集成碎片化

```
Claude 要用文件系统 → Anthropic 自己定的协议
GPT 要用文件系统 → OpenAI 自己定的协议
Cursor 要用文件系统 → Cursor 自己定的协议

开发者做一个"文件系统工具" → 要适配三次
```

### 有了 MCP：一次开发，到处用

```
开发者做一个 MCP Server → Claude / GPT / Cursor 都能用
```

这就是 Anthropic 主推、各家逐渐跟进的原因 —— **不是 Anthropic 的私家花园，是行业标准**。

---

## 架构

### 三个角色

```
┌─────────────────────────────────────────┐
│            MCP Host                      │
│       你的 AI 工具（Claude Code / ...）   │
└──────────────┬──────────────────────────┘
               │ 通过 MCP 协议
               ↓
┌─────────────────────────────────────────┐
│           MCP Client                     │
│       内置在 Host 里，负责通信           │
└──────────────┬──────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│           MCP Server                     │
│        提供具体能力，例如：              │
├─────────────────────────────────────────┤
│ • filesystem-server                      │
│ • postgres-server                        │
│ • github-server                          │
│ • playwright-server                      │
└─────────────────────────────────────────┘
```

**MCP Server 是独立进程**。你的 AI 工具通过标准协议和它通信，Server 崩了不会影响 AI 工具本身。

---

## 三种资源类型

MCP Server 可以给 AI 暴露三种东西：

### 1. Resources（资源 — 只读）

```jsonc
{
  "name": "用户数据表",
  "type": "resource",
  "uri": "database://users",
  "mimeType": "application/json"
}
```

**场景**：

- 让 AI 看数据库 schema
- 让 AI 读配置文件
- 让 AI 获取 API 文档

AI 可以读，不能改。

### 2. Tools（工具 — 可执行）

```jsonc
{
  "name": "query_database",
  "description": "执行 SQL 查询",
  "inputSchema": {
    "type": "object",
    "properties": {
      "sql": { "type": "string" }
    }
  }
}
```

**场景**：

- 执行数据库查询
- 调用外部 API
- 发送 Slack 消息
- 打开浏览器页面

Tools 是 Server 暴露的**函数签名**。AI 根据 `description` + `inputSchema` 决定什么时候调、怎么调。

### 3. Prompts（提示词模板）

```jsonc
{
  "name": "analyze_code",
  "description": "代码分析模板",
  "arguments": [
    { "name": "file_path", "type": "string" }
  ]
}
```

**场景**：

- 标准化的分析流程（"审查这个文件的安全风险"）
- 复用常见的 Prompt 模式

Prompts 可以理解为**打包好的斜杠命令**，从 Server 暴露到 Host。

---

## MCP 和别的机制的区别

| 机制 | 关系 |
|------|------|
| **函数调用（function calling）** | MCP 建立在函数调用之上。函数调用是能力，MCP 是跨工具的协议 |
| **插件（如 ChatGPT Plugins）** | 插件是各家自己的，MCP 是开放的 |
| **MCP vs Claude Code 的内置工具（Read / Bash / ...）** | 内置工具是 Host 默认能力，MCP 是扩展机制 |

---

## 相关资源

- 下一页：[02-常见 MCP 生态](02-常见MCP生态.md)
- 章节首页：[02-MCP 协议](README.md)
- 官方：[modelcontextprotocol.io](https://modelcontextprotocol.io/)、[Anthropic MCP 发布](https://www.anthropic.com/news/model-context-protocol)
