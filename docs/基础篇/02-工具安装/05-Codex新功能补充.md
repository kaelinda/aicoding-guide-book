# Codex 新功能补充（2026年）

> 根据 OpenAI 官网最近三个月（2026年1月-4月）的更新，整理以下新功能。

---

## 目标

- 🔌 掌握 Plugins 扩展机制
- ⚡ 学会使用 Triggers 触发器
- 🤖 了解 Codex 与 GitHub 的深度集成
- 📊 掌握企业级管理功能

---

## 1. Codex Apps

> 2026年3月最新发布的产品，连接 GitHub 仓库进行智能编程。

### 与 Claude Code 的区别

| 特性 | Claude Code | Codex Apps |
|------|-------------|------------|
| 运行环境 | 本地/远程服务器 | 云端 + GitHub |
| 会话管理 | 本地 | 云端同步 |
| 权限控制 | 系统级 | GitHub 仓库级 |
| 适用场景 | 本地开发 | 团队协作 |

### 工作原理

```
GitHub Repository
       ↓
Codex Apps 自动扫描代码
       ↓
用户自然语言指令
       ↓
AI 理解代码 + 执行任务
       ↓
创建 Commit / Pull Request
```

### 使用

```bash
# 安装
pip install openai-codex

# 登录
codex auth

# 连接到仓库
codex connect owner/repo

# 开始对话
codex ask "解释这个模块的作用"
```

---

## 2. Plugins 系统

> 2026年3月新增的扩展机制，连接第三方服务。

### 官方插件

| 插件 | 功能 | 地址 |
|------|------|------|
| Sentry | 错误追踪 | sentry.io |
| Datadog | 监控告警 | datadoghq.com |

### 安装

```bash
# 安装插件
codex plugin install sentry

# 查看插件列表
codex plugin list

# 配置插件
codex plugin configure sentry --dsn https://xxx@sentry.io/xxx
```

### 配置

```json
// codex.config.json
{
  "plugins": {
    "sentry": {
      "enabled": true,
      "dsn": "https://xxx@sentry.io/xxx",
      "projects": ["ios-app", "backend"]
    },
    "datadog": {
      "enabled": true,
      "apiKey": "xxx",
      "site": "datadoghq.com"
    }
  }
}
```

### 使用

```bash
# 查看 Sentry 错误
codex sentry issues

# 查看 Datadog 指标
codex datadog metrics

# 自动修复错误
codex sentry fix --issue 123
```

---

## 3. Triggers 触发器

> 自动响应 GitHub 事件的自动化规则。

### 工作原理

```
GitHub Event (PR/Issue/Push)
       ↓
Trigger 规则匹配
       ↓
自动执行 Action
       ↓
返回结果 / 创建 Comment
```

### 配置

```json
// triggers.json
{
  "triggers": [
    {
      "name": "auto-review",
      "on": "pull_request",
      "action": "codex review --pr $PR_NUMBER"
    },
    {
      "name": "bug-triage",
      "on": "issues",
      "conditions": {
        "label": "bug"
      },
      "action": "codex triage --issue $ISSUE_NUMBER"
    },
    {
      "name": "doc-check",
      "on": "push",
      "conditions": {
        "files": ["**.md", "docs/**"]
      },
      "action": "codex check-docs"
    }
  ]
}
```

### 触发事件

| 事件 | 说明 |
|------|------|
| `pull_request` | PR 创建/更新 |
| `issues` | Issue 创建/更新 |
| `push` | 代码推送 |
| `release` | 发布版本 |
| `workflow_run` | CI/CD 运行 |

### 部署

```bash
# 激活触发器
codex trigger enable auto-review

# 查看触发记录
codex trigger logs

# 测试触发器
codex trigger test auto-review --event pull_request
```

---

## 4. GitHub 深度集成

> 2026年1月发布的 GitHub 应用增强。

### 功能

