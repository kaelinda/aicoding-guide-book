# TODO

> 内容层面的补全计划。按"先修 bug → 再填占位 → 再做增量"的顺序排优先级。

## 🔴 P0 — 已知存在的坏链 / 盲区（✅ 已全部修复）

链接检查跑出来的，pre-existing：

- [x] `docs/进阶篇/10-ClaudeCode环境配置/README.md` 引用的三个未写子页（LLM-gateway / Azure-Foundry / Bedrock）—— 暂时从"相关资源"表里移除，保留一条说明指向本 TODO；三份专题接入指南的撰写收入 P2「工具链完整性」
- [x] `docs/大师篇/03-高级工作流/README.md` 末尾 `../../resources/README.md` —— 改为 GitHub 绝对链接（`resources/` 位于 `docs/` 之外，GitBook 不会抓）
- [x] `docs/基础篇/05-练习项目/README.md` 末尾 `../实战篇/README.md` —— 改为 `../../实战篇/01-ClaudeCode实战/README.md`
- [x] `docs/进阶篇/09-ClaudeCode写法教程/claude.md-教程.md` 孤儿 —— 已在 SUMMARY 中补为 09-01 子条目

## 🔵 读者视角体检（2026-04-20 新增，按第一次翻书的 GitBook 读者视角走查）

> 原则：入口一致 → 内容匹配标题 → 真实可落地 → 导航顺畅。下面条目都是 P0/P1/P2 原清单**没覆盖**的。

### A. 入口与导航一致性

- [x] **`docs/README.md` 与 `learning-path.md` 口径冲突**：~~Week 规划和 README 口径不一致~~ 已整篇重写 `learning-path.md` 为"阅读指引"：四篇作用表 + 每篇读完信号 + 按场景跳读表，去掉 Week/Day 时间表 ✅ 2026-04-20
- [x] **`learning-path.md` 调性违和**：~~徽章/里程碑/百分比网课腔~~ 已整篇重写，从 346 行压到 ≈110 行，调性改为工程向 ✅ 2026-04-20
- [x] **`learning-path.md:180-192` 把 CI/CD 列为 Week 4 必修**：~~承诺 ≠ 目录~~ 已随整篇重写删除，改为指向书里实际存在的章节 ✅ 2026-04-20
- [x] **`SUMMARY.md` 实战篇用了 `###` 三级分区**：复核后判定——实战篇的 5 块（Claude Code / Cursor / Codex / 失败案例 / iOS 场景）是**有意义的并列分组**，强行拍平会丢信息；其他篇是线性结构所以不需要。保持 `###` 分组**是 intended**，不算 bug。如果 GitBook 侧边栏渲染异常再另案处理 ✅ 2026-04-20
- [x] **`docs/README.md` 入口表遗漏**：内容地图（`README.md:31-39`）没给"失败案例与修复""iOS 专项场景"入口，但 SUMMARY 里它们是实战篇主力。建议给 README 补一张"实战篇细目"或直接指向 SUMMARY ✅ 2026-04-20
- [x] **大师篇第 4 条游离**：~~路径漂在 docs 根目录且文件名含全角冒号 `：`，分享链接会被编码成乱码~~ 已把文件搬到 `大师篇/04-驾驭工程/README.md`，SUMMARY 链接同步更新；路径目录层级与前三条齐平，URL 全 ASCII ✅ 2026-04-20

### B. 标题 ≠ 实际内容（读者点进去会失望）

