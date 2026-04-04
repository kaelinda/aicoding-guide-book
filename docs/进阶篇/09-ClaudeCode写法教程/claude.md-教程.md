# Claude.md 写法教程

> 如何编写高质量的 claude.md，让 Claude Code 秒懂你的项目。

---

## 目标

- 📋 理解 claude.md 的定位和作用
- 🏗️ 掌握 claude.md 的标准结构
- ⚙️ 学会高级配置技巧
- ✅ 写出真实可落地的 claude.md 示例

---

## 什么是 claude.md

### claude.md 的作用

`claude.md` 是 Claude Code 的"项目说明书"——当你首次进入项目目录时，Claude Code 会自动读取这个文件，将其作为项目的全局上下文。它让 AI 无需反复解释就能知道：

- 这是什么项目（name / description）
- 技术栈是什么（stack）
- 目录结构是怎样的（architecture）
- 代码规范是什么（conventions）
- 常用命令是什么（scripts）
- 环境变量和密钥怎么配置（dependencies）

简单说：**一份好的 claude.md = 减少 80% 的无效对话。**

### 什么时候需要 claude.md

| 场景 | 是否需要 | 原因 |
|------|---------|------|
| 新项目首次启动 | ✅ 必须 | Claude Code 完全不了解项目 |
| 多人协作项目 | ✅ 必须 | 不同人接手需要上下文 |
| 复杂技术栈 | ✅ 必须 | 架构、依赖、规范需要说明 |
| 简单单文件脚本 | ❌ 不需要 | 一看就懂，无需额外说明 |
| 一次性任务（问个问题就走） | ❌ 不需要 | 不值得花时间写 |

---

## 基础结构

一份完整的 claude.md 包含以下六个核心模块：

### 1. 项目概述（Project Overview）

```markdown
# 项目名称
## 简介（1-2 句话）
## 技术栈
```

**示例：**
```markdown
# UserService API

一个基于 Node.js 的用户认证微服务，提供注册、登录、Token 管理功能。

## 技术栈
- **运行时**: Node.js 18+
- **框架**: Express.js 4.x
- **数据库**: PostgreSQL 15 + Prisma ORM
- **认证**: JWT + Redis（黑名单）
- **部署**: Docker + AWS ECS
```

### 2. 项目架构（Architecture）

用树形结构展示关键目录，**只列出重要的**，不要列出所有文件。

```markdown
## 架构
```
├── src/
│   ├── controllers/   # 路由处理层
│   ├── services/     # 业务逻辑层
│   ├── models/        # Prisma schema + 类型定义
│   ├── middleware/    # 中间件（auth、errorHandler）
│   └── utils/        # 工具函数
├── prisma/
│   └── schema.prisma # 数据库 schema
├── tests/             # 测试文件（jest）
├── scripts/           # 部署/种子脚本
└── config/            # 环境配置
```
```

### 3. 开发规范（Conventions）

Claude Code 知道了规范，才会按你的风格写代码。

```markdown
## 代码规范
- **命名**: 
  - 变量/函数: camelCase
  - 类/类型: PascalCase
  - 常量: UPPER_SNAKE_CASE
  - 文件: kebab-case
- **API 风格**: RESTful，响应格式 `{ code, data, message }`
- **错误处理**: 所有 async 函数必须 try-catch，错误向上抛
- **类型安全**: 禁止使用 `any`，优先使用 `interface`
- **提交规范**: Conventional Commits（feat/fix/docs/style/refactor/test/chore）
```

### 4. 关键路径（Key Commands）

```markdown
## 常用命令
| 命令 | 说明 |
|------|------|
| `npm run dev` | 本地开发（端口 3000）|
| `npm run test` | 运行单元测试 |
| `npm run lint` | ESLint 检查 |
| `npm run migrate` | 执行数据库迁移 |
| `npm run seed` | 填充测试数据 |
| `docker-compose up` | 启动本地 PostgreSQL + Redis |
```

### 5. 依赖说明（Dependencies）

包括环境变量、密钥、第三方服务配置。

```markdown
## 环境变量
| 变量 | 说明 | 示例 |
|------|------|------|
| `DATABASE_URL` | PostgreSQL 连接字符串 | `postgresql://...` |
| `JWT_SECRET` | JWT 签名密钥 | ≥32 位随机字符串 |
| `REDIS_URL` | Redis 连接字符串 | `redis://localhost:6379` |
| `AWS_REGION` | AWS 区域 | `ap-northeast-1` |
| `SENTRY_DSN` | Sentry 监控地址 | `https://...@sentry.io/...` |

