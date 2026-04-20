# 驾驭工程：与 AI Agent 协作的艺术

> 本章内容整理自 [walkinglabs/learn-harness-engineering](https://github.com/walkinglabs/learn-harness-engineering)，MIT 许可项目。

## 什么是 Harness Engineering？

Harness Engineering（驾驭工程）是一门正在兴起的新学科——如何通过**结构化的工作流**和**精心设计的提示词**，最大限度地发挥 AI 编程智能体的能力。

这不是在讨论"AI 会不会取代程序员"，而是在问：

> **如何让 AI 成为真正的编程搭档，而不是一个有时靠谱有时离谱的 autocomplete？**

## 核心观点：AI 参与度光谱

walkinglabs 提出了一个重要框架——AI 参与度从低到高有 5 个层次：

```
层级 1｜AI 即顾问（AI as Consultant）
       你写代码，AI 点评。像 code review 但更即时。
       
层级 2｜AI 即评审（AI as Reviewer）  
       AI 写代码，你来评审。你是守门员。
       
层级 3｜AI 即副驾驶（AI as Copilot）
       你主导，AI 辅助。共同完成编程任务。
       
层级 4｜AI 即执行者（AI as Executor）
       你设计架构，AI 实现细节。像交给一个高级工程师。
       
层级 5｜AI 即主导者（AI as Lead）
       AI 主导编程，你来核查和纠正。适合简单重复任务。
```

**最有效的往往不是最高层级**，而是根据任务选择合适的层级。

## 五步结构化工作流

walkinglabs 推荐一种"Think-Sketch-Spec-Build-Integrate"工作流：

### Step 1: Think（思考）

在写任何代码之前，先用自然语言把问题想清楚：

- 我要解决什么问题？
- 这个问题为什么重要？
- 成功的标准是什么？
- 可能的方案有哪些？各有什么trade-offs？

**技巧**：不要在这里写得太详细。AI 时代，过于具体的 spec 会限制 AI 的发挥空间。

### Step 2: Sketch（画草图）

用 Markdown 画一个**粗略的架构图或流程图**：

```markdown
## 组件Sketch

[用户] → [ViewController] → [ViewModel] → [Service]
                                    ↓
                              [Model层]
```

这一步的目的是让自己和 AI 对"全局"有一致认知。

### Step 3: Spec（写规格）

用 AI 友好的格式写规格说明：

```markdown
## 功能Spec：搜索功能

### 目标
- 用户输入关键词，从本地数据库快速检索匹配项

### 输入
- 搜索框文本（String，≥ 1字符）

### 输出  
- 最多返回 20 条结果，显示标题和摘要

### 关键约束
- 响应时间 < 100ms（本地 SQLite FTS5）
- 区分大小写
- 支持中文分词

### 边界情况
- 空输入 → 返回空，不报错
- 无匹配 → 显示"未找到"
```

### Step 4: Build（构建）

让 AI 按 spec 执行。关键是：

- **一次一个任务**：不要一次丢 1000 行代码给 AI
- **小步快走**：每次生成后立即 review，发现问题立即纠正
- **AI 说的每句话都值得怀疑**：让 AI 解释它的决策

### Step 5: Integrate（集成）

把各个 AI 生成的模块串联起来，做端到端测试。

这一步往往是 AI 最容易出错的地方——因为它只看局部，不看全局。

---

## 多 Agent 协作模式

walkinglabs 总结了 3 种进阶模式：

### 模式 1：人类居中协调（Human-in-the-loop）

```
[AI 1: 需求分析] → [人类: 决策] → [AI 2: 实现]
       ↑                              ↓
       ←─────── [人类: 验收] ←────────┘
```

适合：复杂需求、不确定的技术方向

### 模式 2：AI 流水线（AI Pipeline）

```
[AI Architect] → [AI Coder] → [AI Reviewer] → [Human QA]
```

三个 AI 串联：架构师定方案，Coder 实现，Reviewer 审查，最后人工验收。

适合：中等复杂度、有明确质量标准的功能

### 模式 3：并行探索（Parallel Exploration）

```
[AI A: 方案A]    [AI B: 方案B]    [AI C: 方案C]
    ↓                ↓                ↓
[评审A]           [评审B]           [评审C]
    ↓                ↓                ↓
              [人类: 选择最优方案]
```

三个 AI 并行工作，各自提出方案和评审，最后由人类拍板。

适合：技术选型、创新性问题的早期探索

---

## OpenClaw 在 Harness Engineering 中的角色

walkinglabs 的教程主要用 Claude Code 和 Cursor 演示，但 **OpenClaw** 有独特优势：

| 维度 | Claude Code / Cursor | OpenClaw |
|------|---------------------|----------|
| 多 Agent 编排 | ❌ 需要手动 | ✅ 内置 subagent 机制 |
| 外部工具集成 | 一般 | ✅ 70+ opencli 适配器 |
| 飞书/微信集成 | ❌ | ✅ 开箱即用 |
| 自定义工作流 | 需要脚手架 | ✅ ClawFlow 原生支持 |
| 定时任务 | ❌ | ✅ cron 内置 |
| 记忆管理 | 有限 | ✅ 长期记忆 + 语义搜索 |

OpenClaw 的 subagent 机制天然支持**多 Agent 协作模式**，可以让多个 AI 同时工作、互相交接。

---

## 资源链接

- 🌐 项目主页：https://github.com/walkinglabs/learn-harness-engineering
- 📖 中文文档：https://github.com/walkinglabs/learn-harness-engineering/blob/main/README-CN.md
- 🔧 提示词库：https://github.com/walkinglabs/learn-harness-engineering/tree/main/examples
- 🛠️ 工具列表：https://github.com/walkinglabs/learn-harness-engineering/blob/main/docs/tools.md
- 📝 CLAUDE.md 指南：https://github.com/walkinglabs/learn-harness-engineering/blob/main/CLAUDE.md

---

## 下一步

- 把 walkinglabs 的 [CLAUDE.md](https://github.com/walkinglabs/learn-harness-engineering/blob/main/CLAUDE.md) 添加到你的项目中，让任何 AI 编程工具都能理解你的代码库规范
- 参考 [examples/](https://github.com/walkinglabs/learn-harness-engineering/tree/main/examples) 中的提示词模板，优化你的日常工作流
- 尝试用 OpenClaw 的 subagent 机制实现"AI 流水线"模式

---

_MIT License - 欢迎引用、改编、商业使用_
