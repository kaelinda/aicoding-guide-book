# 04-iOS 开发者的 MCP 实用清单

> iOS 日常工作最值得装哪几个 MCP server、配置示例、安全注意。

---

## 必装级

装上就能让 Claude / Cursor 更强，跨所有项目。

| MCP Server | 干啥的 | iOS 场景 |
|------------|------|------|
| **Context7** | 查实时官方文档 | 查 SwiftUI / UIKit / SwiftData / Foundation API 签名，**防幻觉 API 的头号利器** |
| **filesystem** | 给 AI 读写本地文件的权限（可限定目录） | 把 Xcode 工程目录挂给 AI 做全局重构 / 分析 |
| **github** | 让 AI 直接操作 issue / PR | 根据 GitHub issue 生成修复 PR；review 团队 PR |

---

## 特定场景

按需装，不追求全。

| MCP Server | 适合什么时候装 |
|------------|------|
| **playwright / chrome-devtools** | 调试嵌入式 `WKWebView`；抓 h5 页面内容；App Store 页面抓取 |
| **Apple Docs 社区 MCP** | 想更快查 HIG / Apple 样例代码；补 Context7 不覆盖的深度文档 |
| **postgres / sqlite** | app 后端有数据库、想让 AI 直接查表做性能分析 |
| **slack / 飞书 / 企业微信** | 和团队协作 bot 联动（不建议给 AI 自由发消息权限） |
| **notion / linear / jira** | 根据任务单生成代码 / PR，或反过来从 PR 生成 changelog |

---

## 配置示例（Claude Code）

```jsonc
// ~/.claude/settings.json 或 项目/.claude/settings.json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/<你>/Projects/MyiOSApp"
      ]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "<fine-grained token，限当前仓库>"
      }
    }
  }
}
```

> 📌 字段名和结构以 [Anthropic 官方 Claude Code 文档](https://docs.claude.com/claude-code) 为准。

Cursor 的配置方式略不同，详见 [02-常见 MCP 生态](02-常见MCP生态.md)。

---

## iOS 项目安全注意

1. **filesystem 只挂项目目录，不要挂 `~` 整个家目录**
   - 家目录里有 `.ssh/` / `.aws/` / `.env` 等敏感文件
   - 即便 AI 理论上不乱读，也没必要给它机会

2. **GitHub token 用 fine-grained PAT**
   - 只给当前仓库，不要 classic token
   - 权限只勾到"需要的最小集"（通常不给 `admin` / `delete`）

3. **敏感 App 的 Xcode 工程挂前先过 `.gitignore`**
   - 确认 `GoogleService-Info.plist` / `.xcconfig` 里的 API key 没被意外加进 MCP 视野
   - `Pods/` / `DerivedData/` 这种大目录最好排除

4. **不要给 Context7 之外的 MCP 访问 Keychain**
   - 没有 MCP 会主动读 Keychain，但你自己写 Server 时不要暴露 `SecItemCopyMatching` 之类的接口给 AI

---

## 实用 Prompt

### 用 Context7 查文档

```text
用 context7 MCP 查一下 SwiftData 的 @Query 宏的完整参数列表（尤其排序和过滤写法），
给 Apple 官方文档链接和示例代码。不要依赖你的训练数据。
```

### 用 GitHub MCP 做 issue 审查

```text
用 github MCP 读这个仓库最近 30 天的 issue（label=bug），
按「最容易修 / 影响最大」排序，给我一张表。
每行附 issue 编号 + 一句话结论。
```

### 用 filesystem + Context7 组合做迁移调研

```text
1. 用 filesystem MCP 扫 Sources/ 下所有 .swift 文件，找出还在用 ObservableObject 的类
2. 对每一个，用 context7 MCP 查 iOS 17+ 的 @Observable 对应写法
3. 输出一份迁移清单：文件 | 类名 | 新写法提示 | 预估改动行数
不要改代码，只出清单。
```

### 用 chrome-devtools MCP 调 WKWebView

```text
用 chrome-devtools MCP 打开 http://localhost:8080/webview-debug.html
（这个页面等同我们 app 内嵌的 h5），
然后：
- 打开 Console，列出所有 error / warning
- 打开 Network，找出超过 2s 的请求
- 截图当前状态
```

---

## 常见疑问

### 为什么不把所有 MCP 都装上？

- 每个 MCP Server 启动都有**冷启动开销**
- 工具列表越长，AI 的**决策准确度越低**（它会在 20 个工具里迷路）
- **安全面越大**（每个 Server 都可能是潜在风险）

**建议**：默认 3 件套（Context7 / filesystem / github），遇到具体需求再加。

### MCP 能帮我自动发 App Store 吗？

理论上有 MCP 能调 fastlane，但**不建议**。发版是高风险操作，应该：

- 自己跑 `fastlane deliver` 或 Xcode GUI 上传
- AI 只负责生成 release notes / changelog，不动发布流水线

参见 [进阶篇/06-安全边界 § iOS](../06-AI编程安全边界/README.md#-ios-场景的安全边界)。

### iOS 原生调 MCP 能做到吗？

**MCP 是面向 AI 工具（Claude Code / Cursor / ...）的协议，不是面向 iOS app 的**。iOS app 需要调 AI 走 Claude API / OpenAI API。
如果你想做一个"app 里集成 MCP server 供云端 AI 调用"，那是另一层工程 —— 不在本书范围。

---

## 相关资源

- 上一页：[03-自建 MCP Server](03-自建MCP-Server.md)
- 章节首页：[02-MCP 协议](README.md)
- 配合阅读：[进阶篇/08-02-浏览器工具与 MCP 生态](../08-ClaudeCode新功能/02-浏览器工具与MCP生态.md)、[进阶篇/06-AI 编程安全边界 § iOS](../06-AI编程安全边界/README.md#-ios-场景的安全边界)
