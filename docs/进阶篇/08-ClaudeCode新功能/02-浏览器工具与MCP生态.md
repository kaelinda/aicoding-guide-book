# 02-浏览器工具与 MCP 生态

> Claude Code 本身没有"内置浏览器工具"，但通过 MCP 协议可以接入 playwright / chrome-devtools 等浏览器自动化能力。**这才是真实路径**。

---

## 先拆两个误解

前身章节用过 `VOICE_MODE` / `WEB_BROWSER_TOOL` 这类"常量名"作为官方功能（已重写），需要明确：

| 说法 | 现实 |
|------|------|
| "Claude Code 内置 `WEB_BROWSER_TOOL`" | ❌ 不存在这个内置工具。浏览器能力通过 **MCP server** 提供 |
| "Claude Code 内置 `VOICE_MODE`" | ❌ 不存在。官方 Claude Code CLI 以文本为主交互；语音方案是社区 / 第三方 |
| "装个 MCP 就能让 AI 看网页" | ✅ 这是对的。MCP 是官方扩展机制 |

---

## 浏览器工具：走 MCP

### 什么是 MCP（简版）

[Model Context Protocol](https://modelcontextprotocol.io)：一个开放协议，让 AI 工具（比如 Claude Code）按统一方式调用外部能力 —— 数据库、浏览器、文件系统、Slack 等等。

参见 [进阶篇/02-MCP 协议](../02-MCP协议/README.md)。

### 主流浏览器 MCP 选项

| MCP Server | 定位 | 谁维护 |
|------------|------|------|
| `@playwright/mcp` | 完整的 Playwright 自动化（导航 / 点击 / 截图 / 网络抓包） | Microsoft 官方 |
| `chrome-devtools-mcp` | 直接连你本地已开的 Chrome（带登录态） | 社区 |
| `puppeteer-mcp` | Puppeteer 驱动，和 Playwright 相似但生态略不同 | 社区 |
| `browse` / `gstack` | 基于 Chromium 的简化浏览 / 测试工具 | 社区 |

挑选经验：

- **需要干净环境做 E2E 测试** → Playwright MCP
- **需要带登录态刷真实页面**（比如 QA 一个需要登录的场景） → chrome-devtools MCP
- **只是让 AI 读几个公开网页** → 原生 `WebFetch` 就够，不用装 MCP

### 配置示例

在项目的 `.claude/settings.json`（或全局 `~/.claude/settings.json`）里加：

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    }
  }
}
```

> 📌 具体字段名和 JSON 路径**以官方文档为准**。MCP 配置方式随版本演进，本示例演示约定。

然后在 Claude Code 里：

```text
用 playwright MCP 打开 https://example.com，截图并告诉我 "Contact" 链接的 href
```

Claude 会调用 MCP 工具，返回截图 + 元素 href。

### 典型使用场景（iOS 开发者视角）

- **App Store 页面抓信息**：让 AI 打开竞品 App Store 页、抓取版本历史、截图对比 UI
- **调试 webview**：app 里嵌的 h5 有问题，让 AI 打开这个 URL、抓 console error
- **本地开发服务器验收**：让 AI 打开 `http://localhost:3000`，点击登录、验证 happy path
- **文档爬虫**：让 AI 打开 Apple 文档、提取 API 签名 + 可用性信息

---

## 语音交互：目前只有社区方案

### 官方不带语音

截至本书写作（2026-04），Claude Code CLI **没有官方的语音模式**。
任何带 `/voice on` / `VOICE_MODE` 口径的"官方功能"描述都是错的。

### 社区 / 第三方可行路径

如果你真想语音控制 Claude Code，现实路径：

| 方案 | 原理 | 坑 |
|------|------|------|
| macOS 自带"听写" | 系统级语音转文字，填到任何文本框 | 技术词汇识别率一般，代码类 prompt 不友好 |
| Whisper + 脚本 | 本地跑 OpenAI Whisper，转文字后粘进 Claude Code | 自己搭管线 |
| Wispr Flow / SuperWhisper | 第三方 App，macOS 全局语音输入 | 付费；数据流经第三方 |
| 语音助手 MCP | 理论上可以做一个调语音 API 的 MCP server | 我没看到成熟实现 |

**我个人经验**：通勤路上用 Wispr Flow 口述需求到笔记 app，回家粘进 Claude Code，比折腾"AI 自动语音"靠谱。

### 无障碍视角

如果你因为手部伤病等原因刚需语音：

- Mac 的 Voice Control（系统设置 → 辅助功能）更完整，比"听写"适合长输入
- 配合 iOS 的"旁白"/"语音控制"做跨设备方案

这不在本书主题内，但确实是现实选择。

---

## 组合用法：浏览器 MCP + Task subagent

派一个 subagent 去用浏览器 MCP 做一件耗时任务，主会话不被占用：

```text
派一个 subagent 用 playwright MCP 做：
1. 访问 https://apps.apple.com/cn/app/<我的 app>
2. 抓取最新版本号、评分、评论数
3. 抓最近 20 条 1-2 星评论的摘要
4. 只返回结构化 JSON

主会话继续我们刚才讨论的架构问题。
```

详见 [01-Task 工具与 Subagent](01-Task工具与Subagent.md)。

---

## 常见坑

### 坑 1：装了 MCP 但 Claude Code 不认

多半是配置文件路径或字段写错了。
验证：`claude mcp list`（或等价命令，以官方文档为准）应该列出已注册的 server。

### 坑 2：chrome-devtools MCP 访问了你的 Chrome 全部 tab / 登录态

这是它的能力来源，也是风险。
敏感账号（支付 / 企业内网）的 Chrome profile **不要**直接挂给 MCP；起一个独立的 profile 或者临时 guest window。

### 坑 3：playwright MCP 装了但第一次跑超慢

Playwright 需要下载浏览器 binary（几百 MB），首次启动会卡。
**在需要用之前预热一次**：`npx playwright install chromium`。

### 坑 4：把"我想让 AI 帮我刷社交媒体"当成合理使用

自动刷 / 点赞 / 登录公共服务很可能违反 ToS，甚至违法。
浏览器自动化的合理用途是**你自己的应用 / 公开信息 / 你有授权的场景**。

---

## 一句话总结

**Claude Code 的浏览器能力不在 CLI 里，在 MCP 里**。想扩能力就加 MCP server，别等"内置功能"。语音目前官方没做，走社区方案或系统级"听写"。

---

## 相关资源

- 章节首页：[08-Claude Code 新功能](README.md)
- 上一篇：[01-Task 工具与 Subagent](01-Task工具与Subagent.md)
- 配合阅读：[进阶篇/02-MCP 协议](../02-MCP协议/README.md)
- 官方参考：[modelcontextprotocol.io](https://modelcontextprotocol.io)、[Claude Code MCP 文档](https://docs.claude.com/claude-code)（以官方为准）
