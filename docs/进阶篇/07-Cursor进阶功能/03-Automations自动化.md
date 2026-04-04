# 03-Automations 自动化

> 定时或事件触发的自动化 Agent，让 Cursor 成为 24 小时不间断的 AI 开发助手。

---

## 目标

- ⏰ 理解 Automations 的触发机制
- 🔧 掌握 Automations 配置方法
- 🚀 了解典型使用场景

---

## 什么是 Automations

Automations 是 Cursor 3.0 引入的自动化执行能力，允许你配置"当 X 发生时，执行 Y 操作"的规则。与手动触发不同，Automations 在后台静默运行，可以在指定时间或特定事件触发时自动启动 Agent 执行任务。

这意味着你可以：
- 设置定时任务，让 AI 在深夜完成代码审查
- 配置事件触发，让 AI 在 PR 打开时自动审查
- 建立监控规则，让 AI 持续跟踪项目健康度

---

## 触发类型

### 定时触发

```json
{
  "trigger": {
    "type": "schedule",
    "cron": "0 2 * * *",     // 每天凌晨 2 点
    "timezone": "Asia/Shanghai"
  },
  "action": {
    "agent": "code-review",
    "target": "main"
  }
}
```

常用 cron 表达式示例：

| 表达式 | 含义 |
|--------|------|
| `0 9 * * 1-5` | 工作日早上 9 点 |
| `0 2 * * *` | 每天凌晨 2 点 |
| `0 */4 * * *` | 每 4 小时 |
| `0 0 * * 0` | 每周日午夜 |

### 事件触发

```json
{
  "trigger": {
    "type": "event",
    "source": "github",
    "event": "pull_request.opened",
    "filters": {
      "repository": "my-org/my-repo"
    }
  },
  "action": {
    "agent": "pr-review",
    "notify": "slack:#dev-alerts"
  }
}
```

支持的事件源：

| 事件源 | 支持事件 |
|--------|----------|
| GitHub | PR 打开/合并、Issue 创建、Push |
| GitLab | MR 打开/合并、Push |
| 文件系统 | 文件变化、目录变更 |
| 自定义 Webhook | 任意 HTTP 事件 |

---

## 如何配置 Automations

### 基础配置

1. 打开 Cursor Settings → Automations
2. 点击 **+ New Automation**
3. 选择触发类型（Schedule / Event / Webhook）
4. 绑定 Agent 和操作
5. 设置通知方式

### Agent 配置

```json
{
  "name": "nightly-review",
  "agent": "code-review",
  "config": {
    "model": "claude-sonnet-4",
    "scope": "main",
    "focus": ["security", "performance"],
    "maxDuration": "30m"
  },
  "onComplete": {
    "action": "notify",
    "target": "slack:#dev-alerts",
    "summary": true
  }
}
```

### 完整示例

```json
{
  "name": "pr-auto-review",
  "enabled": true,
  "trigger": {
    "type": "event",
    "source": "github",
    "event": "pull_request.opened",
    "filters": {
      "labels": ["needs-review"]
    }
  },
  "action": {
    "type": "agent",
    "agent": "pr-reviewer",
    "timeout": "10m"
  },
  "onComplete": {
    "postComment": true,
    "setLabels": ["ai-reviewed"]
  }
}
```

---

## 使用场景

### 场景一：每日代码健康检查

```
触发：每天早上 9:00
Agent：健康检查 Agent
操作：
├── 检查测试通过率
├── 分析新增代码质量
├── 识别技术债务
└── 发送报告到 Slack
```

### 场景二：PR 自动审查

```
触发：GitHub PR 打开
Agent：PR 审查 Agent
操作：
├── 分析代码变更
├── 检查安全漏洞
├── 性能影响评估
└── 自动评论审查意见
```

### 场景三：监控构建失败

```
触发：CI 构建失败
Agent：故障诊断 Agent
操作：
├── 分析错误日志
├── 定位问题原因
├── 尝试自动修复
└── 汇报结果并创建 Issue
```

---

## 注意事项

- **权限配置**：Automations 需要访问对应平台（GitHub/GitLab）的 Webhook 权限，确保已完成 OAuth 授权
- **超时设置**：建议为每个 Automation 设置 `maxDuration`，防止 Agent 长时间占用资源
- **成本控制**：定时任务会持续消耗 Token，建议设置 `dry-run` 模式测试后再开启
- **通知过载**：避免配置过于频繁的触发（如每次 Push），防止通知轰炸

---

## 小结

```
✅ Automations - 自动化 Agent 执行
✅ 触发类型：定时（cron）/ 事件（GitHub 等）/ Webhook
✅ Agent 配置：模型选择、范围限定、超时控制
✅ 典型场景：每日健康检查、PR 审查、构建失败诊断
```

> 下一步：Cloud Agents 云端代理 →
