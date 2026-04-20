# 写作风格速查

> 本页是**写作时手边的那张小抄**。完整的撰写/维护规范请看仓库根目录的 [`AGENTS.md`](https://github.com/kaelinda/aicoding-guide-book/blob/main/AGENTS.md)——它才是权威。
>
> 两者分工：这里给"写一页前扫一眼就够"的要点；AGENTS.md 给"这条为什么这样要求"。

---

## 章节骨架（强烈推荐）

一篇正文（README 或子页）按下面顺序铺：

```
# 标题
> 一句话概述（≤ 40 字，点出读者能拿到什么）

## 🤔 是什么
## 🎯 为什么重要
## 🛠 怎么做
## 💡 最佳实践
## ⚠️ 常见问题
## ✅ 小结
## 🔗 相关资源
```

不是每节都必填——**可以少，不能乱**。长度 < 150 行可以并成"是什么 / 怎么做 / 小结 / 资源"四段。

---

## 标题层级

- 每页**只有一个** `#`，即页面标题。
- 章节用 `##`，子点用 `###`。不要跳级（不要 `##` 直接到 `####`）。
- SUMMARY.md 里的层级由**缩进 2 空格**控制，不要在 SUMMARY 里用 `###`。

---

## 术语与命名

| 场景 | 写法 |
|------|------|
| 工具名 | Claude Code、Cursor、Codex（**带空格**，大小写照官方） |
| 中文术语 | 首次出现用"Agent（智能体）"，之后统一用 Agent |
| 文件 / 目录名 | 紧凑无空格（`ClaudeCode实战/`），URL 友好 |
| 文件名里的标点 | 避免中文全角 `：`/`，`——` URL 编码后很丑 |

已钦定的写法（不要再造词）：

- ✅ **Agent**（首次出现加"（智能体）"注，之后单写 Agent）— ❌ 代理人 / AI 机器人 / 单独写"智能体"
- ✅ **Multi-Agent** / **多 Agent**（中文与英文之间保留一个空格）— ❌ 多Agent / 多智能体 / Multi Agent（少连字符）
- ✅ Prompt / 提示词 — ❌ 提示语 / 指令词
- ✅ 上下文 / Context — ❌ 语境 / 情景
- ✅ MCP（Model Context Protocol）— ❌ MCP 协议服务（冗余）

---

## 链接策略

- **内链用相对路径**，和真实文件大小写一致（macOS 默认大小写不敏感，Linux CI 会挂）。
- **外链优先官方**：Anthropic / OpenAI / Apple / modelcontextprotocol.io。
- **跨内容根链接**：`resources/` 在 `docs/` 之外，GitBook 不会抓，必须写 GitHub 绝对 URL。
- 新增/改名页面后**同步改** `docs/SUMMARY.md`。

---

## 代码块

| 要求 | 示例 |
|------|------|
| 必须带语言标签 | ` ```swift ` / ` ```bash ` / ` ```yaml ` |
| shell 命令 | 去掉 `$`，直接写命令（方便复制） |
| 长命令 | 用 `\` 换行，不要横向滚动超过一屏 |
| 占位符 | 用尖括号 `<your-api-key>`，不要 `xxx` |

反例：

```
# ❌ 没语言标签 + 带 $ + xxx 占位
$ claude --api-key xxx
```

正例：

```bash
# ✅
claude --api-key <your-api-key>
```

---

## iOS 读者优先

这本书的主读者是 iOS 开发者。所以：

- **通用示例后补一个 Swift 版**。如果某章全是 Python/JS，它对 iOS 读者就是半成品。
- **涉及 API / SDK** 时，注明 iOS 最低版本（如"SwiftData 需要 iOS 17+"）。
- **iOS 专题**页面放 `docs/ios-*.md` 或以后的 `docs/iOS专题/`，不要散落在其他篇里。

---

## 截图与可访问性

- 截图前先马赛克 API Key、邮箱、用户名。
- 所有图片写 `alt` 文本，失效时读者至少知道图讲什么。
- 动图控制在 5MB 以内，优先用文本 transcript 替代。

---

## 要避免的反模式

- ❌ "**超级简单**"、"**一键搞定**"、"**颠覆性**" —— 营销语；用具体时间/步数代替。
- ❌ TODO / 待补充 / Coming soon —— 写了就要完成，否则不要入 SUMMARY。
- ❌ 纯文字墙 > 200 行没有一个表/代码块/子标题 —— 读者会弃文。
- ❌ 章节末尾只丢一句"下一章见" —— 用"🔗 相关资源"给出下一步的 3 个可选路径。

---

## 更多

- 详细写作规范 / Source 分级：[`AGENTS.md`](https://github.com/kaelinda/aicoding-guide-book/blob/main/AGENTS.md)
- PR 检查清单：[`CONTRIBUTING.md`](https://github.com/kaelinda/aicoding-guide-book/blob/main/CONTRIBUTING.md)
- 术语释义：[`glossary.md`](glossary.md)
