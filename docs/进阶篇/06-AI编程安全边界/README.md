# 🛡️ AI 编程安全边界

> AI 编程不是万能的，有些事情要谨慎，有些事情要避免。本章帮助你建立安全使用 AI 编程的边界意识。

---

## 目标

- ⚠️ 了解 AI 编程的局限性
- 🔒 识别需要谨慎处理的场景
- 🚫 知道什么不该让 AI 做
- ✅ 安全高效地使用 AI 编程

---

## 红线区（禁止）

### 🚫 不要让 AI 处理这些

| 场景 | 风险 | 原因 |
|------|------|------|
| 真实支付集成 | 🔴 极高 | 资金安全 |
| 身份认证系统 | 🔴 极高 | 安全合规 |
| 加密密钥生成 | 🔴 极高 | 密钥安全 |
| 安全证书处理 | 🔴 极高 | 证书安全 |
| 密码存储逻辑 | 🔴 极高 | 用户密码 |

### 为什么危险？

```swift
// ❌ 危险：AI 可能生成不安全的密码存储
func savePassword(password: String) {
    UserDefaults.standard.set(password, forKey: "password")
    // 明文存储密码！危险！
}

// ❌ 危险：AI 可能生成弱加密
func encrypt(data: String) -> String {
    return data.base64EncodedString()  // Base64 不是加密！
}
```

### 正确做法

```swift
// ✅ 安全：使用系统原生 Keychain
import Security

func savePasswordToKeychain(password: String) -> Bool {
    let data = password.data(using: .utf8)!
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: "user",
        kSecValueData as String: data
    ]
    SecItemDelete(query as CFDictionary)
    let status = SecItemAdd(query as CFDictionary, nil)
    return status == errSecSuccess
}
```

---

## 橙线区（谨慎）

### ⚠️ 需要人工审查

| 场景 | 风险 | 原因 |
|------|------|------|
| 数据库操作 | 🟠 高 | SQL 注入风险 |
| 文件系统操作 | 🟠 中 | 误删文件 |
| 网络请求 | 🟠 中 | 数据泄露 |
| 正则表达式 | 🟠 中 | ReDoS 攻击 |
| 并发/线程 | 🟠 中 | 数据竞态 |
| 第三方库 | 🟠 中 | 依赖安全 |

### 审查要点

```swift
// ⚠️ 需要审查的网络请求
func fetchUserData() async {
    // 检查：URL 是否可信？
    // 检查：数据传输是否加密？
    // 检查：响应数据是否验证？
    let url = URL(string: "https://api.example.com/user")!
    let (data, _) = try await URLSession.shared.data(from: url)
}

// ⚠️ 需要审查的文件操作
func deleteFile(at path: String) {
    // 检查：路径是否用户可控？
    // 检查：是否有备份？
    // 检查：是否确认删除？
    try? FileManager.default.removeItem(atPath: path)
}
```

---

## 黄线区（注意）

### 💛 需要测试验证

| 场景 | 风险 | 原因 |
|------|------|------|
| 算法实现 | 💛 中 | 逻辑正确性 |
| 复杂业务逻辑 | 💛 中 | 边界情况 |
| 正则匹配 | 💛 低 | 匹配逻辑 |
| 数值计算 | 💛 低 | 精度问题 |
| 日期时间处理 | 💛 低 | 时区问题 |

### 测试验证

```swift
// 💛 算法需要测试
func calculateShippingFee(weight: Double, distance: Double) -> Double {
    // AI 可能生成错误的计算公式
    // 需要测试验证
    return weight * 0.5 + distance * 0.3
}

// 测试用例
func testShippingFee() {
    XCTAssertEqual(calculateShippingFee(weight: 1, distance: 1), 0.8, accuracy: 0.001)
    XCTAssertEqual(calculateShippingFee(weight: 0, distance: 0), 0, accuracy: 0.001)
    XCTAssertGreaterThan(calculateShippingFee(weight: 10, distance: 10), 0)
}
```

---

## 绿线区（安全）

### ✅ AI 可以独立完成

| 场景 | 说明 |
|------|------|
| UI 布局 | SwiftUI / UIKit 界面 |
| 简单 CRUD | 基本增删改查 |
| 代码重构 | 优化已有代码 |
| 文档生成 | 注释和文档 |
| 单元测试 | 基础测试用例 |
| 代码翻译 | Swift ↔ Objective-C |
| 模板代码 | 重复性代码 |

### 安全使用示例

```swift
// ✅ AI 擅长：UI 布局
struct HomeView: View {
    var body: some View {
        VStack {
            Text("Hello, AI!")
                .font(.largeTitle)
            Button("Click me") {
                print("Clicked")
            }
        }
    }
}

// ✅ AI 擅长：生成测试用例
func testCounterIncrement() {
    let counter = Counter()
    counter.increment()
    XCTAssertEqual(counter.value, 1)
}
```

---

## 安全使用 Checklist

### 每次 AI 生成代码后

