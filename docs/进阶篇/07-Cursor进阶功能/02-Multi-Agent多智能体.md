# 02-Multi-Agent 多智能体

> 最多 8 个 Agent 并行协作，Composer 模型引领首个 Agentic 编程范式。

---

## 目标

- 🤖 掌握 Multi-Agent 并行工作原理
- 🎼 理解 Composer 模型的核心优势
- 👥 学会配置 Team Commands 团队命令
- 📋 了解 Plan Mode 背景规划模式

---

## Multi-Agent 是什么

Multi-Agent 是 Cursor 3.0 引入的革命性功能，允许最多 8 个 AI Agent 同时运行、并行协作。与单一 Agent 顺序执行任务不同，Multi-Agent 模式下多个 Agent 可以各司其职，同时处理不同模块、不同层面的工作——就像组建了一个 AI 开发团队。

**核心架构：**

```
用户指令
    ↓
主 Agent（Coordinator）—— 分解任务、分配任务
    ├── Agent 1：处理 API 层
    ├── Agent 2：处理 UI 层
    ├── Agent 3：处理数据层
    └── Agent 4：编写测试
         ↓
结果汇总 → 用户
```

每个 Agent 拥有独立的上下文和工具集，可以并行读取不同文件、编写不同模块，效率远超单 Agent 逐个执行。

---

## Composer 模型

Composer 是 Cursor 推出的首个 Agentic 编程模型，专为复杂项目设计。与传统单 Agent 不同，Composer 具备以下核心能力：

### 智能任务分解

```bash
# 用户输入
"帮我重构整个登录模块"

# Composer 自动分解
├── 分析现有登录代码结构
├── 设计新的架构方案
├── Agent A：重构 API 层
├── Agent B：重构 UI 层
├── Agent C：编写迁移脚本
└── Agent D：更新测试覆盖
```

### 上下文管理

Composer 模型能自动管理多 Agent 间的上下文冲突：
- **冲突检测**：发现两个 Agent 同时修改同一文件时自动协调
- **上下文隔离**：不同 Agent 的上下文不会相互污染
- **结果合并**：自动解决 merge 冲突，生成最终代码

### 使用方式

```bash
# 启用 Composer 模式
/captain enable

# 指定并行 Agent 数量
/captain agents 4

# 查看当前 Agent 状态
/captain status
```

---

## Team Commands 团队自定义命令

Team Commands 让你定义可复用的复合命令，一键触发多 Agent 协作。

### 定义命令

在 `.cursor/team-commands.json` 中配置：

```json
{
  "commands": [
    {
      "name": "/full-review",
      "description": "完整代码审查流程",
      "agents": ["security", "performance", "style"],
      "prompt": "对当前修改的代码进行三维度审查"
    },
    {
      "name": "/ship-feature",
      "description": "新功能完整交付",
      "agents": ["impl", "test", "docs"],
      "prompt": "实现指定功能并完成测试和文档"
    }
  ]
}
```

### 典型使用场景

| 命令 | 触发 Agent | 用途 |
|------|-----------|------|
| `/full-review` | 安全 + 性能 + 风格 | 全面代码审查 |
| `/ship-feature` | 实现 + 测试 + 文档 | 完整功能交付 |
| `/refactor-module` | 分析 + 重构 + 验证 | 模块重构 |

---

## Plan Mode 背景规划

Plan Mode 是 Cursor 3.0 的另一项核心能力，允许 AI 在后台持续分析项目状态，主动发现问题并提出建议。

### 工作机制

```
正常开发时，Plan Mode 静默运行：
├── 监控代码变化
├── 分析架构趋势
├── 识别潜在风险
└── 生成洞察报告

用户可随时查看：
/plan status    # 查看当前项目状态
/plan risks     # 查看已识别风险
/plan suggest   # 获取优化建议
```

### 适用场景

- **大型项目维护**：持续监控代码健康度
- **技术债务追踪**：自动标记需要重构的区域
- **新人 onboarding**：帮助新成员快速了解项目架构

---

## 使用注意事项

- **资源消耗**：多 Agent 并行消耗更多 Token，建议仅在复杂任务时启用
- **冲突处理**：多个 Agent 同时修改同一文件时，Composer 会自动合并，但结果需人工确认
- **Agent 数量选择**：并非越多越好，4-6 个 Agent 通常是效率和成本的平衡点
- **上下文窗口**：多 Agent 共享上下文窗口上限，需注意项目规模与 Token 消耗

---

## 小结

```
✅ Multi-Agent - 最多 8 个并行 Agent
✅ Composer - 首个 Agentic 编程模型，智能分解 + 冲突管理
✅ Team Commands - 团队自定义复合命令
✅ Plan Mode - 背景持续监控与规划
```

> 下一步：Automations 自动化定时/事件触发 →
