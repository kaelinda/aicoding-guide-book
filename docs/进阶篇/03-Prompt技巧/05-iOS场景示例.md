# 05-iOS 场景示例

> 前面四章讲的通用 Prompt 技巧，这里给一组 **Swift / SwiftUI 场景下的对应示范**，可直接粘。

---

## 场景 1：实现一个 SwiftUI 页面（对应五要素）

```text
角色：你是资深 iOS 工程师，熟悉 SwiftUI + MVVM + @Observable。

任务：实现一个"应用内反馈"页面。

上下文：
- 项目最低 iOS 17，用 SwiftData 持久化
- 已有 NetworkService（`Services/Network.swift`）负责所有 HTTP
- 命名风格看 `Views/ProfileView.swift`，请对齐

约束：
- 不引入新依赖
- 提交按钮必须有 loading / disabled / error 三态
- 文本框字数 > 500 时禁用提交并提示
- 单测用 Swift Testing（不是 XCTest）

示例：
参考 `Views/ProfileView.swift` 的布局方式，表单元素用相同的 padding 和 corner radius

验收：
- Preview 能跑，不崩
- 字数超限能正确禁用按钮
- 单测覆盖 3 个分支：空输入、字数超限、提交成功
```

---

## 场景 2：修一个 SwiftUI Bug（对应"先定位再改"）

```text
Bug：ProfileView 在从详情页 pop 回来后，@State 的 selectedTab 会被重置为 0。

先不要改代码：
- 读 ProfileView.swift 和 ProfileCoordinator.swift
- 判断类型（状态 / 生命周期 / 导航栈）
- 给 3 个可能的根因，按可能性排序
- 每个根因给"怎么验证是不是它"的方法

我需要的格式：
## 根因 A：xxx
- 验证：...

## 根因 B：xxx
- 验证：...
```

详见 [03-调试 Prompt](03-调试Prompt.md)。

---

## 场景 3：读懂 iOS 崩溃日志

```text
下面是一段真机 crash log，请做三件事：

1. 指出崩在哪个函数 / 文件 / 行号（symbolicated 如果能识别）
2. 判断崩溃类型（force unwrap / 内存访问 / 数据竞争 / exception）
3. 给出最可能的根因，以及**下一步我应该先去看哪个文件**

如果日志信息不够判断，明确告诉我还缺什么（例如：需要 dSYM / 需要 address sanitizer 跑一次）。

---
<贴 crash log>
```

---

## 场景 4：写 Swift Testing 用例

```text
为下面这个 ViewModel 写 Swift Testing 用例：

<贴 LoginViewModel.swift>

要求：
- 用 @Test 而不是 XCTest 的 `testXxx`
- 每个测试只测一件事
- 至少覆盖：成功登录 / 邮箱格式错 / 密码空 / 网络失败
- 依赖用 protocol + fake，不要 mock 框架
- 输出到 Tests/LoginViewModelTests.swift
```

---

## 场景 5：iOS 项目重构

核心是 **walking skeleton + 分轮**，不要一把梭。

模板见 [02-需求澄清模板 § 模板 2 代码重构](02-需求澄清模板.md#模板-2代码重构)。
反面案例见 [best-practices § 反面案例 2](../../best-practices.md#反面案例-2一次-prompt-要求太多功能)。

---

## 场景 6：排查 Xcode 签名 / 证书问题

重点：**贴完整的 xcodebuild 报错日志**，不要描述现象；让 AI **只看日志里提到的具体文件**，不要猜。

参考 [FAQ § 5 iOS 特有](../../FAQ.md#5-ios-特有)。

---

## 场景 7：让 AI 帮忙接手一个已存在的 iOS 项目

```text
不要改代码。先做三件事：

1. 列出 Podfile / Package.swift / project.pbxproj 里的主要依赖和版本
2. 走一遍 AppDelegate / SceneDelegate / 入口 View，画出启动流程
3. 找出 3 个"改动最危险"的模块（路由 / 网络层 / 登录态）

完成后我再决定从哪里开工。
```

---

## 场景 8：让 AI 验收你刚做的改动

```text
刚才的改动：
- 文件：<列出>
- 核心改动：<一句话>

作为 iOS 质检员，按以下顺序查一遍：
1. 功能性：列出每个改动点的手工验证路径（点哪个按钮、看什么）
2. 质量：看有无常见 SwiftUI 陷阱（@State 滥用 / body 重复计算 / weak self 漏写）
3. 安全：新加的权限 / 网络 / 存储点是否需要改 Info.plist 或 Privacy Manifest
4. 性能：是否引入 O(n²) 或主线程阻塞

每项按"🔴 必改 / 🟡 建议 / 🟢 可忽略"分级。
不要说"应该没问题"，只列能被验证的东西。
```

详细流程见 [进阶篇/05 结果验收与质量检查 § iOS 版](../05-结果验收与质量检查/README.md#-ios-版验收清单)。

---

## iOS 专属 Prompt 的三条共通经验

1. **钉死 iOS 版本 + State 管理偏好**：不说就会出老写法（NavigationView、ObservableObject、Combine）
2. **对齐项目里已有的参照文件**：用 `@SomeFile.swift` 引用（Cursor）或贴路径（Claude Code），让 AI 学你的风格，不是它训练数据里的
3. **最后一步永远是"验证"**：真机 / 模拟器 + 手工点击 + 单测三选一，不能全靠 AI 自述

---

## 相关资源

- 上一页：[04-Prompt 版本管理](04-Prompt版本管理.md)
- 章节首页：[03-Prompt 技巧](README.md)
- 配合阅读：[实战篇/05 iOS 专项场景](../../实战篇/05-iOS专项场景/README.md)、[FAQ § 5 iOS 特有](../../FAQ.md#5-ios-特有)
