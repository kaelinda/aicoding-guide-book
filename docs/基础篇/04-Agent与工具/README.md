# Agent 与工具

> AI Coding 工具的底层范式：**从"你问一句它答一句"到"你给一个目标，它自己拆分、执行、验证"**。本章是入门导览，深度在进阶篇。

---

## 一句话讲清楚

**Agent ≠ 聊天机器人 +1**。

聊天机器人只会"说"，Agent 会"做"：它能读文件、写文件、跑命令、调接口，并根据结果决定下一步。

```
ChatBot:  你 ←→ AI（只能聊）
Agent:    你 → 目标 → AI（读 / 写 / 跑 / 调 / 再规划 / 再执行 / 直到完成）→ 产出
```

本书里所有的"AI Coding 工具"—— Claude Code / Cursor / Codex —— **都是 Agent**，只是界面形态和默认工具集不同。

---

## 常见误读（先拆掉再学）

| 误读 | 实际 |
|------|------|
| "Agent 是 Codex 的专属概念" | Agent 是跨工具的通用范式。Claude Code 的 Task、Cursor 的 Composer Agent、Codex 的 `--agent` 模式本质一样 |
| "Agent 比聊天模式更高级，所以任何时候都该用" | Agent 的决策自由度高 = 失控风险也高。小改动用对话、复杂任务才上 Agent |
| "Agent 就是多模型串联" | 那是 Multi-Agent。单个 Agent 就能自主执行，多 Agent 是把任务分配给多个 Agent |
| "工具调用 = 插件" | 工具调用是 Agent 能"动手"的能力，插件是具体的工具实现。工具调用是能力，插件是载体 |

---

## Agent 的三个核心能力

### 1. 工具调用（Tool Use）

给 AI 一组"手"：读文件、写文件、跑 shell、查网页、调 API。没有工具调用的 AI 只能输出文字，有工具调用的 AI 可以真动代码库。

- Claude Code：`Read / Edit / Bash / Grep / WebFetch` 等内置工具
- Codex：同上 + MCP 扩展
- Cursor：Composer 模式下的多工具调用

### 2. 自主循环（Agentic Loop）

给一个目标，Agent 会自己进入 **"规划 → 执行 → 观察结果 → 修正 → 再执行"** 的循环，直到目标达成或放弃。

不是"一轮对话"，是"一段时间内的多轮自我驱动"。

### 3. 上下文管理

长任务需要记住"之前干了什么""读过哪些文件""有哪些约束"。Agent 需要主动维护这份记忆，避免前后矛盾。

详见后续章节：[进阶篇/01-Agent 概念](../../进阶篇/01-Agent概念/README.md) 的深度展开。

---

## 本章子页

| 文档 | 讲什么 | 适合谁看 |
|------|------|------|
| [03-Agents.md](./03-Agents.md) | **Codex Agents** 实战参考：`--agent` 模式、角色类型、Tool 清单、多 Agent 串联、成本与安全 | 用 Codex 的读者 |

> 📌 为什么 03-Agents.md 是 Codex 专题？因为 Codex 的 Agent 模式最"显式"—— 通过 `--agent` 参数切换，角色之间边界清晰，适合拿来讲 Agent 范式。**但讲的原理是通用的，Claude Code 和 Cursor 的 Agent 模式本质相同。**

---

## 全书 Agent 相关章节导览

按由浅入深顺序：

1. **本章**（基础篇/04）—— Agent 是什么、打破误读、三个核心能力
2. [**进阶篇/01-Agent 概念**](../../进阶篇/01-Agent概念/README.md) —— 概念深度展开：自主性 / 工具使用 / 迭代改进 / 环境感知
3. [**进阶篇/07-02-Cursor Multi-Agent**](../../进阶篇/07-Cursor进阶功能/02-Multi-Agent多智能体.md) —— Cursor 的多 Agent 协作
4. [**进阶篇/08-01-Task 工具与 Subagent**](../../进阶篇/08-ClaudeCode新功能/01-Task工具与Subagent.md) —— Claude Code 的 Task / Subagent 机制
5. [**实战篇/01-10-Claude Code 多 Agent**](../../实战篇/01-ClaudeCode实战/10-ClaudeCode多Agent协作.md) —— 手工三角色协作流程
6. [**大师篇/01-多 Agent 协作**](../../大师篇/01-多Agent协作/README.md) —— 综合案例与反思
7. [**大师篇/04-驾驭工程**](../../大师篇/04-驾驭工程/README.md) —— 与 AI 智能体协作的工程哲学

---

## 学完本章你应该能回答

- ✅ 为什么同样的 Prompt，聊天模式和 Agent 模式给出的结果会差很多？
- ✅ 什么样的任务适合用 Agent，什么样的任务反而用聊天更快？
- ✅ 为什么 Agent 会"失控"？有哪些防护措施？
- ✅ Codex Agents、Claude Code Task、Cursor Composer Agent 之间是什么关系？

如果这 4 个问题还有任何一个模糊，先把 `03-Agents.md` 读完，然后跳到 [进阶篇/01-Agent 概念](../../进阶篇/01-Agent概念/README.md) 继续。

---

## 相关资源

- 上一章：[03-第一个项目](../03-第一个项目/README.md)
- 下一章：[05-练习项目](../05-练习项目/README.md)
- 延伸：[进阶篇/01-Agent 概念](../../进阶篇/01-Agent概念/README.md)、[术语表 Agent 条](../../glossary.md)
- 本章补充：[02-工具安装/05-Codex 新功能补充](../02-工具安装/05-Codex新功能补充.md)