- 🔄 自动扫描仓库代码
- 📝 智能创建 Commit Message
- 🔀 自动创建 Pull Request
- 💬 PR/Issue 内联评论
- ✅ 代码审查与建议

### 安装 GitHub App

1. 访问 [github.com/apps/codex](https://github.com/apps/codex)
2. 选择要授权的仓库
3. 配置权限

### 权限说明

| 权限 | 用途 |
|------|------|
| Contents | 读取/写入代码 |
| Pull requests | 创建 PR |
| Issues | 评论 Issue |
| Actions | 查看 CI/CD |

---

## 5. Slack 集成（正式版）

> 2026年2月 Slack 集成正式发布。

### 安装

```bash
codex slack install
```

### 功能

- 💬 在 Slack 中直接提问
- 📊 部署状态通知
- 🔔 构建失败告警
- 📈 使用统计报告

### 配置

```bash
# 连接 Slack 工作区
codex slack auth

# 设置通知频道
codex slack set-channel #engineering

# 配置通知类型
codex slack notify --events deploy,build_fail
```

---

## 6. 企业管理功能

> 2026年2月发布的团队管理工具。

### 团队仪表盘

```bash
# 查看团队使用情况
codex team usage

# 查看活跃用户
codex team members

# 查看成本分布
codex team costs --period month
```

### 审计日志

```bash
# 查看审计日志
codex audit --days 30

# 导出日志
codex audit export --format csv --output audit.csv
```

### 策略管理

```json
// team-policy.json
{
  "policies": {
    "allowedModels": ["gpt-4o", "o1"],
    "maxTokens": 100000,
    "blockedCommands": ["rm -rf /*", "drop database"]
  }
}
```

---

## 7. 速率限制与配额

> 2026年2月新增的配额管理系统。

### 配置

```json
// codex.config.json
{
  "quotas": {
    "daily": 10000,
    "monthly": 100000,
    "perMinute": 60
  }
}
```

### 查看使用

```bash
# 查看当前使用
codex quota status

# 查看配额耗尽时间
codex quota reset-time
```

---

## 版本速查表

| 版本 | 日期 | 重点更新 |
|------|------|----------|
| 0.118.0 | 2026-03-31 | Codex Apps 发布 |
| 0.117.0 | 2026-03-15 | Plugins + Triggers |
| 0.115.0 | 2026-02-28 | Slack GA + ccg |
| 0.114.0 | 2026-02-15 | 速率限制/配额 |
| 0.113.0 | 2026-02-01 | GitHub 应用增强 |
| 0.112.0 | 2026-01-15 | 企业管理功能 |
| 0.111.0 | 2026-01-01 | Codex 正式发布 |

---

## Claude Code vs Codex 对比

| 特性 | Claude Code | Codex |
|------|-------------|-------|
| 运行环境 | 本地/远程 | 云端 |
| 团队协作 | ❌ | ✅ |
| GitHub 集成 | ✅ | ✅✅ |
| Plugins | ✅ | ✅ |
| Triggers | ❌ | ✅ |
| 企业管理 | ✅ (ccg) | ✅ |
| 免费额度 | 有限 | 订阅制 |

---

## 常见问题

### Q: Codex Apps 和 GitHub Copilot 有什么区别？

A:
- Copilot: 代码补全
- Codex: 对话式编程 + 自动化

### Q: Plugins 收费吗？

A: 基础插件免费，高级插件按量计费。

### Q: Triggers 可以运行自定义脚本吗？

A: 可以，支持 shell 命令和 API 调用。

---

## 小结

```
✅ Codex Apps - GitHub 云端编程
✅ Plugins - Sentry/Datadog 集成
✅ Triggers - GitHub 事件自动化
✅ GitHub 深度集成 - PR/Issue 自动处理
✅ Slack 集成 - 正式版
✅ 企业管理 - 团队管控
✅ 速率限制 - 配额管理
```
