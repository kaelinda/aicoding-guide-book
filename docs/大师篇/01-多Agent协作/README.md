# 01-多 Agent 协作

> 一个人干不过一个团队，一个 Agent 也不行

## 🤔 为什么需要多 Agent 协作

### 单 Agent 的局限

```
你：开发一个完整的电商 App

单个 Agent：
1. 设计数据库 schema
2. 写后端 API
3. 写前端页面
4. 添加测试
5. 部署上线

问题：
- 任务太复杂，容易出错
- 来回切换上下文，效率低
- 某个环节卡住，整体停滞
```

### 多 Agent 的优势

```
你：开发一个完整的电商 App

Agent 团队：
┌─────────────┐
│ PM Agent    │ → 拆解需求，分配任务
└──────┬──────┘
       │
       ├─→ Backend Agent  → 专注后端开发
       │
       ├─→ Frontend Agent → 专注前端开发
       │
       ├─→ Test Agent     → 专注测试
       │
       └─→ DevOps Agent   → 专注部署

优势：
- 并行执行，速度快
- 各司其职，质量高
- 互不干扰，更稳定
```

## 🏗 多 Agent 协作模式

### 模式 1：流水线模式（Pipeline）

```
需求 → Agent A → Agent B → Agent C → 交付

示例：
需求 → 设计 Agent → 开发 Agent → 测试 Agent → 上线
```

**适用场景：** 有明确先后顺序的任务

**优点：** 简单清晰，易于管理
**缺点：** 不能并行，总时间受限于最长环节

### 模式 2：并行模式（Parallel）

```
         ┌─→ Agent A ─┐
需求 ──→ ├─→ Agent B ─┼──→ 合并 → 交付
         └─→ Agent C ─┘

示例：
         ┌─→ 用户模块 ─┐
电商App → ├─→ 商品模块 ─┼──→ 集成测试 → 上线
         └─→ 订单模块 ─┘
```

**适用场景：** 独立可拆分的任务

**优点：** 速度快，充分利用资源
**缺点：** 需要良好的集成机制

### 模式 3：路由模式（Router）

```
            ┌─→ 开发 Agent
需求 → 路由 ├─→ 测试 Agent
            └─→ 文档 Agent

路由器根据任务类型分配给合适的 Agent
```

**适用场景：** 多种类型任务的混合处理

**优点：** 灵活，自动分派
**缺点：** 路由逻辑需要精心设计

### 模式 4：层级模式（Hierarchical）

```
        CEO Agent（决策层）
            │
    ┌───────┼───────┐
    │       │       │
技术 Agent 产品 Agent 运营 Agent
    │       │       │
  开发     设计    推广
```

**适用场景：** 复杂项目，需要战略决策

**优点：** 层次清晰，权责分明
**缺点：** 通信开销大

## 🛠 实战：使用 OpenClaw 实现多 Agent 协作

### 场景：iOS App 开发

#### 1. 定义 Agent 角色

```markdown
# ~/.openclaw/workspace-ios/AGENTS.md

## Agent 配置

### PM Agent (workspace-pm)
- 职责：需求分析、任务分配、进度追踪
- 触发：收到新需求时自动启动
- 输出：任务列表、优先级、验收标准

### Dev Agent (workspace-dev)
- 职责：编写代码、修复 Bug、性能优化
- 技能：Swift、SwiftUI、iOS 开发
- 输出：可运行的代码

### Test Agent (workspace-test)
- 职责：编写测试、运行测试、回归验证
- 触发：代码提交后自动运行
- 输出：测试报告、Bug 列表
```

#### 2. 工作流配置

```json
// ~/.openclaw/openclaw.json
{
  "workspaces": {
    "ios-project": {
      "agents": ["pm", "dev", "test"],
      "workflow": {
        "new-feature": [
          { "agent": "pm", "action": "analyze" },
          { "agent": "dev", "action": "implement", "parallel": false },
          { "agent": "test", "action": "verify", "parallel": true }
        ]
      }
    }
  }
}
```

#### 3. 实际运行

```
你（飞书）：开发一个用户登录功能

PM Agent：
收到需求，开始分析...

任务拆解：
1. 用户输入验证（邮箱、密码）
2. 登录 API 对接
3. Token 存储管理
4. UI 实现
5. 错误处理

优先级：P0
预计时间：2小时

派发给 Dev Agent...

Dev Agent：
收到任务，开始开发...

[创建文件结构]
[编写验证逻辑]
[实现 API 调用]
[完成 UI]

✅ 开发完成，提交测试

Test Agent：
收到代码，开始测试...

[运行单元测试] → 全部通过
[运行 UI 测试] → 全部通过
[安全检查] → 发现 1 个问题
  ⚠️ 密码未加密存储

反馈给 Dev Agent...

Dev Agent：
修复安全问题...

[添加 Keychain 存储]
[更新测试]

✅ 已修复

Test Agent：
重新测试...全部通过 ✅

PM Agent：
功能开发完成，可以上线。
```