> ⚠️ 生产环境密钥绝对不能提交到代码库，请使用 AWS Secrets Manager 管理。
```

---

## 高级用法

### 多环境配置

对于多环境项目，可以在 claude.md 中说明各环境的差异：

```markdown
## 环境
| 环境 | 数据库 | API 地址 |
|------|--------|---------|
| local | localhost:5432 | http://localhost:3000 |
| staging | staging-db.example.com | https://staging-api.example.com |
| production | prod-db.example.com | https://api.example.com |

### 环境切换
- 使用 `.env.local`、`.env.staging`、`.env.production`
- 本地开发使用 `npm run dev:staging` 可连接 staging 环境
```

### 自定义规则（.claude/rules）

如果项目有特殊的 CLI 或约定，可以创建 `.claude/rules/` 目录下的 Markdown 文件，为特定场景提供指令：

```
.claude/
└── rules/
    ├── pr-review.md    # PR 审查规则
    ├── test-guide.md   # 测试写法规范
    └── api-contract.md # API 设计规范
```

```markdown
# .claude/rules/test-guide.md
## 测试规范

1. 所有公开方法必须有单元测试
2. 使用 jest + supertest 进行 API 测试
3. 测试文件放在 `tests/__tests__/` 目录，与源码同名的 `.test.ts`
4. Mock 外部依赖（数据库、第三方 API）
5. 每个测试用例只验证一个行为
```

### 项目级指令（Global Instructions）

在 Claude Code 的配置中，可以设置全局系统级指令，让每次对话都带上项目上下文。配合 claude.md 使用效果更佳。

---

## 实战案例：完整的 claude.md

以下是一个真实可落地的 Node.js API 服务 claude.md：

```markdown
# UserService API

一个基于 Node.js + Express 的用户认证微服务，提供用户注册、登录、JWT Token 管理、OAuth2 第三方登录功能。服务面向移动端和 Web 端 API 消费。

## 技术栈
- **运行时**: Node.js 18 LTS
- **框架**: Express.js 4.x
- **ORM**: Prisma 5.x + PostgreSQL 15
- **缓存**: Redis 7.x（Token 黑名单 + 验证码）
- **认证**: JWT（Access Token 30min / Refresh Token 7d）
- **队列**: BullMQ（邮件发送、异步任务）
- **监控**: Sentry + Datadog APM
- **部署**: Docker + AWS ECS Fargate

## 架构
```
├── src/
│   ├── controllers/    # 路由入口，参数校验，调用 service
│   ├── services/       # 业务逻辑，事务管理
│   ├── repositories/   # 数据库操作（Prisma 封装）
│   ├── models/         # TypeScript 类型 + Prisma schema
│   ├── middleware/
│   │   ├── auth.ts         # JWT 验证
│   │   ├── rateLimiter.ts  # 限流（Redis）
│   │   └── errorHandler.ts # 全局错误处理
│   ├── utils/          # 工具函数（jwt、bcrypt、validator）
│   ├── queues/         # BullMQ 任务定义
│   └── config/         # 环境变量加载（zod schema 校验）
├── prisma/
│   ├── schema.prisma
│   └── seed.ts         # 测试数据种子
├── tests/
│   ├── unit/           # 单元测试（jest）
│   └── integration/    # API 集成测试（supertest）
└── scripts/
    ├── deploy.sh       # ECS 部署脚本
    └── migrate.sh      # 数据库迁移脚本
```

## 代码规范
- **TypeScript**: 严格模式（strict: true），禁止 `any`
- **命名**: 
  - 变量/函数/方法: camelCase
  - 类/接口/类型: PascalCase  
  - 文件名/目录名: kebab-case
  - 数据库字段: snake_case
- **API 响应**: 统一格式 `{ success: boolean, data: T | null, message: string }`
- **HTTP 状态码**: 2xx 成功 / 4xx 客户端错误 / 5xx 服务端错误
- **错误处理**: async 函数必须 try-catch，错误统一抛到 middleware 处理
- **提交规范**: Conventional Commits（feat/fix/docs/refactor/test/chore）

## 常用命令
| 命令 | 说明 |
|------|------|
| `npm run dev` | 本地开发（热重载，端口 3000）|
| `npm run build` | 编译 TypeScript |
| `npm run test` | 运行所有测试 |
| `npm run test:unit` | 仅运行单元测试 |
| `npm run lint` | ESLint + Prettier 检查 |
| `npm run lint:fix` | 自动修复格式问题 |
| `npx prisma studio` | 打开 Prisma 数据库可视化 |
| `npm run migrate:dev` | 本地开发数据库迁移 |
| `docker-compose up -d` | 启动本地 PostgreSQL + Redis |
| `./scripts/deploy.sh staging` | 部署到 staging 环境 |

