# Claude Code 新功能补充（2026年）

> 根据官网最近三个月（2026年1月-4月）的更新，整理以下新功能。

---

## 目标

- 📋 掌握最新版本的核心功能
- 🔍 学会使用 `/review` 代码审查
- 📚 善用 `docs://` 文档速查
- 🤖 了解 Agent 自主完成任务
- 🔌 掌握 Plugins 扩展机制

---

## 1. 代码审查 `/review`

> 2.1.46 版本（2026年2月20日）新增 AI 代码审查命令。

### 使用

```bash
# 启动代码审查
/review

# 指定文件审查
/review src/LoginViewController.swift

# 增量审查（只查改动的）
/review --diff
```

### 输出示例

```
📋 代码审查报告

文件: src/LoginViewController.swift
总评分: ⭐⭐⭐⭐ (4/5)

🔴 严重问题 (0)
🟡 建议优化 (2)
🟢 最佳实践 (3)

建议:
1. [🟡] 第 23 行：建议添加输入验证
2. [🟡] 第 45 行：密码明文存储，建议使用 Keychain
3. [🟢] 第 67 行：使用了 async/await，代码清晰
```

### 审查维度

| 维度 | 说明 |
|------|------|
| 安全性 | 漏洞、敏感信息、权限 |
| 性能 | 内存、算法复杂度 |
| 可维护性 | 代码结构、重复 |
| 最佳实践 | Swift/iOS 规范 |

---

## 2. 文档速查 `docs://`

> 2.1.53 版本（2026年2月27日）新增内置文档搜索工具。

### 使用

```bash
# 搜索 Swift 文档
docs://swift async await

# 搜索 SwiftUI
docs://swiftui List ForEach

# 搜索 Xcode
docs://xcode build settings
```

### 2.1.86 版本（2026年3月26日）增强

```bash
# 直接从终端搜索文档
/docs swift struct extension
```

### 常用搜索

```bash
# Apple 官方文档
docs://uikit UIViewController
docs://swiftui NavigationStack
docs://foundation DateFormatter

# 第三方库
docs://alamofire request
docs://snapkit makeConstraints
```

---

## 3. Agent 自主模式

> 2.1.39 版本（2026年2月13日）新增 Auto Mode，自动完成任务。

### 启动方式

```bash
# 启动自主模式
/auto on

# 关闭自主模式
/auto off
```

### 工作原理

```
用户: "帮我重构 Auth 模块"
        ↓
Auto Mode: 分解任务
  ├── 分析现有代码
  ├── 制定重构计划
  ├── 逐步执行
  ├── 运行测试
  └── 汇报结果
        ↓
用户: 确认或中止
```

### 适用场景

| 场景 | 推荐 |
|------|------|
| 大型重构 | ✅ 开启 |
| 简单修改 | ❌ 关闭 |
| 危险操作 | ❌ 关闭 |
| 多文件改动 | ✅ 开启 |

---

## 4. 会话回放

> 2.1.29 版本（2026年2月6日）新增录制和回放功能。

### 录制

```bash
# 开始录制
/record start

# 停止录制
/record stop

# 保存到文件
/record save auth-refactor-2026
```

### 回放

```bash
# 查看录制列表
/record list

# 回放某个录制
/record play auth-refactor-2026
```

### 用途

- ✅ 复现问题
- ✅ 分享操作过程
- ✅ 培训教学

---

## 5. Plugins 扩展

> 2026年3月新增插件系统，连接第三方服务。

### 官方插件

| 插件 | 功能 |
|------|------|
| Sentry | 错误追踪 |
| Datadog | 监控告警 |
| GitHub | PR 管理 |
| Slack | 团队通知 |

### 安装

```bash
# 安装插件
/plugin install sentry

# 查看已安装
/plugin list

# 更新插件
/plugin update sentry
```

### 配置

```json
// claude_desktop_config.json
{
  "plugins": {
    "sentry": {
      "dsn": "https://xxx@sentry.io/xxx"
    },
    "datadog": {
      "apiKey": "xxx"
    }
  }
}
```

### 使用

```bash
# 查看错误
/plugin sentry issues

# 查看性能
/plugin datadog metrics
```

---

## 6. Triggers 触发器

> 自动响应 GitHub 事件的自动化规则。

