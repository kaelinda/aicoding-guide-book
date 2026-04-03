# 01-Claude Code 实战

> 终端里的 AI 结对编程助手

## 🎯 Claude Code 是什么

Claude Code 是 Anthropic 推出的命令行 AI 编程助手，可以：
- 读取和修改你的代码
- 执行命令和测试
- 理解整个项目结构
- 自主完成复杂任务

**核心优势：**
- 🚀 直接在终端使用，无需切换窗口
- 🔍 深度理解代码上下文
- 🛠 自动执行，不用复制粘贴
- 📝 支持 AGENTS.md 配置

## 📦 安装

### 前置条件

- Node.js 18+ （已完成）
- Claude Pro 或 Claude Team 订阅

### 安装步骤

```bash
# 全局安装
npm install -g @anthropic-ai/claude-code

# 验证安装
claude --version
```

### 登录认证

```bash
# 首次运行会提示登录
claude

# 按提示打开浏览器
# 完成授权后回到终端
```

## 🚀 基本使用

### 启动交互模式

```bash
cd ~/Projects/my-app
claude
```

会看到交互界面：

```
╭─────────────────────────────────────╮
│ Claude Code                          │
│ Model: claude-3.5-sonnet             │
│ Workspace: ~/Projects/my-app         │
╰─────────────────────────────────────╯

What would you like to do?
```

### 常用命令

#### /help - 查看帮助
```
/help
```

#### /model - 切换模型
```
/model claude-3.5-sonnet    # 快速，适合日常
/model claude-3-opus        # 强大，适合复杂任务
```

#### /clear - 清空对话
```
/clear
```

#### /compact - 压缩对话历史
```
/compact
```

### 实战案例

#### 案例 1：创建新组件

```
你：创建一个用户列表组件，包含：
    - 用户头像
    - 用户名
    - 邮箱
    - 操作按钮（编辑、删除）
    使用 SwiftUI 实现

Claude：
[分析项目结构]
[创建 UserListView.swift]
[创建 UserListViewModel.swift]
[添加示例数据]

✅ 已创建用户列表组件
文件：UserListView.swift, UserListViewModel.swift
预览：[显示预览代码]
```

#### 案例 2：修复 Bug

```
你：登录页面的密码验证有问题，
    提示"密码太短"但实际输入了 10 位

Claude：
[读取 LoginViewController.swift]
[定位验证逻辑]
发现问题：密码长度判断用的是 `>` 而不是 `<`

修复：
- 修改第 45 行：`if password.count > 8` → `if password.count < 8`
✅ 已修复

是否需要运行测试验证？
```

#### 案例 3：重构代码

```
你：把 UserViewController 重构成 MVVM 架构

Claude：
[分析现有代码结构]
规划重构步骤：
1. 创建 UserViewModel
2. 提取业务逻辑
3. 更新 ViewController
4. 添加数据绑定

开始重构...
[创建 UserViewModel.swift]
[重构 UserViewController.swift]
[更新依赖关系]

✅ 重构完成
建议：运行测试验证功能正常
```

## 🎯 高级功能

### AGENTS.md 配置

在项目根目录创建 `AGENTS.md`：

```markdown
# 项目配置

## 技术栈
- Swift 5.9
- SwiftUI
- MVVM 架构

## 编码规范
- 使用 4 空格缩进
- 函数命名使用 camelCase
- MARK 注释分隔代码块

## 项目结构
- Views/ - 视图层
- ViewModels/ - 视图模型层
- Models/ - 数据模型层
- Services/ - 服务层

## 常用命令
- 构建：`xcodebuild -scheme MyProject`
- 测试：`xcodebuild test -scheme MyProject`
```

Claude Code 会自动读取并遵守这些规则。

### 多文件操作

```
你：把所有 ViewController 改成使用新的主题系统

Claude：
[扫描所有 ViewController 文件]
找到 12 个文件：
- LoginViewController.swift
- HomeViewController.swift
- ...

开始批量修改...
[读取旧主题系统]
[理解新主题系统]
[逐个修改文件]

✅ 已修改 12 个文件
```

