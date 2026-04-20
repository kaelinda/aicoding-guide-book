# 📋 结果验收与质量检查

> AI 生成的代码需要验收。本章介绍如何系统性地检查 AI 输出，确保代码质量。

---

## 目标

- ✅ 建立代码验收清单
- ✅ 掌握自动化测试方法
- ✅ 学会识别常见质量问题
- ✅ 培养代码审查思维

---

## 验收流程

```
代码生成
    ↓
第一步：功能性验收
    ↓
第二步：代码质量检查
    ↓
第三步：安全检查
    ↓
第四步：性能检查
    ↓
通过 → 合并
失败 → 反馈修复
```

---

## 第一步：功能性验收

### 基础检查清单

- [ ] 代码能编译通过吗？
- [ ] 功能是否按需求实现？
- [ ] 边界情况是否处理？
- [ ] 错误提示是否清晰？
- [ ] 用户流程是否通顺？

### 测试用例设计

```swift
// 测试正常流程
func testLoginSuccess() async {
    let result = await login(phone: "13800138000", code: "123456")
    XCTAssertTrue(result.isSuccess)
}

// 测试错误流程
func testLoginWrongCode() async {
    let result = await login(phone: "13800138000", code: "000000")
    XCTAssertFalse(result.isSuccess)
    XCTAssertEqual(result.error, .wrongCode)
}

// 测试边界情况
func testEmptyPhone() async {
    let result = await login(phone: "", code: "123456")
    XCTAssertFalse(result.isSuccess)
    XCTAssertEqual(result.error, .invalidPhone)
}
```

---

## 第二步：代码质量检查

### 检查清单

| 检查项 | 说明 | 工具 |
|--------|------|------|
| 命名规范 | 变量/函数命名清晰 | - |
| 代码重复 | 是否有重复代码 | Xcode Analyze |
| 注释完整 | 关键逻辑有注释 | - |
| 函数长度 | 单个函数不超过 50 行 | - |
| 复杂度 | 嵌套不要太深 | SwiftLint |

### SwiftLint 规则

```bash
# 安装
brew install swiftlint

# 在项目目录运行
swiftlint
```

### 常用规则配置

```yaml
# .swiftlint.yml
disabled_rules:
  - trailing_whitespace
  - line_length

opt_in_rules:
  - empty_count
  - explicit_init
  - closure_spacing

excluded:
  - Pods
  - .build
```

---

## 第三步：安全检查

### 检查清单

| 检查项 | 风险 | 修复方法 |
|--------|------|----------|
| API Key 硬编码 | 🔴 高 | 使用环境变量 |
| 用户输入未校验 | 🔴 高 | 输入验证 |
| SQL 注入 | 🔴 高 | 参数化查询 |
| 敏感数据日志 | 🟡 中 | 脱敏日志 |
| 内存泄漏 | 🟡 中 | 使用 weak |
| Force unwrap | 🟡 中 | guard let |

### 安全检查 Prompt

```
"检查以下代码的安全问题：
1. 是否有 API Key 硬编码？
2. 用户输入是否验证？
3. 是否有内存泄漏风险？
4. 敏感数据是否加密存储？"
```

---

## 第四步：性能检查

### 检查清单

| 检查项 | 风险 | 修复方法 |
|--------|------|----------|
| 主线程阻塞 | 🔴 高 | 异步处理 |
| 大数组遍历 | 🟡 中 | 懒加载 |
| 图片未压缩 | 🟡 中 | 压缩处理 |
| 重复网络请求 | 🟡 中 | 缓存 |
| 内存占用过高 | 🟡 中 | 及时释放 |

### 性能测试 Prompt

```
"检查代码性能问题：
1. 网络请求是否异步？
2. 大数据量是否分页？
3. 图片是否懒加载？
4. 是否有内存泄漏？"
```

---

## 自动化验收

### CI/CD 集成

```yaml
# .github/workflows/quality.yml
name: Code Quality

on: [pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: SwiftLint
        run: |
          docker run --rm -v $(pwd):/app ghcr.io/realm/swiftlint:latest swiftlint
      
      - name: Build
        run: xcodebuild build
      
      - name: Test
        run: xcodebuild test
```

---

## 常见问题

### Q: 验收清单太长了

A: 先做基础检查（功能性），其他可以逐步完善。

