# Agents 使用教程

> Codex Agents 详解：让 AI 自动执行复杂任务的利器。

---

## 目标

- 🤖 理解 Codex Agents 的定位和使用场景
- ⚙️ 掌握 --agent 模式的核心用法
- 🛠️ 学会编写高质量的 Agent Prompt
- 🚀 了解多 Agent 协作模式
- ⚠️ 掌握安全与成本控制策略

---

## 什么是 Codex Agents

### Codex CLI 的 Agent 模式

Codex CLI 默认以**对话模式**运行——你问一句，它答一句。但当你需要 AI 完成复杂任务（如"重构整个 Auth 模块"或"修复这 20 个 Bug"）时，单轮对话往往力不从心。

**Codex Agents** 是 Codex CLI 的自动执行模式：给它一个目标，它会自主规划、分步执行、持续迭代，直到任务完成。Agent 模式下，AI 不再只是"答"，而是主动"做"——读取文件、修改代码、运行命令、提交 Commit。

```bash
# 普通对话模式（你问它答）
codex "这段代码有什么问题？"

# Agent 模式（给它目标，让它自己完成）
codex --agent "重构 src/auth/ 目录，使用 JWT Bearer Token 替代 Session"
```

### 与 Claude Code 的区别

| 特性 | Claude Code | Codex Agents |
|------|-------------|---------------|
| **核心交互** | 对话式 + 工具调用 | 目标驱动 + 自主执行 |
| **工具调用** | Read/Search/Edit/Bash | Read/Write/Bash + MCP |
| **多 Agent** | Task 工具派发 Subagent | 内置多角色 Agent |
| **会话管理** | 本地会话 | 云端同步（Codex Apps） |
| **适用场景** | 精细控制、快速修改 | 复杂长任务、自动化 |
| **成本** | 相对较低 | Token 消耗较大 |

简单说：**Claude Code 是你的副驾驶，Codex Agents 是你的自动驾驶。**

---

## 核心功能

### --agent 模式

Codex CLI 内置多种 Agent 类型，通过 `--agent` 参数指定：

| Agent 类型 | 用途 | 触发场景 |
|-----------|------|---------|
| `claude` | 通用对话 + 代码任务 | 日常开发、问题解答 |
| `coder` | 代码生成与重构 | 新功能开发、代码重写 |
| `git-agent` | Git 操作自动化 | 自动化提交、分支管理 |
| `reviewer` | 代码审查 | PR Review、代码质量检查 |
| `tester` | 单元测试生成 | TDD、测试补全 |
| `doc-writer` | 文档生成 | README、API 文档、注释 |
| `security-agent` | 安全扫描 | 漏洞检测、依赖审计 |

```bash
# 指定 Agent 类型
codex --agent coder "实现用户权限管理模块"
codex --agent reviewer "审查 src/api/ 目录下所有接口"
codex --agent tester "为 auth service 补充测试用例"
codex --agent git-agent "整理最近的提交，生成 CHANGELOG"
```

### 工具调用（Tools）

Agent 模式下，Codex 会自动调用各种工具完成任务：

| 工具 | 作用 |
|------|------|
| `Read` | 读取文件内容 |
| `Write` | 创建或覆写文件 |
| `Edit` | 精确修改文件指定区域 |
| `Bash` | 执行 shell 命令 |
| `Grep` | 搜索文件内容 |
| `WebFetch` | 获取网页内容 |
| `MCP Tools` | 通过 MCP 协议调用外部工具（数据库、API 等）|

```bash
# 启用 MCP 工具扩展
codex --agent coder --mcp-config mcp-config.json "连接数据库生成 CRUD 接口"
```

### 上下文管理

Agent 模式会持续积累上下文（对话历史 + 已读取的文件），但上下文窗口有限。

**管理策略**：

```bash
# 指定最大上下文 Token 数（避免溢出）
codex --agent coder --max-tokens 50000 "重构整个项目"

# 开启会话压缩（自动摘要旧上下文）
codex --agent claude --compress "这是一个长项目..."

# 开启/关闭文件追踪
codex --agent coder --no-file-tracking "只做分析，不要修改文件"
```

---

## 实用技巧

### 如何编写高质量的 Agent Prompt

Agent 的效果 80% 取决于 Prompt。以下是经过验证的写作原则：

#### 1. 目标明确，不模糊

```bash
# ❌ 模糊目标
codex --agent coder "改进代码"

# ✅ 清晰目标
codex --agent coder "重构 src/services/user.ts，将 synchronous 数据库查询改为 async/await 模式，并添加错误处理"
```

#### 2. 提供约束条件

```bash
codex --agent coder "实现图片上传功能：
- 支持 JPG/PNG，最大 5MB
- 使用 S3 Presigned URL 上传
- 禁止直接上传到服务器本地磁盘
- 生成缩略图（200x200）
- 添加单元测试覆盖率 ≥ 80%"
```

#### 3. 给出上下文和参考

```bash
codex --agent reviewer "审查 src/auth/ 模块：
- 参考同目录下的 test/ 文件夹了解预期行为
- 使用 .claude/rules/api-contract.md 作为 API 设计规范
- 重点关注 Token 安全和 SQL 注入风险"
```

### 多 Agent 协作模式

对于超复杂任务，可以串联多个 Agent：

