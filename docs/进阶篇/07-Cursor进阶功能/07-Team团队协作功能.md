# 07-Team 团队协作功能

> Team Marketplaces 企业私有插件市场 + ACP 跨 IDE Agent 集成，打造企业级 AI 开发协作生态。

---

## 目标

- 🏢 理解 Team Marketplaces 的价值
- 🔌 掌握企业插件市场配置方法
- 🛠️ 了解 ACP JetBrains 集成方案
- 👥 学会在团队中推广 AI 协作规范

---

## Team Marketplaces 企业私有插件市场

### 什么是 Team Marketplaces

Team Marketplaces 是 Cursor 为企业团队提供的私有插件分发平台，允许团队管理员将经过验证的 Custom Roles、Automations、MCP Apps 等资源集中管理，成员可直接从私有市场一键安装使用。

核心价值：
- **统一规范**：团队共享标准化的 AI 工作流
- **质量把控**：管理员审核后再分发，避免劣质插件
- **版本管理**：插件更新自动同步，版本一致性有保障
- **权限控制**：按角色分配插件可见性

### 搭建私有市场

```bash
# 初始化团队市场
/captain team init

# 初始化后生成配置文件
# .cursor/team-marketplace.json
{
  "name": "acme-ios-team",
  "plugins": "./plugins",
  "members": [
    { "id": "user1", "role": "admin" },
    { "id": "user2", "role": "member" }
  ],
  "visibility": {
    "admin": ["all"],
    "member": ["approved"]
  }
}
```

### 插件打包与发布

```bash
# 打包插件
/captain package \
  --name ios-architect-role \
  --version 1.2.0 \
  --files ./roles/architect.json

# 发布到团队市场
/captain publish ios-architect-role

# 查看市场列表
/captain team list
```

### 成员使用

```bash
# 成员安装团队插件
/captain install ios-architect-role

# 查看可用更新
/captain team updates

# 自动更新
/captain team sync
```

---

## ACP JetBrains 集成

### 什么是 ACP

ACP（Agent Communication Protocol）是 Cursor 推出的跨 IDE Agent 通信协议，允许在 JetBrains IDE（IntelliJ IDEA、WebStorm、PyCharm 等）中直接使用 Cursor Agent 的能力。

这意味着：
- **不换工具**：已在使用 JetBrains 的团队无需迁移
- **统一体验**：Cursor Agent 能力覆盖 JetBrains
- **数据互通**：与 Cursor 编辑的项目无缝协作

### 安装 ACP 插件

1. 打开 JetBrains IDE → Settings → Plugins
2. 搜索 "Cursor Agent Connector"
3. 安装并重启 IDE
4. 登录 Cursor 账号完成绑定

### 基础使用

```bash
# 在 JetBrains 中调用 Cursor Agent
# Cmd/Ctrl + Shift + A → "Cursor Agent"

// 或使用工具窗口
// View → Tool Windows → Cursor Agent
```

### 协作场景

```
JetBrains IDE                    Cursor Editor
     │                                │
     ├── 开发者 A 编写核心逻辑 ──────→│
     │                                ├── 开发者 B 使用 Cursor 审查
     │                                │
←── Agent 共享上下文 ←────────────────┘
```

ACP 支持：
- **上下文共享**：Agent 知道两个 IDE 中正在做什么
- **无缝交接**：一个 IDE 启动的任务可在另一个 IDE 继续
- **协作调试**：多个 Agent 共同分析同一个 Bug

---

## 团队 AI 协作规范

### 制定团队 AI 使用规范

建议团队建立以下规范：

| 规范项 | 建议 |
|--------|------|
| 插件来源 | 仅使用私有市场和官方市场，禁止未知来源 |
| Custom Roles | 统一使用团队审核通过的角色 |
| 敏感操作 | 删除文件、重构核心模块需人工确认 |
| Code Review | AI 审查 + 人工复审双重保障 |
| 知识沉淀 | 优秀 Prompt 和角色配置归档到团队知识库 |

### 推广计划

1. **试点阶段**：先在核心开发组试点，收集反馈
2. **培训阶段**：组织分享会，展示 AI 提效案例
3. **推广阶段**：逐步覆盖全团队，建立激励机制
4. **迭代阶段**：定期收集最佳实践，更新团队规范

---

## 常见问题

### Q: Team Marketplaces 需要付费吗？

A: Team Marketplaces 是 Cursor Enterprise 功能，需要 Business 或 Enterprise 订阅。

### Q: ACP 和直接在 Cursor 中使用有区别吗？

A: ACP 主要提供 JetBrains 环境下的 Agent 访问，完整功能体验建议使用 Cursor Editor。

### Q: 如何管理团队成员的 AI 使用权限？

A: 可在团队管理后台配置角色权限，限制敏感操作（如删除文件、自动合并 PR）。

---

## 小结

```
✅ Team Marketplaces - 企业私有插件市场
✅ 统一管理 Custom Roles、Automations、MCP Apps
✅ ACP - JetBrains IDE 集成 Cursor Agent
✅ 跨 IDE 协作 - JetBrains + Cursor 无缝衔接
✅ 团队 AI 规范 - 质量把控与最佳实践
```

> 本章完结，Cursor 进阶功能全部掌握！