### Q: AI 生成的代码需要全部审查吗？

A: 核心逻辑仔细看，通用代码可以略过。

### Q: 如何平衡速度和质量问题？

A: 先跑通功能，再优化质量。迭代改进。

---

## 📱 iOS 版验收清单

前面四步（功能 / 质量 / 安全 / 性能）放在 iOS 项目里的具体做法：

### 第一步：功能性验收（iOS 版）

- **Preview 能跑**：SwiftUI 的 `#Preview` 不崩、布局不乱
- **模拟器跑主流程**：最低支持设备 + 最新设备各跑一遍
  - iPhone SE（小屏 + 低配）
  - iPhone 15 / 17 Pro（主流 + 大屏）
  - iPad（如果支持）
- **真机跑一次**：模拟器不暴露的签名 / 后台计时 / 权限问题，真机才能看出
- **横竖屏 / 深色模式 / Dynamic Type**：各切换一次

### 第二步：代码质量（iOS 版）

```bash
# SwiftLint（强烈建议入项目）
brew install swiftlint
swiftlint

# Swift Format（官方 swift-format 或 SwiftFormat）
swift-format -i -r Sources/

# Build warnings 不能变多
xcodebuild -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15' build 2>&1 | grep -c warning:
```

iOS 特有 review 点：

- `@State` / `@StateObject` / `@ObservedObject` / `@Environment` 用对了吗
- `async` 函数是不是在 `@MainActor` 上调用
- `Task { }` 有没有正确处理 cancellation
- `weak self` / `[weak self]` 有没有在长生命周期闭包里漏掉

### 第三步：安全检查（iOS 版）

- `Info.plist` 里的权限描述（`NS*UsageDescription`）都填了吗
- **Privacy Manifest (`PrivacyInfo.xcprivacy`)**（iOS 17+ 合规必须）
- `Keychain` 存凭证、不要存 `UserDefaults`
- URL scheme / Universal Links 是否校验来源
- 所有网络请求走 HTTPS（`NSAllowsArbitraryLoads` 默认关闭）

### 第四步：性能检查（iOS 版）

```bash
# 启动耗时（Hang Reports / MetricKit）
# Xcode → Product → Profile → Time Profiler

# 内存泄漏
# Xcode → Product → Profile → Leaks

# 电量与后台
# Xcode → Debug → Debug Workflow → Energy Impact

# App 包大小
xcodebuild archive -scheme MyApp -archivePath ./build.xcarchive
du -sh ./build.xcarchive/Products/Applications/MyApp.app
```

iOS 特有关注点：

- 冷启动时间（< 400ms 目标）
- 首屏渲染内存（< 100 MB 舒适区）
- SwiftUI body 里有没有重复计算
- 列表滚动 FPS（Instruments Time Profiler）
- App 包大小（Xcode 16 的 App Thinning Report）

### 自动化：iOS CI 最小配置

```yaml
# .github/workflows/ios-ci.yml
jobs:
  ios-check:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - name: Lint
        run: |
          brew install swiftlint
          swiftlint
      - name: Build
        run: |
          xcodebuild build -scheme MyApp \
            -destination 'platform=iOS Simulator,name=iPhone 15'
      - name: Test
        run: |
          xcodebuild test -scheme MyApp \
            -destination 'platform=iOS Simulator,name=iPhone 15'
```

### 让 AI 帮你验收的 prompt

```text
刚才的改动：<文件列表>

作为 iOS 质检员，按以下顺序查一遍：
1. 功能性：列出每个改动点的手工验证路径（点哪个按钮、看什么）
2. 质量：看有无常见 SwiftUI 陷阱（@State 滥用 / body 重复计算 / weak self 漏写）
3. 安全：新加的权限 / 网络 / 存储点是否需要改 Info.plist 或 Privacy Manifest
4. 性能：是否引入 O(n²) 或主线程阻塞
每项按"🔴 必改 / 🟡 建议 / 🟢 可忽略"分级。
不要说"应该没问题"，只列能被验证的东西。
```

---

## 小结

```
✅ 建立了完整的验收流程
✅ 掌握了四层检查清单
✅ 学会了自动化测试方法
✅ iOS 读者有对应的具体化清单

下一步：了解 AI 编程的安全边界 →
```
