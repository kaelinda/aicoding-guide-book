# AGENTS.md 示例集合

> 不同项目类型的 AGENTS.md 配置模板

## 📱 iOS SwiftUI 项目

```markdown
# MyiOSApp - AGENTS.md

## 项目概述
MyiOSApp 是一个 [功能描述] 的 iOS 应用。

## 技术栈
- Swift 5.9
- SwiftUI
- SwiftData（数据持久化）
- Combine（响应式编程）
- MVVM + Clean Architecture

## 架构设计

```
┌─────────────────┐
│   Presentation  │  Views + ViewModels
├─────────────────┤
│     Domain      │  UseCases + Entities
├─────────────────┤
│      Data       │  Repositories + DataSources
└─────────────────┘
```

## 编码规范

### 命名规范
- 类名：PascalCase（如 `UserViewModel`）
- 方法名：camelCase（如 `fetchUsers()`）
- 变量名：camelCase（如 `currentUser`）

### SwiftUI 规范
- 使用 `@StateObject` 创建 ViewModel
- 使用 `@Observable` 宏（iOS 17+）
- 视图名称以 `View` 结尾
- ViewModel 名称以 `ViewModel` 结尾

### 文档注释
所有 public 方法必须添加文档注释：

```swift
/// 获取用户列表
///
/// - Parameters:
///   - page: 页码，从 1 开始
/// - Returns: 用户列表
func fetchUsers(page: Int) async throws -> [User]
```

## 项目结构

```
MyiOSApp/
├── App/
│   ├── MyiOSAppApp.swift
│   └── AppDelegate.swift
├── Presentation/
│   ├── Views/
│   ├── ViewModels/
│   └── Components/
├── Domain/
│   ├── Entities/
│   └── UseCases/
├── Data/
│   ├── Repositories/
│   └── DataSources/
└── Resources/
    └── Assets.xcassets
```

## 常用命令

### 构建
```bash
xcodebuild -scheme MyiOSApp -configuration Debug
```

### 测试
```bash
xcodebuild test -scheme MyiOSApp
```

### SwiftLint
```bash
swiftlint --strict
```

## 禁止事项

### ❌ 绝对禁止
- 使用强制解包 `!`
- 在 View 中直接调用网络请求
- 忽略编译警告
- 提交包含 `print()` 的调试代码

### ⚠️ 需要确认
- 添加新的第三方依赖
- 修改公共 API
- 创建新的 Target

## 测试要求

- 单元测试覆盖率：≥ 80%
- 关键功能必须有 UI 测试
- 每个 PR 必须通过所有测试
```

---

## 🌐 Node.js 后端项目

```markdown
# MyAPI - AGENTS.md

## 项目概述
MyAPI 是一个 [功能描述] 的 Node.js 后端服务。

## 技术栈
- Node.js 20 LTS
- TypeScript
- Express / Fastify
- PostgreSQL
- Redis
- Prisma（ORM）

## 架构设计

```
┌─────────────────┐
│      Routes     │  路由层
├─────────────────┤
│   Controllers   │  控制器层
├─────────────────┤
│    Services     │  服务层
├─────────────────┤
│   Repositories  │  数据访问层
└─────────────────┘
```

## 编码规范

### TypeScript 规范
- 使用严格模式：`strict: true`
- 所有变量和函数都有类型注解
- 避免使用 `any`，使用 `unknown` 替代
- 使用接口定义数据结构

### 文件命名
- 文件名：kebab-case（如 `user-service.ts`）
- 类名：PascalCase（如 `UserService`）
- 接口名：PascalCase，以 `I` 开头（如 `IUserRepository`）

### 错误处理
- 所有 async 函数使用 try-catch
- 使用自定义错误类
- 统一错误响应格式

## 项目结构

```
my-api/
├── src/
│   ├── routes/
│   ├── controllers/
│   ├── services/
│   ├── repositories/
│   ├── models/
│   ├── middleware/
│   ├── utils/
│   └── config/
├── tests/
├── prisma/
│   └── schema.prisma
├── package.json
└── tsconfig.json
```

## 常用命令

### 开发
```bash
npm run dev
```

### 构建
```bash
npm run build
```

### 测试
```bash
npm test
npm run test:coverage
```

### Lint
```bash
npm run lint
npm run lint:fix
```

## 禁止事项

### ❌ 绝对禁止
- 在代码中硬编码密钥
- 使用 `any` 类型
- 提交 .env 文件
- 忽略 TypeScript 错误

## 测试要求

- 单元测试覆盖率：≥ 90%
- 集成测试覆盖核心流程
- E2E 测试覆盖主要场景
```