## 数据库模型
- **User**: id, email, password(hash), phone, avatar, status, createdAt, updatedAt
- **RefreshToken**: id, userId, token, expiresAt, revokedAt
- **OAuthAccount**: id, userId, provider(Github/Google), providerUserId

## 环境变量
> 所有变量必须通过 `.env` 文件配置，`.env` 不提交到 Git（已加入 .gitignore）

| 变量 | 说明 | 示例 |
|------|------|------|
| `DATABASE_URL` | PostgreSQL 连接串 | `postgresql://user:pass@host:5432/userservice` |
| `REDIS_URL` | Redis 连接串 | `redis://:pass@localhost:6379` |
| `JWT_SECRET` | Access Token 签名密钥 | 32 位以上随机字符串 |
| `JWT_REFRESH_SECRET` | Refresh Token 签名密钥 | 32 位以上随机字符串 |
| `SENTRY_DSN` | Sentry 监控地址 | `https://...@sentry.io/...` |
| `DATADOG_API_KEY` | Datadog APM Key | |
| `OAUTH_GITHUB_CLIENT_ID` | GitHub OAuth App ID | |
| `OAUTH_GITHUB_CLIENT_SECRET` | GitHub OAuth App Secret | |

## 注意事项
- 生产环境禁止开启 `DEBUG` 日志
- 所有用户输入必须经过 `validator` 库校验
- 密码使用 `bcrypt` 加密（cost factor = 12）
- Refresh Token 仅能使用一次（使用后作废，更新为新 Token）
- API 限流：未登录 100次/分钟，已登录 1000次/分钟
```

---

## 常见错误

### ❌ 写得太多——变成啰嗦的 README

```markdown
# ❌ 错误示范
本项目是一个 Node.js Express 项目，始于 2023 年 3 月，作者是张三...
（堆砌了大量项目历史、README 式的介绍，和 Claude Code 的任务无关）
```

**问题**：Claude Code 不会一字不差地读完所有内容，过多背景信息会淹没关键上下文。

**✅ 正确做法**：信息精炼，只保留与"写代码"直接相关的知识。

---

### ❌ 写得太少——缺乏关键上下文

```markdown
# ❌ 错误示范
项目是一个 API 服务。
```

**问题**：Claude Code 不知道你用什么框架、数据库、代码规范，很可能会写出风格不一致的代码。

**✅ 正确做法**：至少包含技术栈、目录结构、常用命令、环境变量（哪怕一行表格）。

---

### ❌ 信息过时——不同步更新

随着项目演进，claude.md 里的命令、架构、依赖如果落后于实际状态，反而会误导 Claude Code。

**✅ 正确做法**：
- 项目有重大变更时，同步更新 claude.md
- 可以在 PR 阶段加入检查项："本次修改是否需要更新 claude.md"
- 或在代码里加注释指向最新文档

---

## 写作技巧

### 1. 重点突出：用表格和列表

用表格代替大段描述，让关键信息一目了然：

```markdown
## ❌ 低效
本项目使用的技术栈包括 Node.js 作为运行时，Express.js 作为 Web 框架，Prisma 作为 ORM...

## ✅ 高效
## 技术栈
- 运行时: Node.js 18+
- 框架: Express.js 4.x
- ORM: Prisma 5.x + PostgreSQL 15
```

### 2. 示例具体：不要泛泛而谈

```markdown
## ❌ 空泛
API 要返回 JSON 格式。

## ✅ 具体
## API 响应格式
所有响应统一为 `{ success: boolean, data: T | null, message: string }`
示例：
{ "success": true, "data": { "userId": 1, "email": "a@b.com" }, "message": "" }
错误：{ "success": false, "data": null, "message": "Invalid token" }
```

### 3. 持续更新：把更新当作开发流程的一部分

- 新增功能 → 更新架构图和命令
- 换技术栈 → 更新技术栈和代码规范
- 新增环境变量 → 同步更新依赖说明
- 重构目录结构 → 同步更新架构部分

---

## 小结

```
✅ claude.md = 项目的"新手必读"
✅ 六个核心模块：概述 → 架构 → 规范 → 命令 → 依赖
✅ 高级用法：多环境、自定义规则、全局指令
✅ 三个常见错误：太多 / 太少 / 过时
✅ 三个写作技巧：表格化 / 具体化 / 持续更新
```

> 下一步：了解 Claude Code 的其他高级配置 →