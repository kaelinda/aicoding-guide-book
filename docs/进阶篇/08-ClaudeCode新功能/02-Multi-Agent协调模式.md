# 02-Multi-Agent 协调模式

> Coordinator Mode 多 Agent 协作架构，让 Claude Code 像一个微型开发团队一样高效运转。

---

## 目标

- 🏗️ 理解 Coordinator Mode 的架构设计
- 🤖 掌握多 Agent 角色分工
- 🚀 学会启动协调模式
- ⚙️ 了解任务分配与结果汇总机制

---

## Coordinator Mode 是什么

Coordinator Mode（协调模式）是 Claude Code 的多 Agent 协作架构，由一个主协调者（Coordinator）和多个专业执行者（Specialists）组成。与单 Agent 顺序执行不同，Coordinator Mode 能够：

- **智能分解**：将复杂任务分解为并行可执行的子任务
- **角色专精**：每个 Specialist 擅长特定领域
- **结果汇总**：自动合并多 Agent 输出，生成统一报告
- **冲突协调**：处理多 Agent 间的上下文冲突

你可以把它理解为：**Claude Code 内置了一个微型 AI 开发团队，你是这个团队的 PM，负责下达指令并验收成果。**

---

## 架构设计

```
用户（PM）
    │
    │ "帮我重构整个登录模块"
    ↓
Coordinator（协调者）
    │
    ├──→ Specialist: 架构师 ──→ 设计新架构
    ├──→ Specialist: 开发者 ──→ 编写代码
    ├──→ Specialist: 测试工程师 ──→ 编写测试
    └──→ Specialist: 文档工程师 ──→ 更新文档
              ↓
         结果汇总
              ↓
         用户验收
```

### Specialist 角色

| 角色 | 职责 | 擅长领域 |
|------|------|----------|
| **Architect** | 架构设计与技术决策 | 系统设计、模块划分 |
| **Developer** | 代码编写与实现 | 功能开发、API 实现 |
| **Tester** | 测试用例编写与验证 | 单元测试、集成测试 |
| **Reviewer** | 代码审查与质量把控 | 代码规范、安全审计 |
| **Docs** | 文档编写与维护 | API 文档、README |

---

## 如何启动协调模式

### 基础启动

```bash
# 启动协调模式（默认配置）
/coordinator on

# 启动并指定角色组合
/coordinator on --specialists architect,developer,tester

# 查看当前状态
/coordinator status
```

### 高级配置

```bash
# 指定 Agent 数量
/coordinator agents 4

# 设置并行度（最多 8 个 Agent）
/coordinator parallel 4

# 指定任务超时时间
/coordinator timeout 30m
```

### 配置文件

```json
// .claude/coordinator.json
{
  "mode": "coordinator",
  "specialists": [
    {
      "name": "ios-developer",
      "role": "developer",
      "focus": ["swift", "swiftui", "xcode"]
    },
    {
      "name": "security-reviewer",
      "role": "reviewer",
      "focus": ["security", "privacy"]
    }
  ],
  "parallel": 4,
  "timeout": "30m",
  "mergeStrategy": "sequential"  // sequential | consensus
}
```

---

## 工作流程

### 任务分解

```
用户输入：帮我实现一个用户反馈系统

Coordinator 分析后分解：
├── 子任务 1：设计数据模型（Architect）
├── 子任务 2：实现后端 API（Developer - Backend）
├── 子任务 3：实现 iOS 客户端（Developer - iOS）
├── 子任务 4：编写单元测试（Tester）
└── 子任务 5：编写 API 文档（Docs）
```

### 并行执行

```bash
# Coordinator 分配任务
[Coordinator] 正在分解任务...
[Coordinator] 已创建 5 个子任务
[Coordinator] 启动并行执行（4 个 Agent）

[Architect] 设计数据模型中...
[Developer-iOS] 编写 iOS 客户端...
[Developer-Backend] 编写后端 API...
[Tester] 准备测试用例...

[Developer-iOS] 完成，通知 Coordinator
[Architect] 完成，通知 Coordinator
[Developer-Backend] 完成，通知 Coordinator
[Tester] 完成，通知 Coordinator
```

### 结果汇总

```bash
[Coordinator] 所有 Specialist 已完成
[Coordinator] 正在汇总结果...

📋 任务完成报告
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ 数据模型设计：完成
   └── FeedbackModel、FeedbackItem、UserFeedback
✅ 后端 API：完成
   └── POST /feedback、GET /feedback/:id
✅ iOS 客户端：完成
   └── FeedbackViewController、FeedbackService
✅ 单元测试：完成
   └── 覆盖率 87%
✅ API 文档：完成
   └── 已更新 docs/api.md
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 使用场景

### 场景一：大型功能开发

当面对需要多层次实现的复杂功能时：
- Architect 负责整体设计
- Developer 负责各层实现
- Tester 负责测试覆盖
- 多者并行，效率翻倍

### 场景二：系统重构

```
重构任务分解：
├── 架构师：分析现有架构，识别依赖关系
├── 开发者：按模块逐一重构
├── 审查员：确保重构后代码质量
└── 测试员：回归测试验证功能
```

### 场景三：快速 MVP

```
MVP 快速交付：
├── 架构师：最小化可行架构
├── 开发者：核心功能实现
├── 测试员：关键路径测试
└── 文档员：快速上手指南
```

---

## 注意事项

- **Agent 数量**：并非越多越好，4-6 个通常是效率与成本的平衡点
- **上下文窗口**：多 Agent 共享上下文限制，大型项目需注意分段处理
- **冲突处理**：多 Agent 同时修改同一文件时，Coordinator 会尝试自动合并
- **成本控制**：多 Agent 并行消耗更多 Token，建议设置每日使用上限

---

## 小结

```
✅ Coordinator Mode - 多 Agent 协作架构
✅ 角色分工：Architect / Developer / Tester / Reviewer / Docs
✅ 智能任务分解 + 并行执行 + 结果汇总
✅ 最大 8 个 Agent 并行
✅ 适用场景：大型功能、系统重构、快速 MVP
```

> 下一步：ULTRAPLAN 长期规划 →