```bash
# Step 1: 让 tester 生成测试
codex --agent tester --output tests/expected.json "为 auth service 生成测试用例"

# Step 2: 让 coder 根据测试开发
codex --agent coder --input tests/expected.json "基于测试用例实现 auth service"

# Step 3: 让 reviewer 检查质量
codex --agent reviewer "审查 auth service 质量和测试覆盖率"
```

```bash
# 自动化串联（通过 shell 脚本）
#!/bin/bash
echo "Step 1: Generate tests..."
codex --agent tester --output /tmp/tests.json "为 payments 模块生成测试"

echo "Step 2: Implement code..."
codex --agent coder --input /tmp/tests.json "基于测试实现 payments 模块"

echo "Step 3: Review..."
codex --agent reviewer "审查 payments 模块"
```

### 任务分解策略

面对大型任务，用"分而治之"策略：

```
大型任务
    ↓ 拆解
子任务 1（独立） → 子任务 2（依赖1） → 子任务 3（独立）
    ↓
并行执行独立任务，串行执行依赖任务
```

```bash
# ❌ 一个 Agent 干所有
codex --agent coder "重构整个项目"

# ✅ 分解为多个 Agent
codex --agent coder --scope "src/core/ 模块重构"
codex --agent coder --scope "src/api/ REST 接口重构"
codex --agent coder --scope "src/utils/ 工具函数重构"
codex --agent git-agent "合并以上所有修改，创建 PR"
```

---

## 实际案例

### 场景一：自动化代码审查

```bash
codex --agent reviewer "审查最近一次 commit 的所有修改：
- 重点检查 src/api/ 下的接口安全性
- 检查是否有硬编码的密钥或凭证
- 检查错误处理是否完整
- 输出审查报告到 code-review-report.md"
```

### 场景二：TDD 测试驱动开发

```bash
# 先写测试
codex --agent tester "为 src/services/order.ts 创建测试用例：
- 测试正常创建订单流程
- 测试库存不足场景
- 测试支付失败场景
- 测试并发下单场景
- 输出到 tests/services/order.test.ts"

# 再实现功能
codex --agent coder --input tests/services/order.test.ts "基于测试用例实现 order service，测试必须全部通过"
```

### 场景三：自动生成文档

```bash
codex --agent doc-writer "为 src/api/ 目录下所有接口生成 API 文档：
- 包含请求/响应示例
- 包含错误码说明
- 包含认证方式说明
- 格式：OpenAPI 3.0
- 输出到 docs/openapi.yaml"
```

### 场景四：安全漏洞扫描

```bash
codex --agent security-agent "扫描整个项目：
- 依赖包漏洞（npm audit）
- 硬编码凭证检测
- SQL 注入风险
- XSS 风险
- 输出到 security-report.md"
```

---

## 注意事项

### 速率限制

Codex Agent 模式消耗 Token 量远大于普通对话。

| 套餐 | Agent 模式限制 |
|------|--------------|
| Free | 有限，建议用于简单任务 |
| Pro ($20/mo) | 较高配额，支持更长任务 |
| Team | 团队共享配额，可设置用量上限 |
| Enterprise | 自定义配额，可与销售协商 |

**优化建议**：
```bash
# 使用 --dry-run 先看计划，不消耗 Token
codex --agent coder --dry-run "重构 auth 模块"

# 设置 Token 上限
codex --agent coder --max-tokens 20000 "实现某个功能"

# 使用 --checkpoint 保存进度
codex --agent coder --checkpoint ./checkpoints/auth-1.json "长任务中途保存"
```

### 成本控制

Agent 模式的成本是普通对话的 3-5 倍（因为执行时间长、Token 消耗大）。

**成本优化策略**：
- **小任务用对话**：简单修改直接用 `codex "修改 xxx"` 即可
- **大任务先规划**：用 `--dry-run` 预览计划再决定是否执行
- **分批执行**：不要让一个 Agent 干超过 30 分钟的活
- **设置配额**：企业版可在后台设置每人每月的 Token 上限

### 安全考虑

Agent 模式下 AI 会自动执行 Bash 命令，有一定风险：

| 风险 | 防护措施 |
|------|---------|
| 误删文件 | 启用 `.codex-allowlist` 白名单，仅允许特定命令 |
| 生产环境误操作 | 禁止 Agent 直接操作 `main` / `master` 分支 |
| 恶意代码注入 | 开启 `--sandbox` 沙盒模式，隔离执行 |
| 敏感信息泄露 | 禁止在 Agent 会话中暴露密钥，使用 Vault 代替 |

```bash
# 白名单模式（仅允许特定命令）
codex --agent coder --allowed-commands "git, npm, npx" "修改代码"

# 沙盒模式（隔离执行）
codex --agent coder --sandbox "安全执行未知代码"

# 禁止直接写 main 分支
codex --agent git-agent --protect-branches "main,master,production"
```

---

## 小结

```
✅ Codex Agents = 目标驱动的自动化执行模式
✅ 多种 Agent 类型：coder / reviewer / tester / git-agent / doc-writer / security-agent
✅ 核心能力：工具调用 + 上下文管理 + 多 Agent 协作
✅ 实用技巧：明确目标 + 给出约束 + 任务分解
✅ 实际场景：代码审查、TDD、文档生成、安全扫描
✅ 注意事项：速率限制、成本控制、安全白名单
```

> 下一步：了解 Codex 的 Plugins 扩展系统 →