- [x] **`实战篇/01-ClaudeCode实战/11-ClaudeCode完整项目实战.md` 只有 39 行** —— 已重写为 SwiftUI 番茄钟端到端 walkthrough（6 阶段 + 验证命令 + 踩坑点 + 适用/不适用场景），145 行 ✅ 2026-04-20
- [x] **同目录 10/12/13 同样过薄**（41/52/64 行）—— 全部扩写为与 04-09 同量级内容 ✅ 2026-04-20
  - `10-ClaudeCode多Agent协作.md`（~170 行）：三角色 Prompt 模板 + 完整登录 bug 修复示例 + 适用/不适用判据 + 与内置 Task 的关系
  - `12-ClaudeCode个人工作流.md`（~195 行）：修 bug / 新功能 / 重构三流程 + 每步停下信号 + 三个反模式
  - `13-ClaudeCode我的常用Prompt.md`（~170 行）：7 条 Prompt 模板，每条含场景 / 可粘 Prompt / 期望输出 / 常见偏差 / 如何纠偏 + 串成一天工作流的节奏
- [x] **`进阶篇/08-ClaudeCode新功能/` 功能名真实性问题 —— 已处置完毕** ✅ 2026-04-20
  - **删除** 2 个纯虚构页面：`01-BUDDY-AI伙伴系统.md`（AI 宠物 / 18 种生物 / 稀有度，无任何官方依据）、`03-ULTRAPLAN长期规划.md`（`/ultraplan` 命令 + 云端 30 分钟深度规划，官方不存在此功能/命令）
  - **重写** 2 个有真实内核但叙述偏离的页面：
    - 原 `02-Multi-Agent协调模式.md`（虚构"Coordinator Mode"术语）→ 新 `01-Task工具与Subagent.md`：官方 Task 工具 + subagent 上下文隔离与并行派发 + `.claude/agents/` 自定义 Agent 定义
    - 原 `04-语音与浏览器工具.md`（虚构 `VOICE_MODE` / `WEB_BROWSER_TOOL` 常量名）→ 新 `02-浏览器工具与MCP生态.md`：通过 MCP 接入 playwright / chrome-devtools 的真实路径 + 诚实说明语音目前只有社区方案
  - **重写** `README.md`：章节更名为"Claude Code 进阶特性"，显式告知历史变更，链接新的 2 个子页 + 指明不讲什么（避免和其他章重叠）
  - **同步** `SUMMARY.md`（2 个条目，从 4 降到 2），清理 `基础篇/04-Agent与工具/03-Agents.md` 和 `实战篇/01-10-多 Agent 协作` 里的反向链接
  - 原则：所有功能描述以 [Anthropic 官方 Claude Code 文档](https://docs.claude.com/claude-code) 为准，本章不再有"源码泄露"类叙述
- [x] **`基础篇/04-Agent与工具/README.md` 概念错位** —— 已重写 README 为"Agent 概念入门 + 全书导览"：一段话讲清 Agent ≠ ChatBot+1；一张表拆掉"Agent = Codex 专属"等 4 种误读；三个核心能力（Tool Use / Agentic Loop / 上下文管理）；标注 03-Agents.md 是 Codex 专题但原理通用；附全书 Agent 相关章节由浅入深导航（7 章）+ 4 个自测问题。解决了"基础篇和进阶篇/01 撞车 / 读者误以为 Agent 是 Codex 专属" ✅ 2026-04-20
- [x] **`00-quick-start.md` 的"5 分钟"承诺难以兑现**：正文要求 npm 安装 + 首次浏览器登录 + XcodeGen 安装 + 写 `project.yml` + xcodebuild，对零基础读者 ≥20 分钟。且 XcodeGen 并未列入"前提条件"（`00-quick-start.md:14-18`），是在 Q4 才补救。已改为 "10~15 分钟"，XcodeGen 上移至前提条件 ✅ 2026-04-20

### C. 术语与命名一致性

- [x] **"Claude Code" 空格不统一**：核查后确认——**所有可见文本（正文、SUMMARY 标题、README、glossary）均已使用带空格的"Claude Code"**，无空格只出现在文件路径里（`ClaudeCode实战/`），符合"文件名紧凑、正文带空格"的规则。已把这条规则写入 `writing-style.md` ✅ 2026-04-20
- [x] **Agent 中文译名漂移**：~~同一 SUMMARY 出现 4 种写法~~ 已钦定：正文一律写作 **Agent**，首次出现附注「（智能体）」；复数用 **Multi-Agent** / **多 Agent**（中英之间保留空格）；禁止单独写"智能体""代理人"。规则写入 `writing-style.md:49-50` 与 `glossary.md` Agent 条；SUMMARY/04-Agent 与工具、07-02-Multi-Agent、大师篇-04-驾驭工程 已同步；07-Cursor 子页/README 及 04-驾驭工程 正文的"多智能体"改为"多 Agent" ✅ 2026-04-20
- [x] **术语表（`glossary.md` 221 行）覆盖面不足**：未收录的高频词如 "Cloud Agents / Bugbot / Multi-Agent / Skill / Hook / AGENTS.md / Context Engineering / Agentic Loop / Subagent / Sandbox / Artifact / MCP Server / Rules / Custom Roles"。已一次性补入（BUDDY/ULTRAPLAN/VOICE_MODE 待 B1 真实性核查后再决定是否收录） ✅ 2026-04-20

### D. 可落地性（"验证信号"缺失）

- [x] **`00-quick-start.md` 的 Q1-Q4 故障排查全是"先重装"**：Q1 权限错误→改 prefix 重装；Q2 命令找不到→卸载重装；Q3 登录失败→logout 重来。已改为"先诊断（`npm root -g` / `which claude` / PATH / 登录状态） → 再动手"的结构 ✅ 2026-04-20
- [x] **`learning-path.md` 每日练习给了题目但没给验收标准**：~~读者怎么知道自己做对了~~ 已随整篇重写：每篇给出"读完信号"小节（验证命令 + 能做到的事） ✅ 2026-04-20
- [x] **iOS 读者友好度：iOS 例子覆盖不均** ✅ 全覆盖（2026-04-20）
  - [x] 进阶篇/01-Agent 概念：末尾加"📱 iOS 读者该怎么用这些概念"指路小节
  - [x] 进阶篇/02-MCP 协议：末尾加"📱 iOS 开发者的 MCP 实用清单"（Context7 / filesystem / github 三件套 + 配置 + 安全注意）
  - [x] 进阶篇/03-Prompt 技巧：末尾加"📱 iOS 版示例"小节，6 个 iOS 场景 prompt 模板
  - [x] 进阶篇/04-Rules 与 Skill：复核确认已自带大量 SwiftUI 示例（视图模板 / 反例对照等），无需补强
  - [x] 进阶篇/05-结果验收与质量检查：末尾加"📱 iOS 版验收清单"
  - [x] 进阶篇/06-AI 编程安全边界：末尾加"📱 iOS 场景的安全边界"（iOS 特有红线区 6 类、橙线区、绿线区、CLAUDE.md 防护模板、真机验证清单）

### E. 时效性（2026-04-20 视角）

- [x] **版本锚点漂移**：`00-quick-start.md:17` "Node.js 18+"—— 2026 年 Node.js 18 已 EOL（2025-04 终止），至少应写 20 LTS。`learning-path.md:34` "node -v → v20.x.x" 和快速开始不一致 ✅ 2026-04-20
- [x] **Xcode 版本漂移**：`00-quick-start.md:16` "Xcode 14.0 或更高"—— 2026 年主流已是 Xcode 16/17，建议同时给出"最低 14 / 推荐 16+"并说明哪些新功能（如 Predictive Completion）依赖高版本 ✅ 2026-04-20
- [x] **iOS 部署目标**：quick-start 的 `project.yml` 写 `iOS: "15.0"`（`00-quick-start.md:67`），iOS 17+ 新 API（Privacy Manifest、Observation、#Preview 宏）都跑不了。建议抬到 17.0 ✅ 2026-04-20

### F. 读者粘性

- [x] **第一章缺"哇点" —— 已加 60 秒 demo transcript** ✅ 2026-04-20
  - `00-quick-start.md` 顶部追加"先看 60 秒：AI 帮你写一个 SwiftUI 小页面"章节
  - 真实风格完整会话截录（非演示稿）：3 轮对话 —— 描述需求 → Claude 给出完整 `App.swift` + `ContentView.swift`（@Observable + SwiftUI / iOS 17+ 现代写法）→ 一句话追加 `.transition(.opacity.combined(with:.scale))` 动画 → `git commit`
  - 读者第一屏就能看到"这本书和我有什么关系"，不再被迫先刷 100 行 Homebrew/nvm/Node 铺垫
  - 屏幕录像/GIF 暂不做（纯文本 transcript 即可被 GitBook 渲染 + 搜索引擎索引，GIF 投入产出比差）
- [x] **FAQ 按场景分类** —— 已重写为 7 组场景结构（安装与环境 / 登录与认证 / 账单与额度 / 生成质量 / iOS 特有 / 团队协作 / Git 与网络）+ 顶部"按场景快速定位"表，从 549 行扩到 653 行（既有 Q&A 全部保留 + 补入账单/额度、iOS 特有（签名/模拟器/接手存量项目）、团队协作、幻觉 API、省 token 常识等关键空白条目） ✅ 2026-04-20
- [x] **`best-practices.md` 反面案例对照** —— 已在文末追加"🧨 反面案例对照"大节（473 → 762 行），6 组"❌ 错 → 💥 出了什么 → ✅ 对 → 📊 结果差异"结构的真实踩坑对比：①不给上下文盲改 ②一把梭要求太多功能 ③信"应该能跑"不验证 ④把 AI 输出当权威不核实 API ⑤长 session 混多任务 ⑥约束靠嘴说不写 CLAUDE.md。末尾给出 6 条的优先级与"先做哪两条"建议 ✅ 2026-04-20

### G. 结构性决策补充（对原 TODO 的追加）

- [x] **`learning-path.md` 是否改为"阅读指引"而非"四周课程"**：已重写为"阅读指引" ✅ 2026-04-20
- [x] **`writing-style.md` 只有 24 行**，但 `CLAUDE.md` / `AGENTS.md` 又反复强调它是写作规范入口。已扩写为 100+ 行速查卡（章节骨架 / 术语钦定 / 代码块 / 反模式），并在顶部明确 AGENTS.md 为权威 ✅ 2026-04-20

---

## 🟡 P1 — 占位 / 过薄章节（骨架在，肉没长出来）

目录里有一级章节，但内容停在索引页，读者点进去只能看到一份导航表：

- [ ] **基础篇/04 Agent 与工具** — 目前 README 只有 20 行索引 + 一个孤儿子页 `03-Agents.md`。需要把"Agent / 工具调用 / function calling"的概念拆成独立子章
- [x] **进阶篇/09 Claude Code 写法教程** —— README 已重写（21 → 140 行）：最小模板可抄即用、三层文件分工表、什么时候更新的经验法则、5 条反模式（写成一本小书 / 写成愿景宣言 / 只写禁令 / 不随项目更新 / 复制别人的）。详细教程仍在 claude.md-教程.md（已在 SUMMARY 内）。读者仅看 README 就能上手 ✅ 2026-04-20
- [x] **进阶篇/02 MCP 协议 已拆** —— 457 行单 README（含 iter4 补的 iOS 小节）→ 57 行 README + 4 个子页（共 817 行）✅ 2026-04-20
  - `README.md`（57 行）：一句话讲清 + 子页导航 + 快速速记
  - `01-MCP是什么.md`（167 行）：架构、三种资源类型（Resource / Tool / Prompt）、和函数调用 / 插件的区别
  - `02-常见MCP生态.md`（233 行）：Claude Code / Cursor 配置方式、官方 + 社区 Server 清单、4 个典型场景、安全最佳实践、4 类常见坑
  - `03-自建MCP-Server.md`（204 行）：什么时候值得自建（6 条判据）+ 最简 TypeScript 示例 + 5 步开发流程 + 安全发布检查清单
  - `04-iOS开发者的MCP清单.md`（156 行）：iter4 补入的 iOS 小节独立成页，必装三件套 + 特定场景 + 配置示例 + iOS 专项安全注意 + 实用 prompt
  - SUMMARY 同步拆分（1 条目 → 5 条目）
- [x] **进阶篇/03 Prompt 技巧 已拆** —— 565 行单 README（含 iter3 iOS 小节）→ 63 行 README + 5 个子页（共 1053 行）✅ 2026-04-20
  - `README.md`（63 行）：概览 + 5 子页导航 + 核心原则 + 资源
  - `01-结构化Prompt.md`（185 行）：五要素 + 5 核心技巧 + 8 项自检清单 + 4 级质量分级
  - `02-需求澄清模板.md`（188 行）：新功能模板 + 重构模板 + 3 种场景策略（原型/生产/学习）+ 反向提问 + 角色扮演
  - `03-调试Prompt.md`（220 行）：Bug 模板 + 性能模板 + 链式迭代修复 + 5 常见错误 + 3 反模式，全部指向 best-practices 反面案例
  - `04-Prompt版本管理.md`（240 行）：新写 —— 4 层沉淀（剪贴板 / Slash Command / Skill / CLAUDE.md）+ 怎么选 + 团队共享 + Slash Command 升级示例 + 反模式
  - `05-iOS场景示例.md`（157 行）：iter3 补的 iOS 小节独立成页，8 个 iOS 场景 prompt（SwiftUI 页 / bug / crash log / 测试 / 重构 / 签名 / 接手存量 / 验收）+ iOS 专属三条共通经验
  - SUMMARY 同步拆分（1 条目 → 6 条目）
- [ ] **大师篇/01 多 Agent 协作** — 409 行单页，但大师篇整体应有更多案例而非一篇综述
- [x] **实战篇/02 Cursor 实战 已拆** —— 486 行单 README → 91 行 README + 4 个子页（共 757 行）✅ 2026-04-20
  - `README.md`（91 行）：总览 + 安装 + 4 子页导航表 + 和 Claude Code 的关系
  - `01-核心功能.md`（136 行）：Chat / Inline Edit / Tab / 代码库搜索 + 快捷键总表
  - `02-iOS开发实战.md`（191 行）：4 个 iOS 场景（SwiftUI 创建 / UIKit 重构 / bug 修复 / 单测生成），每场景含"踩坑点"
  - `03-高级技巧.md`（171 行）：`.cursorrules` 写法 + 多文件 Composer + 代码审查（为什么不让 AI 自动修） + 文档生成
  - `04-配置与常见问题.md`（168 行）：settings.json + 推荐扩展（iOS 专项）+ 3 个常见问题 + 和 Claude Code 配合
  - SUMMARY 同步拆分（1 条目 → 5 条目）
- [x] **实战篇/03 Codex 实战 已拆** —— 526 行单 README → 122 行 README + 4 个子页（共 923 行）✅ 2026-04-20
  - `README.md`（122 行）：总览 + 安装 + 4 子页导航 + 与 Claude Code 对比表
  - `01-基本使用.md`（184 行）：`/help` / `/model` / `/reasoning` 三命令详解 + 3 个基础案例（创建文件 / 代码审查 / 重构）+ 交互模式实用技巧
  - `02-高级功能.md`（202 行）：`AGENTS.md` 配置模板 + Subagent 并行（含适用/不适用场景）+ 网络搜索（含"要求溯源"手势）+ CI/CD 集成（含"不应自动挡 merge"的明确边界）
  - `03-iOS开发实战.md`（200 行）：4 个 iOS 场景（原型 / 性能诊断 / Swift Testing 测试 / 文档生成），每个带 prompt 模板 + review 要点
  - `04-安全与配置.md`（215 行）：3 档审批模式选择建议 + iOS 项目推荐黑名单 + 4 常见问题 + 和其他 AI 工具配合工作流
  - SUMMARY 同步拆分（1 条目 → 5 条目）

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
