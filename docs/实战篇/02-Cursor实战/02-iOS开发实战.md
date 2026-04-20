# 02-Cursor iOS 开发实战

> 四个真实 iOS 场景：创建 SwiftUI 视图 / 重构旧 UIKit / 修 bug / 生成单测。

---

## 场景 1：创建 SwiftUI 视图

### 步骤

1. `Cmd + N` 创建新文件
2. `Cmd + L` 打开 AI 对话
3. 描述你的需求

### 示例对话

```text
你：创建一个商品详情页，包含：
    - 商品图片（支持轮播，ScrollView + TabView）
    - 商品标题、价格（大号数字）
    - 购买按钮（主色）
    - 收藏按钮（次要按钮）
    iOS 17+，SwiftUI，使用 @Observable。
    我会把你生成的代码保存成 ProductDetailView.swift。

Cursor：
[分析需求] [生成代码]

已生成 ProductDetailView.swift：
- 顶部 TabView 轮播（点指示器）
- 中间 VStack 标题和价格
- 底部 HStack 两个按钮
- 用 @State private var store = ProductDetailStore() 管理
- 包含 #Preview 和 PreviewProvider（向前兼容）
```

### 关键技巧

- **先描述布局再描述数据**：AI 对布局需求理解比对业务数据强
- **强制 iOS 版本**：不写就会出现 `NavigationView`、`Combine` 这种老写法
- **强制数据层写法**：@Observable / ObservableObject / TCA 不指定会猜错

---

## 场景 2：把 UIKit 代码重构成 SwiftUI

### 原始代码（命令式）

```swift
var tableView: UITableView!
var items: [Item] = []

override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
}

func tableView(_ tableView: UITableView,
               numberOfRowsInSection section: Int) -> Int {
    items.count
}
// ... cellForRowAt 等等
```

### 操作

选中整段代码 → `Cmd + K` → 输入：

```text
重构成 SwiftUI。iOS 17+，用 @Observable 管理 items，
保留现有的 didSelectRow 行为（pop 到详情页）。
给我新文件的完整代码，我替换掉这个 UIViewController。
```

### Cursor 产出

```swift
@Observable class ItemListStore {
    var items: [Item] = []
}

struct ItemListView: View {
    @State private var store = ItemListStore()
    var body: some View {
        NavigationStack {
            List(store.items) { item in
                NavigationLink(value: item) {
                    ItemRowView(item: item)
                }
            }
            .navigationDestination(for: Item.self) { item in
                ItemDetailView(item: item)
            }
        }
    }
}
```

### 踩坑点

- AI 很爱给你加 `Combine` 和 `Publisher` —— 2026 年的 SwiftUI 一般不需要
- `didSelectRow` 对应的导航要改写成 `NavigationLink` + `navigationDestination`，Cursor 容易漏
- **review 要点**：是不是真把"行为"迁移了，不只是"样子"

---

## 场景 3：修 Bug

### 错误信息

```
❌ Type 'UserView' does not conform to protocol 'View'
```

### 操作

```text
你（Cmd + L）：帮我修这个错误。
<贴 UserView.swift 完整代码>
```

### Cursor 产出

```text
[分析] 找到问题：缺少 body 属性实现
修复建议：添加 var body: some View { ... }

[给出 patch]
是否应用修复？ [Apply] [Skip]
```

### 踩坑点

SwiftUI 的典型 "does not conform to View" 错误往往是：

- 缺 `body`（最常见）
- `body` 里混了非 View 的返回值（比如 `if` 分支里混了 `print`）
- 模板类型不一致导致 `opaque return type` 失败

让 Cursor 帮你修，但**review 时要看它改了什么**，很多时候它只是"让编译过"，没解决真实的逻辑问题。

---

## 场景 4：生成单元测试

### 操作

```text
你：为 UserViewModel 添加单元测试。
要求：
- iOS 17+，用 Swift Testing（@Test / #expect），不是 XCTest
- 依赖用 protocol + fake，不用 mock 框架
- 至少覆盖：成功登录 / 邮箱格式错 / 密码空 / 网络失败
- 文件输出到 Tests/UserViewModelTests.swift
```

### Cursor 产出

```text
[分析 UserViewModel 暴露的 API]
[识别依赖：UserService (protocol)]
[生成 FakeUserService + Tests]

已创建：Tests/UserViewModelTests.swift
- fakeUserService 覆盖所有 protocol 方法
- 4 个 @Test 函数，每个测一件事
- 运行测试：Cmd + U
```

### 踩坑点

- **依赖没 protocol 化**：AI 可能直接 mock 具体类，跑起来发现 `UserService` 不是 protocol。让它**先检查依赖是不是 protocol，不是就先改**
- **XCTest 和 Swift Testing 混用**：明确告诉它哪一个，否则你会拿到 `XCTAssertEqual` 混着 `#expect`
- **断言只验证 happy path**：要求它给"边界测试"，不是"正常测试"

---

## iOS 场景共通的三条经验

1. **在 `.cursorrules` 里钉死**技术栈、iOS 最低版本、State 管理偏好 —— 见 [03-高级技巧](03-高级技巧.md)
2. **review 时看 AI 加了什么不在清单里的东西** —— SwiftUI AI 很爱顺手"加个 Combine"
3. **真机跑一次** —— 模拟器不暴露的问题（签名 / 后台 / 真实网络），真机一次跑通比 10 次 AI 生成都值钱

---

## 相关资源

- 上一页：[01-核心功能](01-核心功能.md)
- 下一页：[03-高级技巧](03-高级技巧.md)
- 配合阅读：[实战篇/05-iOS 专项场景](../05-iOS专项场景/README.md)、[FAQ § 5 iOS 特有](../../FAQ.md#5-ios-特有)