### 配置

```json
// triggers.json
{
  "triggers": [
    {
      "name": "auto-review-pr",
      "on": "github.pull_request.opened",
      "action": "claude --review"
    },
    {
      "name": "bug-label-triage",
      "on": "github.issues.labeled",
      "if": "label == 'bug'",
      "action": "claude --triage"
    }
  ]
}
```

### 触发事件

| 事件 | 时机 |
|------|------|
| `github.push` | 代码推送 |
| `github.pull_request.opened` | PR 打开 |
| `github.issues.opened` | Issue 创建 |
| `github.issues.labeled` | 添加标签 |

### 部署

```bash
# 激活触发器
/trigger enable auto-review-pr

# 禁用
/trigger disable auto-review-pr

# 查看状态
/trigger list
```

---

## 7. 远程服务器增强

> 2.1.53 版本增强远程服务器支持。

### 配置

```json
// claude_desktop_config.json
{
  "gateway": {
    "remoteServerActions": true,
    "remoteServerHttpMaxTokens": 8192
  }
}
```

### 使用

```bash
# 连接到远程服务器
claude remote connect prod-server

# 执行命令
remote> "部署最新版本"

# 上传文件
remote> "上传 ./build 到服务器"
```

---

## 8. Lora 微调支持

> 2.1.39 版本新增 Lora 微调配置。

```json
{
  "gateway": {
    "lora": {
      "path": "./models/my-lora.safetensors",
      "scale": 0.8
    }
  }
}
```

---

## 9. Slack 集成（正式版）

> 2026年2月 Slack 集成正式发布。

### 安装

```bash
claude slack install
```

### 功能

- 💬 Slack 内直接对话
- 📊 代码审查结果推送
- 🔔 构建失败通知
- 📈 部署状态更新

---

## 10. 企业管理 CLI (`ccg`)

> 2026年2月发布的企业管理工具。

### 安装

```bash
npm install -g @anthropic-ai/ccg
```

### 功能

```bash
# 查看团队使用情况
ccg usage --team

# 批量管理配置
ccg config push --team

# 查看审计日志
ccg audit --days 30
```

---

## 版本速查表

| 版本 | 日期 | 重点更新 |
|------|------|----------|
| 2.1.91 | 2026-04-02 | MCP 结果大小控制 |
| 2.1.86 | 2026-03-26 | docs:// 工具增强 |
| 2.1.79 | 2026-03-20 | 转录查看器 |
| 2.1.69 | 2026-03-13 | 长输出分页 |
| 2.1.57 | 2026-03-06 | --no-input 标志 |
| 2.1.53 | 2026-02-27 | docs/ 工具 + 远程操作 |
| 2.1.46 | 2026-02-20 | /review 代码审查 |
| 2.1.39 | 2026-02-13 | Auto Mode + Lora |
| 2.1.29 | 2026-02-06 | 屏幕感知 + 会话回放 |
| 2.1.23 | 2026-01-30 | 远程服务器操作 |
| 2.1.17 | 2026-01-23 | GitHub 应用改进 |
| 2.1.11 | 2026-01-16 | Claude 3.5 Haiku 支持 |
| 2.1.5 | 2026-01-09 | 计算机操作 API |
| 2.1.0 | 2026-01-02 | 循环任务调度 |

---

## 常见问题

### Q: Auto Mode 和普通模式有什么区别？

A: Auto Mode 会自动连续执行多个步骤，适合大型任务；普通模式每步需要确认，适合精确控制。

### Q: Plugins 和 MCP 有什么区别？

A: Plugins 是官方维护的深度集成，MCP 是通用扩展协议。Plugins 开箱即用，MCP 更灵活。

### Q: Triggers 是免费功能吗？

A: 需要 Claude Code Team 或 Enterprise 订阅。

---

## 小结

```
✅ /review - AI 代码审查
✅ docs:// - 内置文档速查  
✅ Auto Mode - 自主任务执行
✅ 会话回放 - 录制与复现
✅ Plugins - Sentry/Datadog 集成
✅ Triggers - GitHub 事件响应
✅ 远程服务器 - 增强配置
✅ Lora 微调 - 自定义模型
✅ Slack 集成 - 正式版
✅ ccg 企业管理 - 团队管控
```