### 执行测试

```
你：运行单元测试，如果有失败的就修复

Claude：
[执行测试命令]
测试结果：3 个失败

失败 1：UserViewModelTests.testValidation
错误：断言失败，期望 true 实际 false

分析失败原因...
[读取测试代码]
[读取被测代码]
发现问题：验证逻辑有边界错误

修复中...
[修改 UserViewModel.swift]
[重新运行测试]

✅ 所有测试通过
```

## 💡 高效使用技巧

### 1. 提供清晰的上下文

```
❌ "改一下这个"
✅ "修改 LoginViewController.swift 第 45 行的验证逻辑，
    允许邮箱包含 . 符号"
```

### 2. 分步骤复杂任务

```
❌ "重构整个项目"
✅ "第一步：把用户模块重构成 MVVM"
   "第二步：把订单模块重构成 MVVM"
```

### 3. 利用项目知识

```
你：按照我们项目的 MVVM 模式创建商品详情页

Claude：
[读取 AGENTS.md]
[分析现有 MVVM 实现]
[模仿现有模式创建新页面]
```

### 4. 及时反馈

```
Claude：已创建文件，是否需要调整？
你：列表样式改成卡片式
Claude：[调整样式]
你：这个可以了
```

## 🛡 安全与权限

### 权限模式

Claude Code 有三种权限模式：

```bash
# 自动模式（推荐新手）
claude --approval auto

# 交互模式（默认）
claude --approval interactive

# 只读模式
claude --approval readonly
```

### 敏感操作确认

```
Claude：我需要删除 5 个未使用的文件
        是否继续？

[Delete] [Skip] [Cancel]
```

### 查看操作历史

```bash
# 查看最近的操作日志
claude --log

# 查看详细日志
claude --log --verbose
```

## 📊 与其他工具对比

| 特性 | Claude Code | Cursor | Codex CLI |
|------|-------------|--------|-----------|
| 环境 | 终端 | IDE | 终端 |
| 自主性 | 高 | 中 | 高 |
| 学习曲线 | 中 | 低 | 中 |
| iOS 支持 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 价格 | $20/月 | $20/月 | $20/月 |

## 🎓 最佳实践

### 项目初始化时

```bash
# 创建 AGENTS.md
echo "# 项目配置\n\n## 技术栈\n- Swift\n- SwiftUI" > AGENTS.md

# 让 Claude 理解项目结构
claude
你：分析这个项目的架构，并更新 AGENTS.md
```

### 日常开发流程

```
1. 启动 Claude Code
2. 描述当前任务
3. Claude 执行并反馈
4. 验证结果
5. 提交代码
```

### 代码审查

```
你：审查最近 3 次提交的代码

Claude：
[分析 git log]
[读取变更的文件]
审查结果：
1. 提交 abc123：性能优化
   - ✅ 正确使用缓存
   - ⚠️ 建议添加缓存过期逻辑
   
2. 提交 def456：新增功能
   - ✅ 代码结构清晰
   - ⚠️ 缺少单元测试
   
3. 提交 ghi789：修复 Bug
   - ✅ 修复正确
   - 建议添加回归测试
```

## ⚠️ 常见问题

### 问题 1：连接超时

```
解决：
1. 检查网络连接
2. 设置代理：
   export HTTPS_PROXY=http://localhost:7890
```

### 问题 2：文件权限错误

```
解决：
检查文件权限
ls -la file.swift
修改权限
chmod 644 file.swift
```

### 问题 3：忘记密码

```
解决：
重新登录
claude --logout
claude
```

## ✅ 小结

- Claude Code 是终端里的 AI 编程助手
- 支持创建、修改、重构代码
- AGENTS.md 提供项目级配置
- 交互模式让开发更高效

## 🔗 相关资源

- [Claude Code 官方文档](https://docs.anthropic.com/claude-code)
- [AGENTS.md 最佳实践](https://agentsmd.io/)
- [Claude Code GitHub](https://github.com/anthropics/claude-code)

---

**下一步：** [Cursor 实战 →](../02-Cursor实战/README.md)
