# 02-MCP 协议

> Model Context Protocol - AI 与外部世界的 USB 接口

## 🤔 什么是 MCP

MCP (Model Context Protocol) 是一个**开源标准**，让 AI 模型能够安全地连接外部数据源和工具。

### 形象理解

```
没有 MCP：
AI 模型 → [孤立] → 只能访问训练数据

有了 MCP：
AI 模型 → [MCP 端口] → 连接任何外部系统
                      ├─ 文件系统
                      ├─ 数据库
                      ├─ API 服务
                      └─ 其他工具
```

就像 **USB-C 接口**：
- 统一的连接标准
- 插上就能用
- 不同厂商都支持

## 🎯 为什么需要 MCP

### 问题：碎片化的集成

在 MCP 出现之前：

```
Claude 集成：
├─ 文件访问 → Anthropic 私有协议
├─ 数据库 → 自定义 API
└─ GitHub → 专用插件

GPT 集成：
├─ 文件访问 → OpenAI 私有协议
├─ 数据库 → 自定义 API
└─ GitHub → 专用插件

Cursor 集成：
├─ 文件访问 → 自研方案
├─ 数据库 → ...
└─ ...
```

**每个 AI 工具都有自己的集成方式**，开发者需要适配多次。

### 解决方案：统一标准

```
MCP 标准：
├─ 定义统一的接口规范
├─ 一次开发，到处使用
└─ Claude、GPT、Cursor 都支持

开发者：
开发一个 MCP 服务器 → 所有 AI 工具都能用
```

## 🏗 MCP 架构

### 核心组件

```
┌─────────────────────────────────────────┐
│            MCP Host (AI 应用)            │
│         Claude Code / Cursor / GPT      │
└──────────────┬──────────────────────────┘
               │ MCP Protocol
               ↓
┌─────────────────────────────────────────┐
│           MCP Client                     │
│    (负责与 Server 通信，通常内置在 Host)  │
└──────────────┬──────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│           MCP Server                     │
│        (提供具体能力的服务器)             │
├─────────────────────────────────────────┤
│ 示例：                                   │
│ • filesystem-server (文件访问)           │
│ • postgres-server (数据库)               │
│ • github-server (GitHub API)            │
│ • brave-search-server (搜索服务)         │
└─────────────────────────────────────────┘
```

### 三种资源类型

#### 1. Resources (资源)

只读数据，AI 可以查看但不能修改：

```json
{
  "name": "用户数据表",
  "type": "resource",
  "uri": "database://users",
  "mimeType": "application/json"
}
```

使用场景：
- 查看数据库 schema
- 读取配置文件
- 获取 API 文档

#### 2. Tools (工具)

可执行操作，AI 可以调用并执行：

```json
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

使用场景：
- 执行数据库查询
- 调用外部 API
- 发送通知

#### 3. Prompts (提示词模板)

预定义的提示词模板：

```json
{
  "name": "analyze_code",
  "description": "代码分析模板",
  "arguments": [
    { "name": "file_path", "type": "string" }
  ]
}
```

使用场景：
- 标准化的分析流程
- 复用常见的提示模式

## 🛠 实战：配置 MCP 服务器

### 在 Claude Code 中配置

编辑 `~/.claude/claude_desktop_config.json`：

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/你的用户名/Projects"
      ]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "你的 GitHub Token"
      }
    }
  }
}
```

### 在 Cursor 中配置

打开设置 → Features → Model Context Protocol → Add new MCP Server

```json
{
  "name": "filesystem",
  "transport": {
    "type": "stdio",
    "command": "npx",
    "args": [
      "-y",
      "@modelcontextprotocol/server-filesystem",
      "/path/to/your/projects"
    ]
  }
}
```

### 常用 MCP 服务器

