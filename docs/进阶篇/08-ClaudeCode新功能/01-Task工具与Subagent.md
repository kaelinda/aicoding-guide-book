# 01-Task 工具与 Subagent

> Claude Code 官方的多 Agent 机制：用 `Task` 工具派发子 Agent，主会话负责编排，子会话负责执行。

---

## 这是真实功能

前言：本章之前写过一份"Coordinator Mode 协调模式"（已下线），那个术语不是官方的。**本页讲的是官方真实机制 —— Task 工具 + Subagent**。

核心入口：

- [Claude Code 官方文档 — Agents / Subagents](https://docs.claude.com/claude-code)
- 相关配置：`.claude/agents/*.md`

以下所有内容均以官方文档为准，本书写作时请对照最新版本。

---

## 一句话讲清楚

**主 Claude 不直接做所有事，它可以调用 `Task` 工具、把一个带独立上下文的 Claude 子进程派出去干一件事，完成后只拿回结果摘要。**

```
主会话（orchestrator）
   │
   │ Task(description, prompt, subagent_type)
   ↓
子会话（subagent，独立上下文）
   │  读文件 / 跑命令 / 生成 diff
   ↓
   返回结果摘要给主会话
```

---

## 为什么要用 Subagent

不是"Agent 比直接跑更厉害"，而是它解决两个具体问题：

### 1. 上下文隔离，避免污染

主会话在讨论架构决策时，不想被"读 50 个源码文件"这种体力活填满上下文窗口。
派个 subagent 读完、返回一段摘要，主会话上下文保持干净。

### 2. 并行化

多个互不依赖的子任务可以并行派发（在同一条消息里发多个 `Task` 调用），总时间 = max(子任务)，而不是 sum。

典型场景：

- "并行审这 5 个 PR"
- "同时搜 3 个关键词"
- "分别在 3 个目录下跑 lint 并汇总"

### 不适合的场景

- 一次性简单改动（派 subagent 的开销大于直接做）
- 子任务之间强依赖（顺序执行即可，不需要并行）
- 需要主会话全程决策的创意/设计工作

---

## 两种用法

### 用法 A：内置通用 Agent（一次性派发）

直接在对话里让 Claude 调用 `Task`：

```text
把整个 docs/ 目录扫一遍，列出所有死链的清单。
你可以用 Task 工具派个 general-purpose subagent 去跑这件事，
我不需要中间过程，只要最终清单。
```

Claude 会派出一个子 Agent，等它跑完，主会话只吃结果。

### 用法 B：自定义 Agent 定义（`.claude/agents/`）

把**反复使用**的子 Agent 定义成专用类型：

```
项目/.claude/agents/ios-reviewer.md
```

文件大致长这样：

```markdown
---
name: ios-reviewer
description: 专门 review SwiftUI / UIKit 代码的 Agent，重点看状态管理和生命周期
tools: [Read, Grep, Glob]
---

你是一个资深 iOS 代码审查员。
规则：
- 只读不写
- 按 🔴 必改 / 🟡 建议 / 🟢 可忽略 三档输出
- 重点检查：@State/@StateObject 用错、主线程阻塞、循环引用
```

后续在主会话里：

```text
用 ios-reviewer subagent review 一下 LoginView.swift
```

> 📌 具体 frontmatter 字段、工具白名单写法以**官方文档为准**，本书示例是演示约定，不保证字段兼容最新版。

---

## 并行派发的示例

在一个回合内派多个 subagent：

```text
并行做三件事：
1. subagent A：搜索项目里所有 TODO / FIXME
2. subagent B：统计每个模块的测试覆盖率
3. subagent C：扫一遍所有 ViewModel，列出超过 200 行的

三份结果汇总成一张表给我。
```

Claude 会在同一条助手消息里发出 3 个 `Task` 调用，subagent 并行跑，主会话等三个结果都回来再整合。

---

## 和本书其他章节的关系

| 章节 | 角度 |
|------|------|
| [本章](README.md) | Claude Code 官方机制 |
| [实战篇/01-10 多 Agent 协作](../../实战篇/01-ClaudeCode实战/10-ClaudeCode多Agent协作.md) | 不用 Task 工具，手工开 3 个 session 演三角色 |
| [基础篇/04 Agent 与工具](../../基础篇/04-Agent与工具/README.md) | Agent 的通用概念（跨工具） |
| [进阶篇/01 Agent 概念](../01-Agent概念/README.md) | Agent 的理论层 |
| [进阶篇/07-02 Cursor Multi-Agent](../07-Cursor进阶功能/02-Multi-Agent多智能体.md) | Cursor 怎么做多 Agent |
| [大师篇/01 多 Agent 协作](../../大师篇/01-多Agent协作/README.md) | 综合案例 |

---

## 常见坑

### 坑 1：滥用 subagent

把每件小事都派出去，结果：

- 每次派发都有启动成本（模型重新读系统提示、项目上下文）
- 主会话反而要花更多轮来接收各个摘要
- 整体更慢

经验法则：**子任务估计要占用 > 2000 tokens 上下文，才值得派 subagent**。

### 坑 2：subagent 看不到主会话的对话

每个 subagent 是**独立上下文**。你在主会话里讨论的约束、之前 Claude 的推理，subagent 都不知道。

派发时要把**所有需要的约束写在 prompt 参数里**，不能依赖"它应该记得"。

### 坑 3：subagent 返回后修改的文件和主会话视图不同步

subagent 可能改了文件。主会话如果之前读过旧版本，内存里是旧的。
**需要重新 Read 一次**，或信任 subagent 的摘要。

---

## 一句话总结

**Task + subagent 不是"让 AI 更聪明"，是"给 AI 加上下文墙和并发能力"。**
用对了省时间，用错了只是多烧 token。

---

## 相关资源

- 章节首页：[08-Claude Code 新功能](README.md)
- 下一篇：[02-浏览器工具与 MCP 生态](02-浏览器工具与MCP生态.md)
- 深度阅读：[大师篇/01-多 Agent 协作](../../大师篇/01-多Agent协作/README.md)
- 官方文档：[Claude Code - Subagents](https://docs.claude.com/claude-code)（以官方为准）
