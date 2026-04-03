# 04-Rules 与 Skill

> AGENTS.md - 让 AI 理解你的项目规范

## 🤔 什么是 AGENTS.md

AGENTS.md 是一个 **Markdown 配置文件**，用于指导 AI 编程助手理解你的项目。

### 为什么需要 AGENTS.md

```
没有 AGENTS.md：

你：创建一个用户视图
AI：[生成代码]
你：不对，我们要用 MVVM 架构
AI：[重新生成]
你：不对，我们用 SwiftUI 而不是 UIKit
AI：[重新生成]
你：不对，我们的命名规范是...

→ 每次都要重复说明，效率低下
```

```
有 AGENTS.md：

你：创建一个用户视图
AI：[读取 AGENTS.md]
    [理解项目规范]
    [一次性生成符合规范的代码]

→ 一次配置，永久生效
```

## 📖 AGENTS.md 核心内容

### 基础结构

```markdown
# 项目名称 - AGENTS.md

## 项目概述
[项目简介、目标、核心功能]

## 技术栈
[使用的语言、框架、工具]

## 架构设计
[项目架构、设计模式]

## 编码规范
[命名规范、代码风格、最佳实践]

## 项目结构
[目录结构、文件组织]

## 常用命令
[构建、测试、部署命令]

## 禁止事项
[不允许的操作、安全边界]
```

### 完整示例（iOS 项目）

```markdown
# ShoppingApp - AGENTS.md

## 项目概述
ShoppingApp 是一个电商购物 App，支持商品浏览、购物车、订单管理等功能。

## 技术栈
- Swift 5.9
- SwiftUI（UI 框架）
- Combine（响应式编程）
- SwiftData（数据持久化）
- Alamofire（网络请求）

## 架构设计
采用 MVVM + Clean Architecture：

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
- 常量名：PascalCase 或 camelCase（如 `defaultTimeout`）
- 枚举：PascalCase（如 `UserStatus`）

### 文件组织
```swift
// MARK: - Properties
private let property: Type

// MARK: - Lifecycle
override func viewDidLoad() {
    super.viewDidLoad()
}

// MARK: - Public Methods
func publicMethod() {}

// MARK: - Private Methods
private func privateMethod() {}
```

### SwiftUI 规范
- 使用 `@StateObject` 创建 ViewModel
- 使用 `@ObservedObject` 传递 ViewModel
- 使用 `@EnvironmentObject` 共享数据
- 视图名称以 `View` 结尾
- ViewModel 名称以 `ViewModel` 结尾

### 错误处理
- 使用 `Result<Success, Error>` 类型
- 定义自定义错误枚举
- 所有网络请求需要错误处理

### 文档注释
所有 public 方法必须添加文档注释：

```swift
/// 获取用户列表
///
/// - Parameters:
///   - page: 页码，从 1 开始
///   - pageSize: 每页数量，默认 20
/// - Returns: 用户列表
/// - Throws: NetworkError
func fetchUsers(page: Int, pageSize: Int = 20) async throws -> [User]
```

## 项目结构

```
ShoppingApp/
├── App/
│   ├── ShoppingAppApp.swift
│   └── AppDelegate.swift
├── Presentation/
│   ├── Views/
│   │   ├── User/
│   │   │   ├── UserListView.swift
│   │   │   └── UserDetailView.swift
│   │   └── Product/
│   ├── ViewModels/
│   │   ├── UserListViewModel.swift
│   │   └── ProductListViewModel.swift
│   └── Components/
│       └── LoadingView.swift
├── Domain/
│   ├── Entities/
│   │   ├── User.swift
│   │   └── Product.swift
│   └── UseCases/
│       ├── FetchUsersUseCase.swift
│       └── FetchProductsUseCase.swift
├── Data/
│   ├── Repositories/
│   │   ├── UserRepository.swift
│   │   └── ProductRepository.swift
│   └── DataSources/
│       ├── Remote/
│       │   └── API/
│       └── Local/
│           └── SwiftData/
├── Infrastructure/
│   ├── Network/
│   │   └── NetworkManager.swift
│   └── Extensions/
│       └── String+Extensions.swift
└── Resources/
    ├── Assets.xcassets
    └── Localizable.strings
```

## 常用命令

### 构建
```bash
xcodebuild -scheme ShoppingApp -configuration Debug
```

### 测试
```bash
xcodebuild test -scheme ShoppingApp -destination 'platform=iOS Simulator,name=iPhone 15'
```

### 代码格式化
```bash
swiftformat .
```

### Lint 检查
```bash
swiftlint
```

## 禁止事项

### ❌ 绝对禁止
- 使用强制解包 `!`
- 在 View 中直接调用网络请求
- 忽略编译警告
- 提交包含 `print()` 的调试代码
- 使用魔法数字（硬编码）

### ⚠️ 需要确认
- 添加新的第三方依赖
- 修改公共 API
- 创建新的 Target
- 修改 Build Settings

## 性能要求

- 列表滚动帧率：≥ 60fps
- 页面加载时间：≤ 1s
- 内存占用：≤ 100MB（正常使用）
- 启动时间：≤ 2s

## 安全要求

- 所有网络请求使用 HTTPS
- 敏感数据加密存储
- 不在日志中输出敏感信息
- Token 定期刷新

## 测试要求

- 单元测试覆盖率：≥ 80%
- 关键功能必须有 UI 测试
- 每个 PR 必须通过所有测试

## 参考资料

- [Swift API 设计指南](https://swift.org/documentation/api-design-guidelines/)
- [SwiftUI 官方文档](https://developer.apple.com/documentation/swiftui/)
- [SwiftLint 规则](https://realm.github.io/SwiftLint/rule-directory.html)
```