| 服务器 | 功能 | 安装命令 |
|--------|------|----------|
| filesystem | 文件系统访问 | `npx @modelcontextprotocol/server-filesystem` |
| postgres | PostgreSQL 数据库 | `npx @modelcontextprotocol/server-postgres` |
| github | GitHub API | `npx @modelcontextprotocol/server-github` |
| brave-search | Brave 搜索 | `npx @modelcontextprotocol/server-brave-search` |
| google-maps | Google Maps API | `npx @modelcontextprotocol/server-google-maps` |

## 💻 开发自己的 MCP Server

### 最简示例

```typescript
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';

const server = new Server({
  name: 'my-mcp-server',
  version: '1.0.0'
}, {
  capabilities: {
    tools: {}
  }
});

// 定义工具
server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [{
      name: 'get_weather',
      description: '获取天气信息',
      inputSchema: {
        type: 'object',
        properties: {
          city: { type: 'string' }
        },
        required: ['city']
      }
    }]
  };
});

// 处理工具调用
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === 'get_weather') {
    const { city } = request.params.arguments;
    // 调用天气 API
    const weather = await fetchWeather(city);
    return {
      content: [{
        type: 'text',
        text: JSON.stringify(weather)
      }]
    };
  }
});

// 启动服务器
const transport = new StdioServerTransport();
await server.connect(transport);
```

### 开发步骤

1. **安装 SDK**
   ```bash
   npm install @modelcontextprotocol/sdk
   ```

2. **定义能力**
   - 提供哪些资源？
   - 提供哪些工具？
   - 需要什么配置？

3. **实现逻辑**
   - 处理请求
   - 调用底层服务
   - 返回结果

4. **测试**
   ```bash
   node server.js
   ```

## 🎯 使用场景

### 场景 1：数据库查询

```
你："查询最近 7 天的活跃用户数"

AI：
[调用 postgres MCP server]
→ 执行 SQL 查询
→ 返回结果
→ AI 用自然语言解释数据
```

### 场景 2：文件管理

```
你："帮我整理一下项目文档"

AI：
[调用 filesystem MCP server]
→ 扫描文档目录
→ 分类文件
→ 移动到对应文件夹
```

### 场景 3：GitHub 集成

```
你："查看最近的 PR 并总结"

AI：
[调用 github MCP server]
→ 获取 PR 列表
→ 读取每个 PR 的描述和评论
→ 总结关键信息
```

## 🔒 安全考虑

### MCP 的安全机制

1. **沙箱隔离**
   - 每个 MCP Server 独立运行
   - 只能访问被授权的资源

2. **权限控制**
   - 用户可以限制 Server 的访问范围
   - 敏感操作需要用户确认

3. **审计日志**
   - 记录所有操作
   - 可追溯异常行为

### 最佳实践

```json
// ❌ 不安全：给整个根目录访问权限
{
  "args": ["/"]
}

// ✅ 安全：只给项目目录访问权限
{
  "args": ["/Users/username/Projects/my-app"]
}

// ✅ 更安全：只给特定子目录
{
  "args": ["/Users/username/Projects/my-app/src"]
}
```

## 🌐 生态系统

### 官方服务器

- [filesystem](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem)
- [postgres](https://github.com/modelcontextprotocol/servers/tree/main/src/postgres)
- [github](https://github.com/modelcontextprotocol/servers/tree/main/src/github)
- [brave-search](https://github.com/modelcontextprotocol/servers/tree/main/src/brave-search)

### 社区服务器

- [MCP Servers 收集](https://github.com/punkpeye/awesome-mcp-servers)
- [Smithery - MCP 服务器市场](https://smithery.ai/)

## 📚 进阶学习

- [MCP 官方文档](https://modelcontextprotocol.io/)
- [Anthropic MCP 教程](https://www.anthropic.com/news/model-context-protocol)
- [MCP SDK 文档](https://github.com/modelcontextprotocol/typescript-sdk)

## ✅ 小结

- MCP 是 AI 连接外部世界的标准协议
- 一次开发，所有 AI 工具都能用
- 三种资源类型：Resources、Tools、Prompts
- 可以开发自己的 MCP Server

---

**下一步：** [Prompt 技巧 →](../03-Prompt技巧/README.md)
