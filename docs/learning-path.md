# 阅读指引

> 不是四周冲刺课，是一份**按顺序读就不会绕弯**的路线。每一段标了预计投入，按需跳读。

---

## 📍 怎么读这本书

- **如果你从没用过 AI 编程工具** → 从 [快速开始](00-quick-start.md) 跑通第一个 demo，再按"基础 → 进阶 → 实战 → 大师"顺序读。
- **如果你用过 Copilot/ChatGPT 但没用过 Claude Code/Cursor/Codex** → 跳过"基础篇 01 环境搭建"的常识部分，直接看 [基础篇 02 工具安装](基础篇/02-工具安装/README.md) 和 [进阶篇 01 Agent 概念](进阶篇/01-Agent概念/README.md)。
- **如果你在找某个具体问题的答案** → 直接查 [FAQ](FAQ.md) / [cheat-sheet](cheat-sheet.md) / [术语表](glossary.md) / [Prompt 模板库](examples/prompts/README.md)。

---

## 🗺️ 四大篇的作用

| 篇 | 解决什么问题 | 预计时长 | 出口能力 |
|----|------------|---------|---------|
| [基础篇](基础篇/01-环境搭建/README.md) | 环境装不上 / 工具不会选 / 没做过 AI 辅助的第一个项目 | 3~6 h | 能独立跑起一个 AI 生成的 SwiftUI 小页面 |
| [进阶篇](进阶篇/01-Agent概念/README.md) | 概念没有系统理解（Agent / MCP / Prompt / Rules）、结果验收靠感觉 | 6~10 h | 能写出稳定产出的 Prompt，能配 AGENTS.md / .cursorrules |
| [实战篇](实战篇/01-ClaudeCode实战/README.md) | 某个工具的具体操作、翻车案例、iOS 专项场景 | 按需 | 能把某个工具真的用进自己的日常工作流 |
| [大师篇](大师篇/01-多Agent协作/README.md) | 多 Agent 编排 / 远程 Coding / 个人工作流体系化 | 按需 | 有自己的一套"AI 编程管线"，而非散点使用 |

---

## ✅ 每篇的"读完这一步"信号

读完不是"翻完页面"，而是**能完成下面这件事**。做不到就回去重读。

### 基础篇读完

```bash
# 验证 1：工具可用
claude --version        # 能输出版本号
node -v                 # ≥ v20
xcodegen version        # 能输出版本号（如使用）

# 验证 2：能跑通 quick-start 的 iOS 项目，Xcode 里模拟器上能看到 "Hello, AI!"
```

能用一句 Prompt 让 Claude Code 生成一个能编译通过的 SwiftUI 页面。

### 进阶篇读完

- 能用自己的话（不抄书）解释：**Agent / MCP / Prompt / Rules** 四个词的区别。
- 会写一份 `AGENTS.md` 或 `CLAUDE.md`，至少包含：技术栈、禁止事项、测试要求 3 节。
- 知道至少 3 条"AI 生成代码的典型翻车"并说得出检查清单。

### 实战篇读完（至少挑一个工具）

- 能在这个工具里做一次"完整小功能"：从 Prompt 设计 → 生成 → 验收 → 修改 → 合入。
- 遇到报错时，不是"直接复制给 AI"，而是先自己定位范围。

### 大师篇读完

- 能说清楚"什么场景值得上多 Agent，什么场景不值得"。
- 自己的项目里**至少有一个持久化的 AI 工作流**（不是一次性 demo）。

---

## 🧭 推荐的第一个 1~2 小时

如果你时间紧张，这是性价比最高的路径：

1. [快速开始](00-quick-start.md)（10~15 分钟）— 先跑通一个能看见结果的 demo。
2. [基础篇 02 · Claude Code 安装](基础篇/02-工具安装/01-claude-code.md)（15 分钟）— 补齐 quick-start 里略过的配置项。
3. [进阶篇 03 · Prompt 技巧](进阶篇/03-Prompt技巧/README.md)（30~40 分钟）— 学会"怎么问"比学会"工具怎么按"更重要。
4. [Prompt 模板库](examples/prompts/README.md) 挑 1~2 个模板照着做（30 分钟）。

做完这 4 步，你已经**能用 AI 交付一个可验收的小功能**。剩下的按需深入。

---

## 🧪 按场景跳读

| 你现在卡在… | 直接看 |
|------------|--------|
| AI 生成的代码能跑但结果不对 | [实战篇 · 失败案例与修复](实战篇/04-失败案例与修复/README.md) |
| 想让 AI 理解我的项目上下文 | [进阶篇 04 · Rules 与 Skill](进阶篇/04-Rules与Skill/README.md) |
| 不知道 Claude Code / Cursor / Codex 怎么选 | [基础篇 02-04 · 对比选择](基础篇/02-工具安装/04-对比选择.md) |
| 想让 AI 生成 SwiftUI 页面更稳 | [实战篇 · iOS 专项场景](实战篇/05-iOS专项场景/README.md) |
| 担心 AI 改错重要文件 | [进阶篇 06 · AI 编程安全边界](进阶篇/06-AI编程安全边界/README.md) |
| 想看别人怎么用 | [最佳实践案例集](best-practices.md) |

---

## 📚 延伸资源

- [SwiftUI 官方教程](https://developer.apple.com/tutorials/swiftui)
- [Stanford CS193p（SwiftUI）](https://cs193p.sites.stanford.edu/)
- [Anthropic · Claude Code 文档](https://docs.claude.com/claude-code)
- [OpenAI · Codex](https://openai.com/codex/)
- [Model Context Protocol](https://modelcontextprotocol.io/)

---

> 这份指引本身也在迭代。如果你按这个顺序读完发现有更好的路径，欢迎在 GitHub 开 issue。