---

## 🎨 React 前端项目

```markdown
# MyWebApp - AGENTS.md

## 项目概述
MyWebApp 是一个 [功能描述] 的 React 前端应用。

## 技术栈
- React 18
- TypeScript
- Vite
- Tailwind CSS
- Zustand / Redux（状态管理）
- React Query（数据获取）

## 编码规范

### 组件规范
- 使用函数组件和 Hooks
- 组件文件名：PascalCase（如 `UserList.tsx`）
- 组件导出使用 `export default`
- Props 使用接口定义

### 样式规范
- 使用 Tailwind CSS
- 避免内联样式
- 复用样式提取为组件

### 文件结构
```
ComponentName/
├── index.tsx
├── ComponentName.tsx
├── ComponentName.test.tsx
├── ComponentName.module.css（可选）
└── types.ts
```

## 项目结构

```
my-web-app/
├── src/
│   ├── components/
│   ├── pages/
│   ├── hooks/
│   ├── stores/
│   ├── services/
│   ├── utils/
│   ├── types/
│   └── assets/
├── public/
├── index.html
├── vite.config.ts
└── tailwind.config.js
```

## 常用命令

### 开发
```bash
npm run dev
```

### 构建
```bash
npm run build
```

### 测试
```bash
npm test
npm run test:ui
```

## 禁止事项

### ❌ 绝对禁止
- 直接修改 state
- 在 useEffect 中直接使用 async
- 提交 console.log
- 使用 any 类型

## 性能要求

- 首屏加载：< 2s
- Lighthouse 分数：> 90
- 包体积：< 500KB
```

---

## 📦 Monorepo 项目

```markdown
# MyMonorepo - AGENTS.md

## 项目概述
Monorepo 包含多个相关项目。

## 技术栈
- pnpm workspace
- Turborepo
- TypeScript

## 项目结构

```
my-monorepo/
├── apps/
│   ├── web/
│   ├── api/
│   └── mobile/
├── packages/
│   ├── ui/
│   ├── utils/
│   └── config/
├── turbo.json
└── pnpm-workspace.yaml
```

## 编码规范

### 共享包规范
- packages/ 中的包必须可独立发布
- 导出清晰的 API
- 包含完整文档

### 依赖管理
- 使用 workspace 协议
- 版本统一管理
- 定期更新依赖

## 常用命令

### 安装依赖
```bash
pnpm install
```

### 构建
```bash
turbo run build
```

### 测试
```bash
turbo run test
```

## 禁止事项

### ❌ 绝对禁止
- 循环依赖
- 不同版本的相同依赖
- 提交 node_modules
```

---

## 🔧 使用建议

### 1. 选择合适的模板

根据项目类型选择对应的模板，然后根据实际情况修改。

### 2. 团队共识

AGENTS.md 应该是团队的共识：
- 召开团队会议讨论
- Code Review 严格执行
- 定期回顾和更新

### 3. 持续优化

发现 AI 生成不符合规范的代码时：
1. 识别问题
2. 更新 AGENTS.md
3. 重新生成代码

---

**这些模板已保存到项目中，可直接使用或根据需要修改。**
