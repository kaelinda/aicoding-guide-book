# TODO

> 内容层面的补全计划。按"先修 bug → 再填占位 → 再做增量"的顺序排优先级。

## 🔴 P0 — 已知存在的坏链 / 盲区（应尽快修）

链接检查跑出来的，pre-existing，都是一行两行可修：

- [ ] `docs/进阶篇/10-ClaudeCode环境配置/README.md` 引用了三个不存在的子页，需要**新写**或**从 README 里删掉这三个条目**：
  - `LLM-gateway.md`（LLM 网关如 LiteLLM / OpenRouter 接入）
  - `Azure-Foundry.md`（Azure AI Foundry 接入）
  - `Bedrock.md`（AWS Bedrock 接入）
- [ ] `docs/大师篇/03-高级工作流/README.md` 里 `../../resources/README.md` 少了一层，应改为 `../../../resources/README.md`（或删掉这个外链，把 resources/ 搬进 docs/ 内）
- [ ] `docs/基础篇/05-练习项目/README.md` 里 `../实战篇/README.md` 少了一层，应为 `../../实战篇/01-ClaudeCode实战/README.md`
- [ ] `docs/进阶篇/09-ClaudeCode写法教程/claude.md-教程.md` 存在但**未进 SUMMARY**，要么补进目录，要么合并到 README

## 🟡 P1 — 占位 / 过薄章节（骨架在，肉没长出来）

目录里有一级章节，但内容停在索引页，读者点进去只能看到一份导航表：

- [ ] **基础篇/04 Agent 与工具** — 目前 README 只有 20 行索引 + 一个孤儿子页 `03-Agents.md`。需要把"Agent / 工具调用 / function calling"的概念拆成独立子章
- [ ] **进阶篇/09 Claude Code 写法教程** — README 只有 21 行，实际内容全部压在单个 `claude.md-教程.md` 里且未入 TOC
- [ ] **进阶篇/02 MCP 协议** — 单 README 389 行，建议拆：「MCP 是什么」「常见 MCP server 生态（github / playwright / filesystem / notion / context7 …）」「自建 MCP server」
- [ ] **进阶篇/03 Prompt 技巧** — 466 行压一页，建议拆：「结构化 Prompt」「需求澄清模板」「调试 Prompt」「Prompt 版本管理」
- [ ] **大师篇/01 多 Agent 协作** — 409 行单页，但大师篇整体应有更多案例而非一篇综述
- [ ] **实战篇/02 Cursor 实战** — 486 行全在 README，没子页；对比 ClaudeCode 实战 13 个子页显得薄
- [ ] **实战篇/03 Codex 实战** — 526 行全在 README，同上

## 🟢 P2 — 明显的内容缺口（当前目录没覆盖，读者会问的）

### 工具链完整性

- [ ] **2026 主流新工具横评**：Windsurf / Zed AI / Aider / Copilot CLI — 目前只讲 Claude Code / Cursor / Codex
- [ ] **本地模型 / 离线方案**：Ollama、LM Studio、MLX（Apple Silicon 原生）— iOS 开发者关心
- [ ] **成本与额度管理**：token 成本、缓存命中率、月账单拆解、团队预算控制
- [ ] **API Key / Secret 管理**：keychain、1Password CLI、direnv、`.env` 反模式
- [ ] **IDE 集成**：VSCode / Xcode + AI 扩展（Xcode 16 的 Predictive Code Completion 等）

### 进阶篇补强

- [ ] **Hooks / Skills 实战章**：Claude Code hooks 和 Skills 在 SUMMARY 里有一行，但没有写作指南（"如何写一个自己的 Skill"）
- [ ] **上下文工程（Context Engineering）**：长对话压缩、记忆系统、跨会话 state
- [ ] **Git + AI 工作流**：AI 驱动的 commit message / PR description / code review / rebase 冲突解决
- [ ] **测试生成与验收**：当前只在失败案例里提了一嘴，应该有专章讲"如何让 AI 写能跑的测试"
- [ ] **重构工作流**：小步重构、AI 辅助的大规模迁移、安全网

### iOS 专题扩容

当前只有 6 个扁平文件，覆盖 skills / 调试 / 发布 / 面试 / 工具 / index。缺：

- [ ] **SwiftData / Core Data 迁移**：让 AI 帮你从 Core Data 迁到 SwiftData
- [ ] **测试生成**：XCTest / Swift Testing 单测、UI 测试生成
- [ ] **Privacy Manifest**：AI 辅助合规（iOS 17+ 必须）
- [ ] **StoreKit / IAP**：订阅逻辑这种容易错的，AI 怎么兜底
- [ ] **Widget / Live Activity / App Intents**：新 API 配套的 AI 使用手册
- [ ] **Xcode Cloud / fastlane**：CI 层的 AI 介入
- [ ] **调优落地案例**：`ios-debug-and-performance.md` 是清单式的，缺一个真实 app 降耗电 / 降启动耗时的 walkthrough

### 模板库扩容

`docs/examples/prompts/` 只有 7 个模板（需求澄清 / bug / 重构 / 测试 / review / 从零生成 / PR）。补：

- [ ] **迁移模板**（框架/语言迁移、版本升级）
- [ ] **API 设计模板**（REST / GraphQL contract）
- [ ] **SQL / 数据建模模板**
- [ ] **正则 / 复杂字符串处理模板**
- [ ] **Shell / 一次性脚本模板**
- [ ] **文档生成模板**（从代码反推 README / 架构图）

### 参考资料

- [ ] **CHANGELOG.md 有文档更新流程吗？** 规定一下每次改章节要不要记一笔
- [ ] **术语表（glossary）**持续扩容：Agent / MCP / Context / Skill / Hook / Artifact / Sandbox / Agentic Loop
- [ ] **FAQ** 跟着读者问题滚动扩容（目前像一次性快照）
- [ ] **best-practices.md** 案例集可以按工具 / 按场景分类

## 🗂️ 结构性决策（需要你拍板的，不是 TODO 而是未决问题）

- [ ] `docs/大师篇/` 下的 `04-驾驭工程：与AI智能体协作的艺术.md` 是一篇独立长文，和其他三章（多 Agent / OpenClaw / 高级工作流）调性不一致。是拆到「附录 / 深度好文」还是升格为大师篇的总结章？
- [ ] `resources/` 目录在 GitBook 内容根 `docs/` 之外，GitBook 不会抓。是搬进 `docs/resources/` 让它进目录，还是保持"只给 GitHub repo 用"？
- [ ] iOS 专题扁平在 `docs/ios-*.md`，其他篇章都是子目录结构。是否把它们收进 `docs/iOS专题/`？（注意：改目录会影响 GitBook 现有阅读历史。）

---

**使用方式**：认领一项就打勾，对应章节写完后记得同步更新 `docs/SUMMARY.md`。不要在这份 TODO 里写细化设计；细化进专门的 issue 或 PR 描述。
