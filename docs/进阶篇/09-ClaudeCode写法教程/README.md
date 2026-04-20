# Claude Code 写法教程

> `CLAUDE.md` 是 Claude Code 读你项目时第一件事看的文件。写好它 = 每次开 session 省下一半废话。

---

## 这一节讲什么

- `CLAUDE.md` 到底是什么、放哪儿、Claude Code 什么时候读
- **3 分钟能抄走的最小模板**
- 个人 / 项目 / 全局三层怎么分
- 常见反模式（会让 CLAUDE.md 适得其反）
- 想深入：进 [claude.md 完整教程](./claude.md-教程.md)

---

## `CLAUDE.md` 是什么

Claude Code 启动时会**自动把 `CLAUDE.md` 的内容加载进系统提示**（system prompt）。效果等同于你每次开会话都先粘一遍。

```
~/.claude/CLAUDE.md          # 全局：你个人所有项目都生效
<project>/CLAUDE.md          # 项目级：团队共享（入 git）
<project>/.claude/CLAUDE.md  # 项目私有 Claude 配置旁的补充（可选）
```

三层会被合并读取。**全局写你自己的习惯、项目级写团队共识、不要重复**。

---

## 最小模板（抄走就能用）

```markdown
# <项目名>

> 一句话说这个项目是干什么的。

## 技术栈

- Swift 5.9, SwiftUI, iOS 17+
- SwiftData 持久化，Swift Testing 单测
- 第三方库：Kingfisher, swift-collections

## 目录

- `Sources/Views/`   — SwiftUI 视图
- `Sources/Models/`  — 领域模型 + @Observable
- `Sources/Services/` — 网络 / Keychain / 本地存储
- `Tests/`           — Swift Testing 用例

## 工作约定

- 每次改动先跑 `xcodebuild test -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15'`
- 不新增依赖；如必须，先在 issue 里讨论
- 不修改 `Sources/Services/Auth/`（走单独评审流程）
- 不把 token / 凭证放 UserDefaults；一律 Keychain

## 约束

- 不顺手 format、不重命名变量（除非我要求）
- 不猜 API；不确定的签名用 Context7 MCP 查官方文档
- 不声称"应该能跑"；结论必须附验证命令

## 常用命令

- 装依赖：`xcodebuild -resolvePackageDependencies`
- 跑测试：`xcodebuild test -scheme MyApp ...`
- 生成 Preview：Xcode 内 `Cmd+Option+Enter`
```

抄完这份，你的 Claude Code 会从"每次重新讲规则"变成"进门就知道你要什么"。

---

## 三层文件怎么分

| 层 | 路径 | 写什么 |
|------|------|------|
| 🌐 全局 | `~/.claude/CLAUDE.md` | 你个人跨所有项目的偏好（"中文回答、commit 用 Conventional Commits、拒绝空泛'应该没问题'"） |
| 📁 项目 | `<项目根>/CLAUDE.md` | 项目技术栈、目录、团队共识、红线（入 git，所有人共享） |
| 🔒 项目私有 | `<项目根>/.claude/CLAUDE.md` | 只对这个项目生效的个人补充（可 `.gitignore`） |

---

## 什么时候更新 `CLAUDE.md`

踩坑 → 记一笔。不用追求完美，只记**下次会再踩的**：

- 发现 AI 把 token 写进 UserDefaults 之后 → 加一行"禁止 UserDefaults 存凭证"
- 发现 AI 漏了 Privacy Manifest 就发布 → 加一行"涉及新网络能力先核对 Required Reason API"
- 发现 AI 给 SwiftUI 页面用了废弃的 `NavigationView` → 加一行"只用 `NavigationStack`，iOS 16+"

**经验法则**：**同一个坑踩第二次**就该更新 CLAUDE.md。

---

## 反模式（这些写法会适得其反）

### ❌ 写成一本小书

CLAUDE.md 会塞进每次会话上下文。500+ 行的 CLAUDE.md 吃掉大量 token，还容易让 AI 忽略其中某几条。

**经验区间：50-150 行正好。**超过就拆子文件，用"详细规范见 `docs/coding-style.md`"这样的指针。

### ❌ 写成愿景宣言

"我们追求极致的用户体验和工程卓越..." —— AI 读了等于没读。
CLAUDE.md 要写**可执行的约束**：什么能做、什么不能做、怎么验证。

### ❌ 只写禁令不写正面指引

一列 30 条"不许..."，AI 会处处畏手畏脚、每件事都先问。
**禁令 + 正面指引 1:2**：告诉它红线，同时告诉它"通常这样做就对"。

### ❌ 不随项目更新

项目上了 iOS 18、换了 SwiftData，CLAUDE.md 还写着"iOS 15 / Core Data"。结果 AI 按老规矩办事。
**每次重大技术栈升级都复查一次 CLAUDE.md**。

### ❌ 偷懒复制粘贴别人的

别人的 CLAUDE.md 是他们踩的坑，不是你的。直接复制经常出现"你根本不需要的约束"和"你真正需要的约束没写"。
**起步用模板，之后 2 周内只根据你实际遇到的问题增改**。

---

## 子页

| 文档 | 讲什么 |
|------|------|
| [claude.md 完整教程](./claude.md-教程.md) | 从基础结构、多环境配置、到团队协作的完整指南，附实战案例 |

---

## 相关资源

- 本书：[实战篇/01-07 记忆管理](../../实战篇/01-ClaudeCode实战/07-ClaudeCode记忆管理.md) — 会话内记忆与 CLAUDE.md 的配合
- 本书：[进阶篇/04 Rules 与 Skill](../04-Rules与Skill/README.md) — Rules 和 CLAUDE.md 的定位差异
- 本书：[实战篇/01-04 使用技巧](../../实战篇/01-ClaudeCode实战/04-ClaudeCode使用技巧.md) — "善用 CLAUDE.md"小节
- 官方文档：[Claude Code](https://docs.claude.com/claude-code)（以官方为准）
