# 02-Cursor 实战

> 最强 AI IDE，iOS 开发者的效率神器

## 🎯 Cursor 是什么

Cursor 是一个基于 VS Code 的 AI 增强编辑器，专为 AI 辅助编程设计。

**核心优势：**
- 🎨 熟悉的 VS Code 体验，零学习成本
- 🤖 内置 Claude/GPT-4，强大的 AI 能力
- 📝 智能代码补全，预测你的下一步
- 💬 自然语言编程，用中文描述需求
- 🔍 智能代码搜索，快速定位问题

**对比其他工具：**

| 特性 | Cursor | VS Code + Copilot | Xcode |
|------|--------|-------------------|-------|
| AI 能力 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| iOS 支持 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 学习曲线 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| 价格 | $20/月 | $10/月 | 免费 |

## 📦 安装 Cursor

### 下载安装

1. **访问官网**
   ```
   https://cursor.sh
   ```

2. **下载 macOS 版本**
   - 点击 "Download for Mac"
   - 下载 .dmg 文件

3. **安装**
   - 双击打开 .dmg
   - 拖动到 Applications
   - 打开 Cursor

### 首次启动配置

1. **登录账号**
   - 选择 "Sign in with Google" 或 "Sign in with GitHub"
   - 完成授权

2. **选择主题**
   - 深色主题（推荐护眼）
   - 浅色主题

3. **导入 VS Code 配置**（如果有）
   - Cursor 会自动检测
   - 一键导入扩展和设置

## 🚀 核心功能

### 1. AI 对话（Chat）

**快捷键：** `Cmd + L`

```
使用场景：
- 询问代码问题
- 生成新代码
- 解释复杂逻辑
- 代码审查

示例：
你：创建一个 SwiftUI 视图，显示用户列表，每个单元格显示头像和用户名

Cursor：
[生成代码]
struct UserListView: View {
    let users: [User]

    var body: some View {
        List(users) { user in
            HStack {
                AsyncImage(url: user.avatarURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())

                Text(user.name)
                    .font(.headline)
            }
        }
    }
}
```

### 2. 内联编辑（Inline Edit）

**快捷键：** `Cmd + K`

```
使用场景：
- 快速修改代码
- 重构函数
- 添加注释
- 优化性能

示例：
选中代码 → Cmd + K → 输入指令

原代码：
func calculateTotal(items: [Item]) -> Double {
    var total = 0.0
    for item in items {
        total += item.price
    }
    return total
}

你：用 reduce 重写

Cursor：
func calculateTotal(items: [Item]) -> Double {
    items.reduce(0) { $0 + $1.price }
}
```

### 3. 代码补全（Tab）

```
使用场景：
- 自动完成代码
- 预测下一步操作
- 智能建议

工作原理：
你输入 → AI 分析上下文 → 预测你的意图 → 自动补全

示例：
你输入：func validate
AI 补全：Email(_ email: String) -> Bool { ... }

按 Tab 接受建议，按 Esc 拒绝
```

### 4. 代码库搜索（Cmd + Shift + L）

```
使用场景：
- 全局搜索代码
- 理解项目结构
- 查找相关实现

示例：
你：哪里使用了 User 模型？

Cursor：
[搜索整个代码库]
找到 15 处使用：
1. UserListView.swift:12 - 用户列表视图
2. UserViewModel.swift:8 - 用户视图模型
3. UserService.swift:25 - 用户服务
...
```

## 💡 iOS 开发实战

### 场景 1：创建 SwiftUI 视图

```
步骤：
1. Cmd + N 创建新文件
2. Cmd + L 打开 AI 对话
3. 描述你的需求

示例对话：
你：创建一个商品详情页，包含：
    - 商品图片（支持轮播）
    - 商品标题和价格
    - 购买按钮
    - 收藏按钮
    使用 SwiftUI

Cursor：
[分析需求]
[生成完整代码]
[创建新文件]

商品详情视图已创建！
文件：ProductDetailView.swift
包含：轮播图、标题价格、操作按钮
```

### 场景 2：重构代码

```
原代码（命令式）：
var tableView: UITableView!
var items: [Item] = []

func viewDidLoad() {
    tableView.dataSource = self
    tableView.delegate = self
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
}

你（Cmd + K）：重构成 SwiftUI

Cursor：
struct ItemListView: View {
    let items: [Item]

    var body: some View {
        List(items) { item in
            ItemRowView(item: item)
        }
    }
}
```

### 场景 3：修复 Bug

```
错误信息：
❌ Type 'UserView' does not conform to protocol 'View'

你：帮我修复这个错误

Cursor：
[分析错误原因]
[定位问题代码]
[提供修复方案]

问题：缺少 body 属性
修复：添加 var body: some View { ... }

是否应用修复？ [Apply] [Skip]
```

### 场景 4：添加单元测试

```
你：为 UserViewModel 添加单元测试

Cursor：
[分析 UserViewModel]
[识别关键方法]
[生成测试用例]

已创建：UserViewModelTests.swift
包含测试：
- testInitialization
- testUserValidation
- testFetchUsers
- testUpdateUser

运行测试：Cmd + U
```

## 🎯 高级技巧

### 1. 使用 .cursorrules 文件

