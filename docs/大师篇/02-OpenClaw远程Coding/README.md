# 02-OpenClaw 远程 Coding

> 随时随地，用手机操控 AI 编程

## 🎯 什么是 OpenClaw 远程 Coding

### 传统开发的局限

```
场景：你在地铁上，突然想到一个功能改进

传统方式：
1. 等回到家
2. 打开电脑
3. 打开 IDE
4. 开始写代码
→ 灵感可能已经忘了

OpenClaw 方式：
1. 掏出手机
2. 打开 Telegram/飞书
3. 发消息："帮我实现 XXX"
4. AI 自动完成
→ 到家就能看到成品
```

### OpenClaw 的核心能力

```
┌─────────────────────────────────┐
│      你的设备（手机/平板）        │
│   Telegram / 飞书 / Discord      │
└─────────────┬───────────────────┘
              │ 消息
              ↓
┌─────────────────────────────────┐
│       OpenClaw Gateway          │
│  （运行在你家的 Mac/服务器上）    │
└─────────────┬───────────────────┘
              │ 调用
              ↓
┌─────────────────────────────────┐
│         AI Agent                │
│  Claude Code / Codex / Cursor   │
└─────────────┬───────────────────┘
              │ 执行
              ↓
┌─────────────────────────────────┐
│      你的项目代码库              │
│  （本地或 GitHub）               │
└─────────────────────────────────┘
```

## 🚀 快速开始

### 1. 安装 OpenClaw

```bash
# 安装 OpenClaw
npm install -g openclaw@latest

# 运行初始化向导
openclaw onboard --install-daemon
```

### 2. 配置渠道

OpenClaw 支持多种消息渠道：

#### 飞书配置（推荐国内用户）

```bash
# 1. 创建飞书应用
# 访问：https://open.feishu.cn/app
# 创建企业自建应用

# 2. 获取凭证
# App ID: cli_xxx
# App Secret: xxx

# 3. 配置 OpenClaw
openclaw config set channels.feishu.appId cli_xxx
openclaw config set channels.feishu.appSecret xxx

# 4. 启动服务
openclaw start
```

#### Telegram 配置（推荐海外用户）

```bash
# 1. 创建 Telegram Bot
# 与 @BotFather 对话，创建新 Bot
# 获得 Bot Token: 123456789:ABCdefGHIjklMNOpqrsTUVwxyz

# 2. 配置 OpenClaw
openclaw config set channels.telegram.botToken 123456789:ABCdefGHIjklMNOpqrsTUVwxyz

# 3. 启动服务
openclaw start
```

### 3. 测试连接

```
你（手机飞书）：
你好

OpenClaw：
你好！我是你的 AI 编程助手。
当前工作空间：~/Projects/my-app
有什么可以帮你的？
```

## 💻 实战场景

### 场景 1：外出时修复紧急 Bug

```
时间：周六下午 3 点
地点：咖啡厅
事件：收到测试反馈，登录页面有 Bug

你（手机）：
登录页面验证码输入框无法输入，
请检查并修复

OpenClaw：
收到，开始诊断...
[读取 LoginViewController.swift]
[定位问题]
发现问题：输入框被设置为只读

修复中...
[修改代码]
[运行测试]

✅ 已修复
修改文件：LoginViewController.swift 第 78 行
改动：移除 `isUserInteractionEnabled = false`

需要我提交代码吗？

你：
提交并推送

OpenClaw：
✅ 已提交
提交信息：fix: 修复验证码输入框无法输入的问题
分支：bugfix/login-code-input

你可以通知测试同学验证了。
```

### 场景 2：通勤时开发新功能

```
时间：周一早上 8:30
地点：地铁上
事件：突然想到一个好点子

你（手机）：
给商品列表添加一个下拉刷新功能

OpenClaw：
收到，开始开发...

分析项目结构...
- 使用 SwiftUI
- 列表组件：ProductListView.swift

开发计划：
1. 添加刷新状态
2. 实现下拉手势
3. 调用刷新 API
4. 更新 UI

开始实施...
[创建 RefreshableView.swift]
[更新 ProductListView.swift]
[添加刷新逻辑]

✅ 开发完成
新增文件：RefreshableView.swift
修改文件：ProductListView.swift

是否需要测试？

你：
运行测试

OpenClaw：
[运行单元测试]
[运行 UI 测试]

✅ 所有测试通过

你可以 pull 最新代码查看了。
```

### 场景 3：睡前检查项目进度

```
时间：晚上 11 点
地点：床上
事件：想看看今天的工作进展

你（手机）：
总结一下今天完成的工作

OpenClaw：
今日工作总结：

✅ 已完成：
1. 用户登录功能（上午）
   - 邮箱验证
   - 密码强度检查
   - Token 管理

2. 商品列表优化（下午）
   - 下拉刷新
   - 分页加载
   - 图片缓存

3. Bug 修复（晚上）
   - 修复验证码输入问题
   - 修复图片加载闪烁

📊 数据：
- 提交次数：5 次
- 代码变更：+823 / -156 行
- 测试覆盖：从 78% → 85%

🔄 进行中：
- 订单模块开发（进度 60%）
- 预计明天完成

需要详细报告吗？
```

## 🎯 高级功能

### 多项目管理

```bash
# 配置多个工作空间
openclaw config set workspaces.ios.path ~/Projects/ios-app
openclaw config set workspaces.android.path ~/Projects/android-app
openclaw config set workspaces.backend.path ~/Projects/backend-api
```

