# 04-Prompt 版本管理

> 把 Prompt 当代码管理。**沉淀 > 即兴**。

---

## 为什么要管理 Prompt

每次临时想 Prompt 有三个问题：

1. **重复劳动**：同一种任务每次都从头想
2. **效果飘忽**：同样的请求换种说法，AI 输出可能差很多
3. **经验不传承**：一个踩坑的 prompt 改好后没沉淀，下次还是错

**把 Prompt 当代码管理**的价值：

- 反复使用的 Prompt 固化下来（不用每次临时想）
- 团队成员共享同一套（输出风格一致）
- 出问题可以追溯"上次改了什么导致变差"

---

## 四种沉淀层级（从临时到最稳定）

### Level 1：剪贴板（临时用）

写在便签、`snippets.md`、Raycast snippets 里。**零投入，每次要手动选**。

**适合**：用得不多的 Prompt、还在调整中的草稿。

```markdown
# ~/Documents/snippets.md

## bug-triage
先不要改代码：
- 判断问题类型（状态 / 并发 / 生命周期 / 网络）
- 列出你要读的文件
- 给 3 个可能根因，按可能性排序

## api-verify
你提到的 <API>，请做两件事：
1. 给 Apple 官方文档链接
2. 用 Context7 MCP 搜一下这个符号是否存在
如果找不到，明确告诉我你之前说错了。
```

### Level 2：Slash Command / Shortcut

Claude Code 的 `/command` 或 Cursor 的自定义快捷键。

Claude Code 示例：项目根 `.claude/commands/bug.md`

```markdown
---
description: Bug 排查模板
---

先不要改代码：
- 判断问题类型（状态 / 并发 / 生命周期 / 网络）
- 列出你要读的文件（最多 5 个）
- 给 3 个可能根因，按可能性排序
- 每个根因给"最快能验证它是不是"的方法

Bug 描述：$ARGUMENTS
```

使用：`/bug 登录按钮点两次才响应`

**适合**：个人或团队反复使用的工作流类 Prompt。