## 🛠 不同工具的配置文件

### Claude Code

```
CLAUDE.md 或 AGENTS.md
位置：项目根目录
优先级：AGENTS.md > CLAUDE.md
```

### Cursor

```
.cursorrules
位置：项目根目录
格式：Markdown 或纯文本
```

### Codex CLI

```
AGENTS.md
位置：项目根目录
支持：完整 Markdown 格式
```

### OpenClaw

```
AGENTS.md
位置：工作空间根目录
支持：完整 Markdown 格式 + 自定义扩展
```

## 🎯 最佳实践

### 实践 1：分层配置

```
项目根目录/
├── AGENTS.md           # 全局配置
├── iOS/
│   └── AGENTS.md       # iOS 项目特定配置
└── Android/
    └── AGENTS.md       # Android 项目特定配置
```

### 实践 2：版本控制

```bash
# AGENTS.md 应该提交到 Git
git add AGENTS.md
git commit -m "docs: 添加 AI 编程助手配置"
```

### 实践 3：持续更新

```
发现 AI 生成不符合规范的代码时：
1. 识别问题
2. 更新 AGENTS.md
3. 重新生成代码
```

### 实践 4：团队协作

```
AGENTS.md 是团队的共识：
- Code Review 时检查是否符合规范
- 新成员通过 AGENTS.md 快速了解项目
- 规范变更时同步更新 AGENTS.md
```

## 💡 高级技巧

### 技巧 1：提供示例代码

```markdown
## SwiftUI 视图模板

使用以下模板创建新视图：

```swift
struct UserListView: View {
    // MARK: - Properties
    @StateObject private var viewModel: UserListViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            content
                .navigationTitle("用户列表")
                .task {
                    await viewModel.fetchUsers()
                }
        }
    }
    
    // MARK: - Content
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            LoadingView()
        } else if viewModel.users.isEmpty {
            EmptyView(message: "暂无用户")
        } else {
            userListView
        }
    }
    
    // MARK: - Subviews
    private var userListView: some View {
        List(viewModel.users) { user in
            UserRowView(user: user)
        }
    }
}
```
```

### 技巧 2：提供反例

```markdown
## 常见错误示例

❌ 错误写法：
```swift
if let user = user {
    if let name = user.name {
        if let email = user.email {
            // 嵌套地狱
        }
    }
}
```

✅ 正确写法：
```swift
guard let user = user,
      let name = user.name,
      let email = user.email else {
    return
}
// 扁平化处理
```
```

### 技巧 3：定义代码片段

```markdown
## 代码片段

### 网络请求模板
```swift
func fetchData<T: Codable>(endpoint: String) async throws -> T {
    let url = baseURL.appendingPathComponent(endpoint)
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }
    
    return try JSONDecoder().decode(T.self, from: data)
}
```
```

### 技巧 4：配置工具链

```markdown
## 开发工具链

### 必备工具
- Xcode 15.0+
- SwiftLint
- SwiftFormat
- CocoaPods / Swift Package Manager

### Git Hooks
pre-commit:
- SwiftLint 检查
- SwiftFormat 格式化
- 单元测试运行

### CI/CD
GitHub Actions:
- 自动运行测试
- 自动构建
- 自动部署
```

## 📊 效果对比

| 场景 | 无 AGENTS.md | 有 AGENTS.md |
|------|--------------|--------------|
| 首次生成正确率 | 40% | 85% |
| 需要修改次数 | 3-5 次 | 1-2 次 |
| 符合规范概率 | 30% | 90% |
| 团队一致性 | 低 | 高 |

## ⚠️ 常见问题

### 问题 1：AI 没有遵循 AGENTS.md

```
解决：
1. 检查文件位置是否正确
2. 检查文件名是否正确（AGENTS.md）
3. 重启 AI 工具
4. 在 Prompt 中明确引用：
   "根据 AGENTS.md 中的规范，创建..."
```

### 问题 2：团队规范不一致

```
解决：
1. 召开团队会议，达成共识
2. 将共识写入 AGENTS.md
3. Code Review 严格执行
4. 定期回顾和更新
```

### 问题 3：配置文件太大

```
解决：
1. 拆分成多个文件（按模块）
2. 只保留最重要的规范
3. 使用链接引用详细文档
```

## ✅ 小结

- AGENTS.md 是项目的"说明书"
- 包含：技术栈、架构、规范、结构、命令
- 不同工具有不同的配置文件名
- 持续更新，团队共建
- 提升代码质量，减少沟通成本

## 🔗 相关资源

### 官方文档
- [AGENTS.md Best Practices](https://agentsmd.io/) ⭐⭐⭐⭐⭐
- [Claude Code 配置文档](https://docs.anthropic.com/claude-code/agents-md) ⭐⭐⭐⭐⭐

### GitHub 示例
- [AGENTS.md 示例集合](https://github.com/topics/agents-md) ⭐⭐⭐⭐

---

**下一步：** [Claude Code 实战 →](../../实战篇/01-ClaudeCode实战/README.md)