```
你（手机）：
切换到 iOS 项目

OpenClaw：
✅ 已切换到 iOS 项目
路径：~/Projects/ios-app
分支：main
最近提交：2 小时前

有什么需要处理的？
```

### 权限控制

```json
// ~/.openclaw/openclaw.json
{
  "channels": {
    "feishu": {
      "allowFrom": ["ou_xxx"],  // 只允许你的飞书账号
      "groups": {
        "*": {
          "requireMention": true  // 群聊需要 @才响应
        }
      }
    }
  },
  "safety": {
    "requireApproval": ["git push", "npm publish"],  // 敏感操作需要确认
    "blacklist": ["rm -rf", "sudo"]  // 禁止执行的命令
  }
}
```

### 定时任务

```bash
# 每天早上 9 点发送项目状态
openclaw cron add "0 9 * * *" "发送今日任务列表"

# 每次代码提交后运行测试
openclaw hook add post-commit "运行相关测试"
```

## 🔒 安全最佳实践

### 1. 访问控制

```json
{
  "channels": {
    "feishu": {
      "allowFrom": ["你的 open_id"],
      "denyFrom": ["黑名单用户"]
    }
  }
}
```

### 2. 操作审批

```
OpenClaw：
你要求执行 `git push --force`
这是一个危险操作，需要确认。

确认推送？ [是] [否]
```

### 3. 敏感信息保护

```json
{
  "redaction": {
    "patterns": [
      "password.*?=.*",
      "api_key.*?=.*",
      "token.*?=.*"
    ],
    "replacement": "***REDACTED***"
  }
}
```

### 4. 审计日志

```bash
# 查看所有操作记录
openclaw logs --tail 100

# 导出审计报告
openclaw logs --export audit-2024-01.json
```

## 📱 移动端体验优化

### 快捷指令（iOS）

```
创建快捷指令：
1. 打开快捷指令 App
2. 创建新快捷指令
3. 添加"发送消息到飞书"
4. 设置消息内容

示例快捷指令：
- "查看今日任务"
- "运行测试"
- "提交代码"
- "查看状态"
```

### 语音输入

```
你（语音）：
"帮我创建一个用户详情页面，显示头像、用户名和邮箱"

OpenClaw：
收到语音指令，转换中...
[理解需求]
[开始开发]

✅ 已创建 UserDetailView.swift
```

### 多媒体支持

```
你（手机）：
[发送设计稿截图]

OpenClaw：
收到图片，分析中...
[识别设计元素]
[生成代码]

已根据设计稿创建视图：
- 顶部导航栏
- 用户头像（圆形）
- 用户信息卡片
- 操作按钮组

预览代码？
```

## 🌐 远程访问方案

### 方案 1：Tailscale（推荐）

```bash
# 1. 安装 Tailscale
brew install tailscale

# 2. 连接到你的网络
tailscale up

# 3. 获取你的 Tailscale IP
tailscale ip

# 4. 手机上也安装 Tailscale
# 连接同一网络，即可访问

# 5. 配置 OpenClaw
openclaw config set gateway.remote.url http://100.x.x.x:18789
```

### 方案 2：Cloudflare Tunnel

```bash
# 1. 安装 Cloudflare CLI
brew install cloudflare/cloudflare/cloudflared

# 2. 创建隧道
cloudflared tunnel create openclaw

# 3. 配置路由
cloudflared tunnel route dns openclaw openclaw.your-domain.com

# 4. 启动隧道
cloudflared tunnel run openclaw
```

### 方案 3：自建服务器

```bash
# 在 VPS 上部署 OpenClaw
# （适合 24 小时运行）

# 1. 购买 VPS（AWS/Azure/阿里云）
# 2. 安装 Node.js
# 3. 安装 OpenClaw
# 4. 配置 systemd 服务

sudo nano /etc/systemd/system/openclaw.service
```

```ini
[Unit]
Description=OpenClaw Gateway
After=network.target

[Service]
Type=simple
User=ubuntu
ExecStart=/usr/bin/openclaw start
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl enable openclaw
sudo systemctl start openclaw
```

## ⚠️ 常见问题

### 问题 1：消息发送失败

```
检查清单：
1. Gateway 是否启动？
   openclaw status
   
2. 网络是否通畅？
   ping 你的服务器
   
3. Token 是否正确？
   openclaw config get channels.feishu.appId
```

### 问题 2：响应很慢

```
可能原因：
1. Agent 正在处理复杂任务
2. 网络延迟
3. 服务器性能不足

优化：
1. 升级服务器配置
2. 使用 CDN 加速
3. 启用任务队列
```

### 问题 3：无法执行某些命令

```
检查安全配置：
openclaw config get safety

可能被加入黑名单：
{
  "blacklist": ["rm", "sudo", "chmod"]
}
```

## ✅ 小结

- OpenClaw 让你能随时随地调用 AI 编程
- 支持飞书、Telegram、Discord 等多种渠道
- 完善的安全机制保护你的代码
- 灵活的远程访问方案

## 🔗 相关资源

- [OpenClaw 官方文档](https://docs.openclaw.ai/)
- [Tailscale 官网](https://tailscale.com/)
- [飞书开放平台](https://open.feishu.cn/)

---

**下一步：** [高级工作流 →](../03-高级工作流/README.md)
