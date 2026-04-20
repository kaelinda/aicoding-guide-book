# 03-自建 MCP Server

> 什么时候值得自建、最简示例、开发到发布的 5 步。

---

## 什么时候该自建

**大多数人不用自建**。先穷尽社区方案再决定。

**值得自建的场景**：

- 需要集成**你们公司内部系统**（私有 API / 内网服务）
- 需要把**项目自己的工具链**（自研的 CI / 自研的脚手架）暴露给 AI
- 社区 Server 存在但**安全边界不够严**，自己写一个更可控
- 你想**顺便学 MCP**

**不值得自建的场景**：

- 想访问 GitHub / 文件系统 / 数据库 —— 官方已有
- 想用 Playwright / Chrome —— `@playwright/mcp` 已足够好
- 一次性脚本 —— 用 shell + AI 直接执行就行，不用写 Server

---

## 最简 TypeScript 示例

```typescript
import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  ListToolsRequestSchema,
  CallToolRequestSchema,
} from '@modelcontextprotocol/sdk/types.js';

const server = new Server(
  { name: 'weather-mcp', version: '1.0.0' },
  { capabilities: { tools: {} } }
);

// 1. 声明工具
server.setRequestHandler(ListToolsRequestSchema, async () => ({
  tools: [{
    name: 'get_weather',
    description: '获取指定城市的当前天气',
    inputSchema: {
      type: 'object',
      properties: { city: { type: 'string' } },
      required: ['city'],
    },
  }],
}));

// 2. 实现工具
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  if (request.params.name === 'get_weather') {
    const { city } = request.params.arguments as { city: string };
    const weather = await fetchWeather(city);
    return {
      content: [{ type: 'text', text: JSON.stringify(weather) }],
    };
  }
  throw new Error(`Unknown tool: ${request.params.name}`);
});

// 3. 启动
const transport = new StdioServerTransport();
await server.connect(transport);

async function fetchWeather(city: string) {
  // 你的具体实现：调外部 API / 查缓存 / 等等
  return { city, temp: 23, condition: 'sunny' };
}
```

> 📌 MCP SDK 的 API 随版本演进，上面示例基于 `@modelcontextprotocol/sdk` 常见写法。**始终以 [官方 SDK README](https://github.com/modelcontextprotocol/typescript-sdk) 为准**。

---

## 从零到用户能用的 5 步

### Step 1：想清楚要暴露什么

写下来：

```
我要做的 MCP Server: <名字>

它该暴露哪些 Tool？
- get_xxx: 读取...
- set_xxx: 修改...（如果有写操作，考虑加审批）

它该暴露哪些 Resource（只读数据）？
- ...

哪些操作是敏感的？（写、删、对外发消息）
```

**原则**：**一个 Server 做一件事**。别塞 20 个无关 Tool。

### Step 2：SDK 搭脚手架

```bash
mkdir my-mcp-server && cd my-mcp-server
npm init -y
npm install @modelcontextprotocol/sdk
```

复制上面的最简示例，替换成你的实际 Tool。

### Step 3：本地挂给 Claude Code 或 Cursor 测试

```jsonc
// ~/.claude/settings.json
{
  "mcpServers": {
    "my-local-mcp": {
      "command": "node",
      "args": ["/Users/你/Projects/my-mcp-server/dist/index.js"]
    }
  }
}
```

或者用 `npx` 指向本地路径。

然后重启 Claude Code，看 `claude mcp list` 是否列出了你的 server。

### Step 4：测真实调用

在 Claude Code 里：

```text
你：用 my-local-mcp 的 get_weather 工具查一下北京现在的天气。
```

如果 Claude 找不到工具，或参数传错，看 Server 侧的 log 诊断。

### Step 5：发布（可选）

两种路径：

**A. 团队内部用**
- 打包成 Docker image 或 npm 内部包
- 写 README 告诉同事怎么配置

**B. 公开发布**
- 发到 npm（`@yourorg/some-mcp`）
- 发到 [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) 的 PR
- 发到 [Smithery](https://smithery.ai/) 市场

---

## 安全检查清单（发布前必过）

- [ ] 不会把环境变量里的 secret 写进 log
- [ ] 写操作 / 删除操作有**显式的 description** 让 AI 知道危险
- [ ] 危险操作**必须从 env 读 flag 才启用**（`ENABLE_WRITE=true`），默认只读
- [ ] 如果访问外部网络，**限域名白名单**，不让 AI 通过你的 Server 刷任意 URL
- [ ] 有单元测试，至少覆盖正常路径 + 错误处理
- [ ] README 里写清楚需要什么权限 / 环境变量 / 副作用

---

## 开发调试技巧

### 看 MCP 协议的原始消息

```bash
# stdio 模式下，在 Server 启动时 stderr 打印进来的请求
node my-server.js 2>&1 | tee mcp.log
```

### 单元测试 Tool

```typescript
// 不启动 Server，直接测你的业务逻辑
import { describe, it, expect } from 'vitest';
import { handleGetWeather } from './weather.js';

describe('get_weather', () => {
  it('returns temperature for valid city', async () => {
    const result = await handleGetWeather({ city: 'Beijing' });
    expect(result.temp).toBeTypeOf('number');
  });
});
```

### 用 Inspector 可视化调试

官方提供 MCP Inspector，可以在浏览器里可视化 Tool 列表、手动调用：

```bash
npx @modelcontextprotocol/inspector node path/to/your/server.js
```

---

## 相关资源

- 上一页：[02-常见 MCP 生态](02-常见MCP生态.md)
- 下一页：[04-iOS 开发者的 MCP 清单](04-iOS开发者的MCP清单.md)
- 官方 SDK：[typescript-sdk](https://github.com/modelcontextprotocol/typescript-sdk)、[python-sdk](https://github.com/modelcontextprotocol/python-sdk)
- 示例合集：[modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers)