在项目根目录创建 `.cursorrules`：

```markdown
# Cursor 项目规则

## 技术栈
- Swift 5.9
- SwiftUI
- Combine
- MVVM 架构

## 编码规范
- 使用 4 空格缩进
- 函数命名使用 camelCase
- 添加 MARK 注释分隔代码块
- 所有 public 方法添加文档注释

## 项目结构
- Views/ - SwiftUI 视图
- ViewModels/ - 视图模型
- Models/ - 数据模型
- Services/ - 服务层

## 禁止事项
- 不要使用强制解包 !
- 不要在 View 中直接调用网络请求
- 不要忽略编译警告
```

Cursor 会自动遵循这些规则。

### 2. 多文件编辑

```
你：把所有的颜色硬编码改成使用设计系统

Cursor：
[扫描所有文件]
找到 23 处硬编码颜色

开始批量修改...
- ContentView.swift:3 处
- ProfileView.swift:5 处
- SettingsView.swift:2 处
...

✅ 已修改 23 处
已替换为：DesignSystem.Colors.*
```

### 3. 代码审查

```
你：审查这个文件的代码质量

Cursor：
审查结果：

✅ 优点：
- 结构清晰，遵循 MVVM
- 命名规范
- 有适当的注释

⚠️ 建议改进：
1. 第 45 行：使用 guard let 替代 if let
2. 第 78 行：考虑提取为独立方法
3. 第 102 行：添加错误处理

❌ 问题：
- 第 67 行：存在内存泄漏风险
  修复建议：使用 [weak self]

是否自动修复？ [Fix All] [Fix One by One]
```

### 4. 文档生成

```
你选中的代码：
func fetchUser(id: String) async throws -> User

你：生成文档注释

Cursor：
/// 从服务器获取用户信息
///
/// - Parameter id: 用户唯一标识符
/// - Returns: 用户对象
/// - Throws: NetworkError.networkUnavailable - 网络不可用
///           NetworkError.userNotFound - 用户不存在
///
/// 示例用法：
/// ```swift
/// do {
///     let user = try await fetchUser(id: "123")
///     print(user.name)
/// } catch {
///     print(error.localizedDescription)
/// }
/// ```
func fetchUser(id: String) async throws -> User {
    // ...
}
```

## 🔧 配置优化

### 推荐设置

打开设置：`Cmd + ,`

```json
{
  // AI 模型选择
  "cursor.aiModel": "claude-3.5-sonnet",

  // 自动补全
  "cursor.tabAutocomplete": true,
  "cursor.autocompleteDelay": 100,

  // 字体设置
  "editor.fontFamily": "SF Mono, Menlo, Monaco",
  "editor.fontSize": 14,

  // Swift 专用
  "[swift]": {
    "editor.formatOnSave": true,
    "editor.tabSize": 4
  },

  // 文件排除
  "files.exclude": {
    "**/.git": true,
    "**/DerivedData": true,
    "**/Pods": true
  }
}
```

### 推荐扩展

```
1. Swift (Apple) - Swift 语言支持
2. SwiftUI Preview - SwiftUI 预览
3. GitLens - Git 增强
4. Code Spell Checker - 拼写检查
5. SVG Preview - SVG 预览
```

## ⚠️ 常见问题

### 问题 1：AI 响应很慢

```
可能原因：
1. 网络问题
2. 服务器负载高

解决：
1. 检查网络连接
2. 切换到其他模型（GPT-4 → Claude）
3. 简化提示词，减少上下文
```

### 问题 2：代码补全不准确

```
原因：上下文信息不足

解决：
1. 提供 .cursorrules 文件
2. 在提示词中明确技术栈
3. 使用更具体的描述
```

### 问题 3：无法打开 Xcode 项目

```
解决：
Cursor 本身不能运行 iOS 项目，但可以：
1. 用 Cursor 编写代码
2. 用 Xcode 运行和调试
3. 使用 xcodebuild 命令行工具
```

## 📊 与 Claude Code 对比

| 维度 | Cursor | Claude Code |
|------|--------|-------------|
| 环境 | IDE（可视化） | 终端（命令行） |
| 学习曲线 | 低 | 中 |
| 自主性 | 中（需要手动确认） | 高（可自动执行） |
| 文件管理 | 可视化 | 命令行 |
| 代码审查 | 内置 | 需要命令 |
| iOS 支持 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 适合人群 | 新手、视觉型 | 进阶、终端用户 |

**推荐策略：**
- **日常开发** → Cursor（编码、调试）
- **批量操作** → Claude Code（重构、批量修改）
- **自动化任务** → Claude Code（CI/CD、脚本）

## ✅ 小结

- Cursor 是最易上手的 AI IDE
- 支持 SwiftUI、Swift 开发
- 三大核心功能：Chat、Inline Edit、Tab 补全
- .cursorrules 让 AI 遵守项目规范
- 与 Claude Code 配合使用效果更佳

## 🔗 相关资源

- [Cursor 官网](https://cursor.sh)
- [Cursor 文档](https://cursor.com/docs)
- [Cursor 社区](https://forum.cursor.sh/)
- [Cursor Twitter](https://twitter.com/cursor_ai)

---

**下一步：** [Codex 实战 →](../03-Codex实战/README.md)
