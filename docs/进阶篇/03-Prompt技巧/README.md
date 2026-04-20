# 03-Prompt 技巧

> 好的 Prompt = 清晰需求 + 明确上下文 + 可执行指令。**结构 > 辞藻**。

---

## 一句话

**AI 输出质量 = 你的输入质量**。这一章讲怎么写出稳定产出 Level 2-3 的 Prompt。

---

## 本章五个子页

| 文档 | 讲什么 | 你读完能做到 |
|------|------|------|
| [01-结构化 Prompt](01-结构化Prompt.md) | 五要素（角色 / 任务 / 上下文 / 约束 / 示例）、5 个核心技巧（具体化 / 场景化 / 示例驱动 / 分步骤 / 反馈）、质量自检 8 项 | 写出结构完整的 Prompt |
| [02-需求澄清模板](02-需求澄清模板.md) | 新功能模板 + 重构模板 + 3 种场景策略（原型 / 生产 / 学习） + 反向提问 + 角色扮演 | 把模糊需求谈成清晰任务 |
| [03-调试 Prompt](03-调试Prompt.md) | Bug 模板 + 性能模板 + 链式迭代修复 + 5 种常见错误 + 3 种反模式 | 修 bug 时不让 AI 猜测性修复 |
| [04-Prompt 版本管理](04-Prompt版本管理.md) | 4 个沉淀层级（剪贴板 → Slash Command → Skill → CLAUDE.md）、怎么选、团队共享、反模式 | 把 Prompt 当代码一样管理 |
| [05-iOS 场景示例](05-iOS场景示例.md) | 8 个 iOS 场景 prompt 模板（SwiftUI 页面 / bug 定位 / crash log / 测试 / 重构 / 签名 / 接手项目 / 验收） | 直接粘来就能用 |

---

## 快速速记

| 情况 | 看哪页 |
|------|------|
| "Prompt 结构怎么写" | [01-结构化 Prompt](01-结构化Prompt.md) |
| "需求不清楚怎么开头" | [02-需求澄清模板](02-需求澄清模板.md) |
| "bug 修不好 / 越修越多" | [03-调试 Prompt](03-调试Prompt.md) |
| "好用的 Prompt 怎么存起来复用" | [04-Prompt 版本管理](04-Prompt版本管理.md) |
| "iOS 场景可粘贴的 prompt" | [05-iOS 场景示例](05-iOS场景示例.md) |

---

## 核心原则

- **Prompt 质量 = 输出质量**
- **结构 > 辞藻**：五要素齐就够了，不需要花言巧语
- **先定位再修**（调试场景）/ **先澄清再做**（新功能场景）
- **反馈驱动**：一次写不完美正常，迭代是常态
- **沉淀大于即兴**：用得顺的 Prompt 升级成 Slash Command / Skill / CLAUDE.md

---

## 相关资源

### 官方
- [Anthropic Prompt Library](https://docs.anthropic.com/claude/prompt-library) ⭐⭐⭐⭐⭐
- [OpenAI Prompt Engineering Guide](https://platform.openai.com/docs/guides/prompt-engineering) ⭐⭐⭐⭐⭐

### 学习
- [Prompt Engineering Guide](https://www.promptingguide.ai/) ⭐⭐⭐⭐
- [Learn Prompting](https://learnprompting.org/) ⭐⭐⭐⭐

### 配合阅读
- [examples/prompts/](../../examples/prompts/) —— 本书的 Prompt 模板库（7 个）
- [实战篇/01-13 我的常用 Prompt](../../实战篇/01-ClaudeCode实战/13-ClaudeCode我的常用Prompt.md) —— 作者日常用的 7 条

---

**下一步：** [Rules 与 Skill →](../04-Rules与Skill/README.md)
