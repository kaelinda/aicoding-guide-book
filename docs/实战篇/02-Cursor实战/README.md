# 02-Cursor 实战

> Cursor = VS Code + 深度集成的 AI。**零学习成本上手，上限靠 `.cursorrules`**。

---

## Cursor 是什么

基于 VS Code 的 AI 增强编辑器，内置 Claude / GPT 系列模型，默认带四件套：对话、内联编辑、Tab 补全、代码库语义搜索。

**核心优势**：

- 🎨 熟悉的 VS Code 体验，零学习成本
- 🤖 内置多种主流模型，切换方便
- 📝 Tab 补全比多数对手更激进（能补整段代码）
- 💬 自然语言，中文也行
- 🔍 代码库**语义**搜索，不用靠关键词

**对比主流方案**：

| 维度 | Cursor | VS Code + Copilot | Xcode |
|------|--------|-------------------|-------|
| AI 深度 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| iOS 支持 | ⭐⭐⭐⭐（需配合 Xcode） | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 学习曲线 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| 订阅价格 | $20/月 | $10/月 | 免费 |

---

## 安装

1. 访问 <https://cursor.sh>
2. 下载 macOS 版 `.dmg`
3. 拖进 Applications、打开
4. 登录（Google / GitHub）
5. 如果你是 VS Code 用户：Cursor 会自动检测并一键导入扩展和设置

---

## 本章四个子页

| 文档 | 讲什么 | 读完能做到 |
|------|------|------|
| [01-核心功能](01-核心功能.md) | Chat / Inline Edit / Tab / 代码库搜索 四个快捷键的用法 | 流畅用 Cursor 写普通代码 |
| [02-iOS 开发实战](02-iOS开发实战.md) | 创建 SwiftUI 视图 / 重构 UIKit / 修 bug / 生成单测 四个 iOS 场景 | 知道 iOS 场景下怎么和 Cursor 协作 |
| [03-高级技巧](03-高级技巧.md) | `.cursorrules` / 多文件批量编辑 / 代码审查 / 文档生成 | 把 Cursor 从"辅助打字"升级到"辅助工程" |
| [04-配置与常见问题](04-配置与常见问题.md) | 推荐 settings.json / 扩展 / 常见坑 + 和 Claude Code 配合 | 从能用变到用得爽 |

---

## 快速速记

| 情况 | 看哪页 |
|------|------|
| "快捷键记不住" | [01-核心功能](01-核心功能.md) |
| "SwiftUI 页面怎么让 AI 帮我写" | [02-iOS 开发实战](02-iOS开发实战.md) |
| "`.cursorrules` 怎么写才不废" | [03-高级技巧](03-高级技巧.md) |
| "模拟器 / 扩展 / 字体 / 代理设置" | [04-配置与常见问题](04-配置与常见问题.md) |

---

## 和 Claude Code 的关系

**不是二选一**。常见组合：

- **Cursor** 做日常编辑、Tab 补全、探索式写代码
- **Claude Code** 做终端自动化、跨文件大重构、CI 脚本
- **共享规则**：项目根 `.cursorrules` + `CLAUDE.md` 可以都有（内容略有重叠，各取所长）

详见 [04-配置与常见问题 § 和 Claude Code 配合使用](04-配置与常见问题.md#和-claude-code-配合使用)。

---

## 小结

- Cursor 是最易上手的 AI IDE
- 四个快捷键入门：`Cmd+L` / `Cmd+K` / `Tab` / `Cmd+Shift+L`
- `.cursorrules` 把团队共识写进项目
- 与 Claude Code 配合使用效果更佳

---

## 相关资源

- 进阶：[进阶篇/07-Cursor 进阶功能](../../进阶篇/07-Cursor进阶功能/README.md)（Custom Roles / Multi-Agent / Cloud Agents / Bugbot 等）
- 配合阅读：[实战篇/05-iOS 专项场景](../05-iOS专项场景/README.md)
- 官方：[cursor.sh](https://cursor.sh) / [cursor.com/docs](https://cursor.com/docs) / [forum.cursor.sh](https://forum.cursor.sh/)

---

**下一步：** [Codex 实战 →](../03-Codex实战/README.md)