- [ ] 检查是否涉及红线区？
- [ ] 橙线区内容是否有人工审查？
- [ ] 边界情况是否测试？
- [ ] 是否有日志泄露敏感信息？
- [ ] 是否有硬编码的密钥/URL？

### Prompt 安全提示

```
在给 AI 的 Prompt 中添加安全要求：

"实现登录功能：
- 使用 Keychain 存储 Token
- 不要在日志中打印密码
- Token 过期要正确处理
- 使用 HTTPS 请求
- 验证用户输入格式"
```

---

## 场景指南

### 小型个人项目

- AI 可以做：UI、简单逻辑、测试
- 需要审查：网络请求、存储
- 不要做：支付、安全相关

### 公司商业项目

- AI 可以做：原型、模板、辅助
- 需要审查：所有代码
- 不要做：核心安全模块

### 开源项目

- AI 可以做：文档、示例、测试
- 需要审查：所有 PR
- 注意：确保贡献者协议允许

---

## 常见问题

### Q: 不知道是否在红线区怎么办？

A: 保守处理。如果涉及安全、金钱、隐私，务必人工审查。

### Q: AI 说"这是安全的"可信吗？

A: 不可信。AI 可能会犯错，且不知道你的具体场景。

### Q: 怎么平衡效率和安全性？

A: 效率优先，快速原型 → 安全审查 → 合并上线。

---

## 📱 iOS 场景的安全边界

### iOS 特有的红线区

这些领域在 iOS 上尤其不要让 AI 独立操作：

| 领域 | 为什么是红线 | 怎么做 |
|------|------|------|
| **Keychain 访问** | 凭证读写错一行就泄密 | 人工 review 每一次 `SecItemAdd/Copy/Delete` 调用 |
| **签名与证书** | `provisioning profile` / `entitlements` 配错会导致线上发布失败或拒绝审核 | AI 只读不改；改动通过 Apple Developer 官网或 Xcode GUI 手工执行 |
| **StoreKit / IAP** | 订阅逻辑错 = 用户免费白嫖或重复扣费 | 必须真机 + 沙盒账号完整走一遍；AI 输出的 `Transaction` 处理代码逐行看 |
| **Privacy Manifest** | iOS 17+ 合规必须；错了会被 App Store 拒 | AI 可以协助生成 `PrivacyInfo.xcprivacy` 模板，但最终条目由人工按 [Apple 官方 Required Reason API](https://developer.apple.com/documentation/bundleresources/privacy_manifest_files) 清单核对 |
| **App Group / Shared Container** | 多个 target 共享数据，权限边界错了会导致数据覆盖或泄露 | 人工审核 entitlements、bundle id 配置 |
| **Universal Links / URL Schemes** | 没校验来源会被第三方 app 伪造调起 | AI 可写脚手架；**必须加来源校验 + 参数白名单**，人工确认 |

### iOS 特有的橙线区（需人工审查）

- **UserDefaults 存敏感数据**：AI 很容易把 token / 用户信息写进 UserDefaults —— **不允许**，必须 Keychain
- **WebView 里的 JS Bridge**：AI 生成的 JS Bridge 如果没做 message 校验，会被 xss 控制 native
- **后台任务 (`BGTaskScheduler`)**：错用会导致电量问题或任务不执行
- **推送 payload 处理**：payload 信任来源校验要到位，防止伪造
- **共享相册 / 文件访问**：AI 写 `PHPicker` / `DocumentPicker` 要注意权限提示文案合规

### iOS 特有的绿线区（AI 可以独立做）

- SwiftUI View 布局
- `#Preview` 代码
- Swift Testing 用例（结构层面，业务判定仍需人工看）
- SwiftLint / swift-format 配置
- README / 文档 / 注释生成
- Storyboard → SwiftUI 的纯 UI 平移（不涉及业务逻辑）

### iOS 具体防护手势

把这几条钉进项目根的 `CLAUDE.md`：

```markdown
- 不要直接修改 *.xcodeproj/project.pbxproj 的签名相关字段
- 不要在代码里硬编码 API Key / Team ID / Bundle ID
- 不要在 UserDefaults 里存 token 或 user credentials
- 涉及 Keychain / StoreKit / Privacy Manifest 的改动，停下等我手动 review
- 新增任何 entitlement 前先列出所需能力，让我批准
```

### 真机验证不可跳

iOS 安全类改动，**模拟器不算验证**。至少要：

- 真机签名编译通过
- 真机上走一遍冷启动 + 主流程
- 涉及 IAP 的：沙盒账号 + TestFlight 走一遍
- 涉及后台任务的：让 app 真实在后台待超过 15 分钟再回来

---

## 小结

```
🚫 红线区：支付、认证、密钥 - 禁止 AI 处理
🟠 橙线区：数据库、文件、网络 - 需要人工审查
💛 黄线区：算法、业务逻辑 - 需要测试验证
✅ 绿线区：UI、测试、文档 - AI 可以独立完成

iOS 加码：Keychain / 签名 / StoreKit / Privacy Manifest 全部进红线。
真机验证不可跳。

记住：AI 是工具，安全责任在你。
```
