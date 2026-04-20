# 02-常见 MCP 生态

> 怎么装 / 装什么 / 用的时候注意什么。以 Claude Code / Cursor 为主。

---

## 在 Claude Code 里配置

编辑 `~/.claude/settings.json`（或项目 `.claude/settings.json`）：

```jsonc
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/<你>/Projects"
      ]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<你的 fine-grained token>"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
```

> 📌 字段路径和 JSON 结构以 [官方文档](https://docs.claude.com/claude-code) 为准。不同版本（尤其是迁移 `claude_desktop_config.json` → `settings.json` 的阶段）可能略有差异。

### 验证是否生效

```bash
# 具体命令以官方为准，常见形式：
claude mcp list
```

应该能看到已注册的 server 及其状态。

---

## 在 Cursor 里配置

Cursor Settings → Features → Model Context Protocol → Add new MCP Server：

```jsonc
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

Cursor 和 Claude Code 的 JSON schema 略有差异，但 `command` / `args` / `env` 三要素是共通的。

---

## 常用 MCP Server 清单

### 官方 Server

| Server | 用途 | 安装 |
|--------|------|------|
| **filesystem** | 文件系统访问（可限定目录） | `@modelcontextprotocol/server-filesystem` |
| **postgres** | PostgreSQL 数据库 | `@modelcontextprotocol/server-postgres` |
| **github** | GitHub API（issue / PR / commit） | `@modelcontextprotocol/server-github` |
| **brave-search** | Brave 搜索 | `@modelcontextprotocol/server-brave-search` |
| **puppeteer** | 浏览器自动化 | `@modelcontextprotocol/server-puppeteer` |

### 高价值社区 Server

| Server | 用途 |
|--------|------|
| **Context7** | 从 context7.com 查官方文档（防幻觉 API 利器） |
| **@playwright/mcp** | Playwright 浏览器自动化（Microsoft 维护） |
| **chrome-devtools-mcp** | 直接连本地已开的 Chrome（带登录态） |
| **slack / 飞书 / 企业微信** | 和团队 bot 联动 |
| **notion / linear / jira** | 项目管理集成 |

### 找更多 Server

- [modelcontextprotocol/servers](https://github.com/modelcontextprotocol/servers) — 官方合集
- [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers) — 社区收集
- [Smithery](https://smithery.ai/) — MCP 市场，带一键安装

---

## 使用场景

### 场景 1：数据库查询

```text
你："查询最近 7 天的活跃用户数"

AI：
[调用 postgres MCP server]
→ 执行 SQL
→ 返回结果
→ AI 用自然语言解释数据
```

### 场景 2：文件整理

```text
你："帮我整理一下项目文档"

AI：
[调用 filesystem MCP server]
→ 扫描 docs/
→ 分类文件（按前缀 / 修改时间 / 内容）
→ 列 plan 让你确认
→ 批准后移动
```

### 场景 3：GitHub 集成

```text
你："查看最近的 PR 并总结"

AI：
[调用 github MCP server]
→ 列出最近 10 个 PR
→ 读每个的 description 和 comments
→ 生成一份 markdown 摘要
```

### 场景 4：防 AI 幻觉 API

```text
你："用 Context7 MCP 查 SwiftData 的 @Query 宏的完整参数列表，
     给 Apple 官方链接，不要凭记忆回答。"

AI：
[调用 context7 MCP server]
→ 返回实时文档片段 + 原始链接
→ 基于真实文档作答
```

---

## 安全考虑

### MCP 的安全边界

1. **沙箱隔离**：每个 Server 独立进程，只能访问被授权的资源
2. **权限控制**：用户可以限定路径、环境变量、命令白名单
3. **审批**：Host 可以拦截关键操作让用户确认

### 最佳实践

```jsonc
// ❌ 不安全：给整个根目录访问权限
{ "args": ["/"] }

// ❌ 不安全：给整个家目录
{ "args": ["/Users/你"] }

// ✅ 安全：只给项目目录
{ "args": ["/Users/你/Projects/my-app"] }

// ✅ 更安全：只给项目里非敏感子目录
{ "args": ["/Users/你/Projects/my-app/src"] }
```

### 敏感 Server 的额外注意

- **github server**：只给 fine-grained PAT，限仓库 + 只给需要的权限（通常不给 `delete` / `admin`）
- **chrome-devtools-mcp**：不要挂你"日常登录所有网站的 Chrome profile"；启一个干净的 profile 或 guest window
- **filesystem**：有 secrets 的目录（`.env` / `credentials/`）在 `.gitignore` 的基础上再确认一遍是否暴露
- **postgres / sqlite**：只给只读账号，写权限另外单独拿
- **slack / 飞书**：**不要用个人 OAuth token** 让 AI 自由发消息，很容易出乌龙

---

## 常见坑

### 坑 1：装了没生效

通常是 JSON 字段名或路径写错。验证：

```bash
claude mcp list   # 或等价命令
```

看不到 server 就说明配置没被读入。常见原因：

- 写错了文件名（应该是 `settings.json`，不是 `config.json`）
- JSON 格式错误（缺逗号 / 多逗号）—— 用 `jq . settings.json` 或 `python -m json.tool` 验证
- `command` 用了不存在的路径

### 坑 2：playwright / puppeteer 首次启动极慢

需要下载浏览器 binary（几百 MB）。**在需要用之前先预热**：

```bash
npx playwright install chromium
```

### 坑 3：Server 偷偷访问超出权限的资源

理论上 MCP Server 是沙箱隔离，但**它仍然是你本地跑的进程**，有你登录用户的权限。装来源不明的 Server 前：

- 看 GitHub 星数和 issue
- 看 `package.json` 的 dependencies 有没有奇怪的东西
- 第一次跑挂 `fs_usage` / `lsof` 观察它访问了什么

### 坑 4：同名 Server 配在多个层级

全局 `~/.claude/settings.json` 配了一个 `github`，项目 `.claude/settings.json` 又配了一个名字相同的。
具体合并规则以 Host 为准，但**不要重复配**。冲突排查浪费时间。

---

## 相关资源

- 上一页：[01-MCP 是什么](01-MCP是什么.md)
- 下一页：[03-自建 MCP Server](03-自建MCP-Server.md)
- iOS 开发者：[04-iOS 开发者的 MCP 清单](04-iOS开发者的MCP清单.md)
