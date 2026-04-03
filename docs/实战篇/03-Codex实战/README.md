# 03-Codex 实战

> OpenAI 的命令行编程助手，GPT-5 驱动

## 🎯 Codex CLI 是什么

Codex CLI 是 OpenAI 推出的命令行 AI 编程工具，内置 GPT-5 模型。

**核心优势：**
- 🧠 GPT-5 驱动，推理能力强大
- ⚡ Rust 编写，性能极佳
- 🔒 本地运行，代码不离开你的机器
- 🛠 自动执行，无需复制粘贴
- 🤝 与 ChatGPT 打通，无缝切换

**适用场景：**
- 快速原型开发
- 代码重构和优化
- Bug 修复和调试
- 测试用例生成
- 文档编写

## 📦 安装 Codex

### 前置条件

- Node.js 18+
- ChatGPT Plus / Pro / Team 订阅

### 安装步骤

```bash
# 全局安装
npm install -g @openai/codex

# 验证安装
codex --version
```

### 登录认证

```bash
# 首次运行
codex

# 按提示登录
# 选择：
# 1. ChatGPT 账号登录（推荐）
# 2. API Key 登录

# 选择 ChatGPT 登录会打开浏览器
# 完成授权后回到终端
```

## 🚀 基本使用

### 启动交互模式

```bash
cd ~/Projects/my-app
codex
```

```
╭─────────────────────────────────────╮
│ Codex CLI                            │
│ Model: gpt-5-codex                   │
│ Workspace: ~/Projects/my-app         │
╰─────────────────────────────────────╯

What would you like to build?
```

### 核心命令

#### /help - 帮助
```
/help
```

#### /model - 切换模型
```
/model gpt-5-codex      # Codex 专用模型
/model gpt-5.4          # 最强推理能力
/model gpt-5.3-codex    # 平衡性能与速度
```

#### /reasoning - 推理模式
```
/reasoning high     # 深度推理，复杂任务
/reasoning medium   # 平衡模式
/reasoning low      # 快速响应
```

### 实战案例

#### 案例 1：创建 Swift 文件

```
你：创建一个网络请求管理器，支持：
    - GET/POST 请求
    - 错误处理
    - Token 管理
    使用 async/await

Codex：
[分析需求]
[创建 NetworkManager.swift]

文件已创建：NetworkManager.swift

包含方法：
- get<T>(url:) -> T
- post<T>(url:, body:) -> T
- setToken(_:)
- handleError(_:)

是否需要添加单元测试？
```

#### 案例 2：代码审查

```
你：审查 UserViewModel.swift 的代码质量

Codex：
[读取文件]
[分析代码结构]

代码审查报告：

✅ 优点：
- 使用 async/await 现代语法
- 错误处理完善
- 遵循 MVVM 架构

⚠️ 建议改进：
1. 第 34 行：使用 @MainActor 标记
2. 第 67 行：考虑添加缓存策略
3. 第 89 行：提取魔法数字为常量

❌ 问题：
- 第 45 行：潜在的内存泄漏
  原因：未使用 [weak self]
  修复：添加 [weak self] 捕获列表

是否自动修复？ [Y/n]
```

#### 案例 3：重构代码

```
你：把 UserService 重构成 Repository 模式

Codex：
[分析现有代码]
[规划重构步骤]

重构计划：
1. 创建 UserRepository 协议
2. 实现 RemoteUserRepository
3. 实现 LocalUserRepository
4. 更新 UserService 使用 Repository

开始重构...
[创建 UserRepository.swift]
[创建 RemoteUserRepository.swift]
[创建 LocalUserRepository.swift]
[更新 UserService.swift]

✅ 重构完成
新增文件：3 个
修改文件：1 个

运行测试验证？
```

## 🎯 高级功能

### 1. AGENTS.md 配置

在项目根目录创建 `AGENTS.md`：

```markdown
# 项目配置

## 技术栈
- Swift 5.9
- SwiftUI
- Combine
- MVVM + Clean Architecture

## 编码规范
- 使用 4 空格缩进
- 遵循 Swift API 设计指南
- 所有 public API 添加文档注释
- 使用 SwiftUI 预览

## 项目结构
- Presentation/ - 表现层
  - Views/
  - ViewModels/
- Domain/ - 业务层
  - UseCases/
  - Entities
- Data/ - 数据层
  - Repositories
  - DataSources

## 禁止事项
- 不要使用强制解包
- 不要在 View 中写业务逻辑
- 不要忽略编译警告
```

Codex 会自动读取并遵守。

### 2. 子代理（Subagents）

```bash
# 创建子代理处理并行任务
codex --subagent

# 示例：并行重构多个模块
你：并行重构 User 模块和 Product 模块

Codex：
启动 2 个子代理...
[Agent 1: 重构 User 模块]
[Agent 2: 重构 Product 模块]

Agent 1 完成 ✅
Agent 2 完成 ✅

合并结果...
所有模块重构完成
```

### 3. 网络搜索

```
你：搜索 SwiftUI 最新的动画 API 并给出示例

Codex：
[调用网络搜索]
[获取最新信息]

SwiftUI 动画 API（2026）：
1. spring(response:, dampingFraction:)
2. animation(_:value:)
3. withAnimation {}

示例代码：
[生成可运行的示例]

需要创建演示项目吗？
```