> 📌 Slash command 的 frontmatter 字段和 `$ARGUMENTS` 语法以 [Claude Code 官方文档](https://docs.claude.com/claude-code) 为准，不同版本可能略有差异。

### Level 3：Skill

Skill 比 Slash Command 多一层"自动识别触发条件"。

```markdown
---
name: ios-reviewer
description: Review SwiftUI/UIKit 代码。自动在 iOS 项目里触发。
tools: [Read, Grep, Glob]
---

你是资深 iOS 代码审查员。按 🔴 必改 / 🟡 建议 / 🟢 可忽略 三档输出。
重点检查：
- @State / @StateObject / @Observable 误用
- 主线程阻塞
- 循环引用
- 缺失的边界处理
```

**适合**：复杂到值得专门"人格化"的 Prompt —— 见 [实战篇/01-05 常用 Skills](../../实战篇/01-ClaudeCode实战/05-ClaudeCode常用Skills.md)。

### Level 4：`CLAUDE.md` / `.cursorrules` / `AGENTS.md`

稳定的、不会变的项目级约束 —— 跨所有会话生效。

```markdown
# 项目/CLAUDE.md

## 工作约定（Prompt 层级）
- 不说"应该没问题"。结论必须附验证命令
- 不猜 API，不确定的签名用 Context7 MCP 查官方文档
- 改动 > 200 行自动停下报告
```

**适合**：**所有会话都应该遵守**的铁律。见 [进阶篇/09 Claude Code 写法教程](../09-ClaudeCode写法教程/README.md)。

---

## 怎么选层级

| Prompt 特性 | 推荐层级 |
|------|------|
| 临时的、一次性的 | Level 1 |
| 每周用 3+ 次的 | Level 2（Slash Command） |
| 长且复杂、跨多步的 | Level 3（Skill） |
| 整个项目 / 整个团队都该遵守的 | Level 4（CLAUDE.md） |

**经验法则**：**先在 Level 1 用稳定 3 次，再升到 Level 2+**。别一上来就建 Skill，改起来麻烦。

---

## 团队共享

### 入 git 的

- `.claude/commands/`（Slash Commands）
- `.claude/agents/`（Subagent 定义）
- `CLAUDE.md`（项目级约束）
- `AGENTS.md`（Codex 项目级）
- `.cursorrules`（Cursor 项目级）
- 公共 Prompt 模板放 `docs/prompts/` 或类似目录

### 不入 git 的

- `~/.claude/CLAUDE.md`（个人全局）
- `.claude/settings.local.json`（个人的项目内覆盖）
- 含 secrets 的 Prompt（**所有 secrets 走环境变量，不写进 Prompt**）

### PR Review 时的 Prompt 变更

Prompt 变更**也要 review**。一行 `.claude/commands/bug.md` 的改动可能影响整个团队下周的工作方式。

Review 关注：

- 新加的约束是否真有必要
- 有没有引入不确定性（"你觉得"、"可能"这种词）
- 和已有 Prompt 有没有冲突

---

## 实用示例：把反复用的 Prompt 升级成 Slash Command

### 步骤

**1. 先用 Level 1 跑一段时间**

`~/Documents/prompts.md` 里：

```markdown
## 验证 prompt
刚才的改动：
- 改了哪些文件：<列出>
给：
1. 具体验证命令
2. 3 个边界测试用例（不是 happy path）
3. "看起来没问题但可能出问题"的场景
```

用了 10+ 次，确认稳定。

**2. 升级到 Slash Command**

项目 `.claude/commands/verify.md`：

```markdown
---
description: 让 AI 列出验证步骤和边界测试
---

刚才的改动：
- 改了哪些文件：$ARGUMENTS

现在请：
1. 给具体验证命令（xcodebuild / swift test / 手工点击）
2. 给 3 个边界测试用例（不是 happy path）
3. 说明有哪些场景"看起来没问题但可能出问题"

不要声称"应该没问题"。只写能被验证的东西。
```

使用：`/verify LoginView.swift, LoginViewModel.swift`

**3. 进一步沉淀**

发现团队里每个人都在用 `/verify`，而且都加了"不要声称应该没问题"这句。
**把这条铁律提升到 CLAUDE.md**：

```markdown
# 项目/CLAUDE.md
## 铁律
- 不说"应该没问题"。结论必须附验证命令。
```

之后连 `/verify` 都可以精简（因为铁律已经生效）。

---

## 反模式

### ❌ Slash Command 越建越多（100+ 个）

AI 看到太多命令会在选择上犹豫。**控制在 20 个以内**，重叠的合并。

### ❌ 把所有经验都塞进 CLAUDE.md

CLAUDE.md 会塞进每次会话上下文。太长 = token 浪费 + AI 忽略部分条目。
**50-150 行是舒适区间**。超过拆到外部文件、在 CLAUDE.md 里指路。

### ❌ Prompt 模板带 secret

```text
❌ /bug 登录失败，API key 是 sk-xxx
✅ /bug 登录失败  # secret 走环境变量
```

### ❌ 复制别人的 Prompt 套用

别人的 Prompt 是他们踩的坑，不是你的。
**借鉴结构、不借鉴内容**。内容基于你自己踩过的坑填。

---

## 相关资源

- 上一页：[03-调试 Prompt](03-调试Prompt.md)
- 下一页：[05-iOS 场景示例](05-iOS场景示例.md)
- 配合阅读：[进阶篇/09 CLAUDE.md 教程](../09-ClaudeCode写法教程/README.md)、[实战篇/01-13 我的常用 Prompt](../../实战篇/01-ClaudeCode实战/13-ClaudeCode我的常用Prompt.md)
- Prompt 模板库：[examples/prompts/](../../examples/prompts/)