## 📊 协作效果对比

### 单 Agent vs 多 Agent

| 指标 | 单 Agent | 多 Agent |
|------|----------|----------|
| 完成时间 | 4小时 | 2小时 |
| 代码质量 | 良好 | 优秀 |
| Bug 数量 | 5个 | 1个 |
| 并行度 | 低 | 高 |

### 协作收益

```
提升效率：
- 并行开发：速度提升 50%+
- 专业分工：代码质量提升 30%+
- 互相审查：Bug 减少 60%+

降低风险：
- 单点故障：某个 Agent 卡住不影响其他
- 质量保障：多层验证
- 知识共享：Agent 之间互相学习
```

## 🎯 最佳实践

### 1. 清晰的角色定义

```markdown
# ✅ 好的定义
Dev Agent：
- 技术：Swift, SwiftUI
- 职责：实现功能、修复 Bug
- 边界：不负责测试、部署

# ❌ 不好的定义
Dev Agent：写代码的
```

### 2. 标准化的接口

```
PM → Dev 任务格式：
{
  "task": "实现登录功能",
  "priority": "P0",
  "acceptance": [
    "邮箱验证通过",
    "密码强度检查",
    "登录成功跳转"
  ],
  "files": ["LoginView.swift"]
}

Dev → Test 交付格式：
{
  "status": "done",
  "files": ["LoginView.swift", "LoginViewModel.swift"],
  "test_required": true
}
```

### 3. 合理的粒度

```
❌ 太粗：
"开发整个电商 App"

✅ 适中：
"开发用户登录模块"
"开发商品列表模块"
"开发购物车模块"

❌ 太细：
"写一行代码" → 效率低
```

### 4. 监控与协调

```bash
# 查看所有 Agent 状态
openclaw agents list

# 查看某个 Agent 的日志
openclaw agents log dev-agent

# 手动干预
openclaw agents steer dev-agent "暂停，先修复紧急 Bug"
```

## ⚠️ 常见问题

### 问题 1：Agent 之间冲突

```
Dev Agent 修改了文件 A
Test Agent 也在修改文件 A
→ 冲突！

解决：
1. 文件锁机制
2. 分时操作
3. 明确文件归属
```

### 问题 2：上下文丢失

```
Agent A：我需要用户数据
Agent B：什么用户数据？

解决：
1. 共享记忆系统
2. 标准化数据格式
3. 定期同步上下文
```

### 问题 3：任务卡住

```
Dev Agent：等待 API 文档...
[一直等待]

解决：
1. 超时机制
2. 自动升级给 PM Agent
3. 回退方案
```

## 🚀 进阶技巧

### 动态 Agent 调度

```python
# 根据任务复杂度动态调整 Agent 数量
def allocate_agents(task):
    if task.complexity == "high":
        return [dev_agent_1, dev_agent_2, dev_agent_3]
    elif task.complexity == "medium":
        return [dev_agent_1, dev_agent_2]
    else:
        return [dev_agent_1]
```

### Agent 专业化训练

```markdown
# Dev Agent 的 AGENTS.md

## 专精领域
- iOS UI 开发
- 性能优化
- 动画效果

## 不擅长
- 后端开发（交给 Backend Agent）
- 测试（交给 Test Agent）

## 推荐模式
- MVVM 架构
- SwiftUI + Combine
- TDD 开发
```

### 跨项目 Agent 复用

```
项目 A 的 Dev Agent 表现优秀
    ↓
导出配置
    ↓
导入到项目 B
    ↓
项目 B 直接获得高质量 Agent
```

## ✅ 小结

- 多 Agent 协作 = 分工 + 并行 + 协调
- 四种协作模式：流水线、并行、路由、层级
- 关键：清晰的角色、标准的接口、合理的粒度
- OpenClaw 提供完整的多 Agent 支持

## 🔗 相关资源

- [OpenClaw 多 Agent 文档](https://docs.openclaw.ai/concepts/multi-agent)
- [LangGraph 多 Agent 框架](https://langchain-ai.github.io/langgraph/)
- [AutoGen 多 Agent 教程](https://microsoft.github.io/autogen/)

---

**下一步：** [OpenClaw 远程 Coding →](../02-OpenClaw远程Coding/README.md)