### 4. CI/CD 集成

```yaml
# .github/workflows/code-review.yml
name: AI Code Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Codex Review
        run: |
          npm install -g @openai/codex
          codex --non-interactive \
                --task "审查 PR 的代码质量" \
                --output review.md

      - name: Post Review
        uses: actions/github-script@v6
        with:
          script: |
            const fs = require('fs');
            const review = fs.readFileSync('review.md', 'utf8');
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: review
            });
```

## 💡 iOS 开发实战

### 场景 1：快速原型开发

```
你：创建一个 Todo App，功能包括：
    - 添加/删除/编辑任务
    - 标记完成
    - 本地持久化
    使用 SwiftUI + SwiftData

Codex：
[生成完整项目结构]

TodoApp/
├── TodoApp.swift
├── ContentView.swift
├── Models/
│   └── TodoItem.swift
├── ViewModels/
│   └── TodoViewModel.swift
└── Views/
    ├── TodoListView.swift
    ├── AddTodoView.swift
    └── EditTodoView.swift

✅ 项目已创建
运行：xcodebuild -scheme TodoApp
```

### 场景 2：性能优化

```
你：优化这个列表的性能，滚动时有卡顿

Codex：
[分析代码]
[识别性能瓶颈]

性能问题：
1. 图片未缓存，每次滚动都重新加载
2. 单元格布局复杂，未使用 LazyVStack
3. 数据量大时，未使用分页

优化方案：
1. 添加图片缓存
2. 使用 LazyVStack 替代 VStack
3. 实现分页加载

是否应用优化？ [Y/n]

优化后预计提升：50%+
```

### 场景 3：测试生成

```
你：为 NetworkManager 生成完整的单元测试

Codex：
[分析代码结构]
[生成测试用例]

已创建：NetworkManagerTests.swift

测试覆盖：
✅ testGetRequest
✅ testPostRequest
✅ testTokenManagement
✅ testErrorHandling
✅ testRetryMechanism
✅ testTimeout

覆盖率：95%

运行测试：xcodebuild test -scheme MyProject
```

### 场景 4：文档生成

```
你：为整个项目生成 API 文档

Codex：
[扫描所有 public API]
[生成文档]

已生成文档：
- README.md（项目说明）
- docs/API.md（API 文档）
- docs/Architecture.md（架构说明）
- docs/Setup.md（安装指南）

是否创建文档站点？
```

## 🔄 与 Claude Code 对比

| 维度 | Codex CLI | Claude Code |
|------|-----------|-------------|
| 模型 | GPT-5-Codex | Claude-3.5-Sonnet |
| 推理能力 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 编码能力 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 价格 | 包含在 ChatGPT Plus | $20/月 |
| 企业支持 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| iOS 适配 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 子代理 | ✅ 支持 | ✅ 支持 |

**推荐策略：**
- **复杂推理任务** → Codex（GPT-5 推理能力强）
- **日常编码** → Claude Code（性价比高）
- **企业项目** → Codex（企业支持完善）
- **个人项目** → 都可以

## 🛡 安全与权限

### 审批模式

```bash
# 自动模式（适合信任的环境）
codex --approval auto

# 交互模式（默认，敏感操作需要确认）
codex --approval interactive

# 只读模式（只能读不能改）
codex --approval readonly
```

### 敏感操作确认

```
Codex：我需要执行以下命令：
        npm install some-package
        是否继续？

[Approve] [Reject] [View Details]
```

### 黑名单命令

在 `AGENTS.md` 中配置：

```markdown
## 安全配置
禁止执行：
- rm -rf
- sudo
- git push --force
- npm publish
```

## ⚠️ 常见问题

### 问题 1：登录失败

```
错误：Authentication failed

解决：
1. 检查网络连接
2. 清除缓存：
   rm -rf ~/.codex/cache
3. 重新登录：
   codex --logout
   codex
```

### 问题 2：响应很慢

```
原因：
1. GPT-5 推理耗时
2. 任务复杂

解决：
1. 降低推理等级：
   /reasoning low
2. 简化任务描述
3. 分步骤执行
```

### 问题 3：无法修改文件

```
原因：权限不足

解决：
chmod 644 file.swift
```

## 📊 工作流建议

### 日常开发流程

```
1. 启动 Codex
2. 描述任务
3. Codex 执行并反馈
4. 审查结果
5. 提交代码
```

### 与其他工具配合

```
Cursor（编码）
    ↓
Codex（重构、审查）
    ↓
Claude Code（自动化测试）
    ↓
OpenClaw（远程监控）
```

## ✅ 小结

- Codex CLI 是 OpenAI 的命令行编程助手
- GPT-5 驱动，推理能力强大
- 支持子代理、网络搜索、CI/CD 集成
- 与 ChatGPT 打通，无缝切换
- 适合复杂推理和企业项目

## 🔗 相关资源

- [Codex 官方文档](https://developers.openai.com/codex/cli)
- [Codex 最佳实践](https://developers.openai.com/codex/learn/best-practices)
- [Codex GitHub](https://github.com/openai/codex)
- [Codex 更新日志](https://developers.openai.com/codex/changelog)

---

**下一步：** [Prompt 技巧 →](../../进阶篇/03-Prompt技巧/README.md)
