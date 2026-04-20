# 03-Codex iOS 开发实战

> 4 个 iOS 场景：快速原型、性能优化、测试生成、文档生成。每个带 prompt 模板 + review 要点。

---

## 场景 1：快速原型（从零生成一个 app）

### Prompt

```text
你：创建一个 Todo App 骨架，要求：
    - SwiftUI + SwiftData（iOS 17+）
    - 增 / 删 / 改 / 标记完成四个基本操作
    - 单一 TodoItem 模型（id / title / done / createdAt）
    - 不要 iCloud、不要 Widget、不要通知

    用 XcodeGen 生成工程，project.yml 一起输出。
    我会用 `xcodegen && open TodoApp.xcodeproj` 打开。
```

### Codex 产出

```text
已生成文件：

TodoApp/
├── project.yml
├── TodoApp/
│   ├── TodoApp.swift
│   ├── ContentView.swift
│   ├── Models/TodoItem.swift
│   ├── ViewModels/TodoStore.swift      # @Observable
│   └── Views/
│       ├── TodoListView.swift
│       ├── AddTodoView.swift
│       └── EditTodoView.swift

验证命令：
  xcodegen && xcodebuild -scheme TodoApp \
    -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### Review 要点

- **SwiftData 的 ModelContainer** 有没有在 `App` 入口注入，漏了会整个页面都跑不起来
- **`@Query` 的排序条件** 写了吗？没写默认没排序，体验差
- **删除行为** —— `.onDelete` 还是自定义按钮？两者不一样，跟你的需求对齐
- **XcodeGen 的 deployment target** —— 要和 prompt 里说的 iOS 17+ 对齐，它有时会偷偷写 15

---

## 场景 2：性能优化（诊断 + 优化）

### Prompt

```text
你：这个列表在 iPhone 12 Pro 上滚动有明显卡顿（帧率 < 30）。
<贴 ProductListView.swift 完整代码>

先不要改代码：
1. 指出最可疑的 3 个性能问题点（文件 / 行号 / 理由）
2. 每点给一个**怎么用 Instruments 验证**的步骤
3. 最后给出修复优先级

我会先跑 Instruments 确认，再让你出 patch。
```

### Codex 产出（示意）

```text
最可疑的 3 个问题点：

1. ProductListView.swift:23 —— 用了 VStack 而不是 LazyVStack
   验证：Instruments → Time Profiler → 看 `AnyView.body` 占比
   影响：大列表下所有 cell 都会初始化

2. ProductListView.swift:45 —— 每个 ProductCell 的图片都走 AsyncImage
   验证：Instruments → Network → 看同时 in-flight 请求数
   影响：滚动时并发发十几个请求，主线程被占

3. ProductListView.swift:67 —— `.onAppear` 里做重计算
   验证：Instruments → Hangs → 看 onAppear 回调耗时
   影响：每次 cell 出现都触发一次

优先级：1 > 2 > 3（因为 1 是结构性的）
```

### Review 要点

- **先验证再改**：Codex 猜得再准也可能漏，Instruments 跑一次才能定
- **一次只改一个**：改完跑，验证，再改下一个；别"三个一起改"然后不知道是哪个起效
- **要求给 Instruments 步骤**，别接受"应该是这里"

---

## 场景 3：测试生成

### Prompt

```text
你：为 Sources/NetworkManager.swift 生成 Swift Testing 用例。

要求：
- 用 @Test，不是 XCTest
- URLSession 用 MockURLProtocol 注入，不引入第三方 mock 库
- 至少覆盖：
  * GET 200 正常 decode
  * GET 404 抛 NetworkError.notFound
  * POST 带 token header 正确
  * 网络超时
  * JSON decode 失败
- 输出到 Tests/NetworkManagerTests.swift
- 跑法：xcodebuild test -scheme MyApp

如果 NetworkManager 当前无法被测（依赖硬编码），**先告诉我需要改哪里**，不要直接写测试。
```

### Codex 产出

```text
分析结果：NetworkManager 可以直接测，URLSession 通过 init 注入了。

已创建：Tests/NetworkManagerTests.swift

- 5 个 @Test
- MockURLProtocol helper 放在 Tests/Helpers/
- 每个测试隔离运行，不共享状态

跑法：
  xcodebuild test -scheme MyApp \
    -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Review 要点

- **真的"每个测一件事"吗**？AI 常把"happy path + 错误 decode"塞一个测试里
- **断言是真验证还是"能跑就行"**？看 `#expect` 有没有具体 value，不是 `.notNil`
- **Mock 的 URL 对上了吗**？有时 mock 的路径和真实请求的路径差个 `/`

---

## 场景 4：文档生成

### Prompt

```text
你：为整个项目生成开发者文档，输出到 docs/。
要求：
- docs/README.md：项目介绍 + 架构图（文本版）+ 启动方法
- docs/API.md：所有 public 类型和方法的签名 + 一句话说明
- docs/Architecture.md：MVVM 分层 + 数据流向图

不要生成"愿景 / 设计哲学"这类虚的内容。
不要写"此类实现了 XXX"的废话，只写"X 类负责 Y，调用方需要 Z"。
```

### Codex 产出

```text
已生成：
- docs/README.md（163 行）
- docs/API.md（由 swift-doc 扫描补充，含 47 个 public API）
- docs/Architecture.md（含 ASCII 分层图 + 数据流向）

注意：
- swift-doc 未安装时会退化到人工生成，准确度略降
- 已标注所有"未被单测覆盖的 public API"（4 个）
```

### Review 要点

- **API 文档是不是真从代码扫的**，还是 AI 按经验编的？抽查几个签名是否真实存在
- **架构图描述的是理想状态还是现状**？很多时候 AI 会写"MVVM"，但实际项目已经乱成 MVC + VM
- **docs/ 入 git 时**注意 .gitignore，别把生成的中间产物（`.build` 之类）带上

---

## iOS 共通经验

### 要让 Codex 稳定输出好代码，`AGENTS.md` 要写清：

- iOS 最低版本（17 / 16 / 15）—— 防止它用不兼容 API
- State 管理偏好（@Observable / ObservableObject / TCA）
- 测试框架（Swift Testing / XCTest）
- 禁止项（UserDefaults 存凭证、主动 Combine、强制解包）

详见 [02-高级功能 § AGENTS.md](02-高级功能.md#1-agentsmd--codex-的项目规则)。

### 真机验证不可跳

iOS 改动，**模拟器不算验证**。参见 [进阶篇/06-安全边界 § iOS 真机验证](../../进阶篇/06-AI编程安全边界/README.md#真机验证不可跳)。

---

## 相关资源

- 上一页：[02-高级功能](02-高级功能.md)
- 下一页：[04-安全与配置](04-安全与配置.md)
- 配合阅读：[实战篇/05-iOS 专项场景](../05-iOS专项场景/README.md)、[best-practices.md](../../best-practices.md)
