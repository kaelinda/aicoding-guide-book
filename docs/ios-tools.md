# iOS 开发常用工具清单

> 面向日常开发、调试、格式化、依赖管理、性能分析与工程治理的 iOS 工具速查。

---

## 为什么要单独整理这页

很多 iOS 项目代码本身不差，但工程体验不稳定，常见问题包括：

- 没有统一格式化与 lint
- 构建日志难读
- 抓包麻烦
- 工程结构越来越混乱
- 发布流程全靠手工点击

所以这页的目标不是“工具越多越好”，而是帮你建立一套**最小但有效**的工具链。

---

## 1. 代码规范与格式化

### SwiftLint
用途：
- 代码风格检查
- 发现潜在坏味道
- 约束团队编码习惯

常用命令：

```bash
swiftlint
swiftlint lint --strict
swiftlint autocorrect
```

适合放在：
- 本地开发
- CI 检查
- 提交前自检

### SwiftFormat
用途：
- 自动格式化代码
- 减少无意义 diff
- 保持团队统一风格

常用命令：

```bash
swiftformat .
swiftformat Sources
```

建议：
- SwiftLint 负责“检查”
- SwiftFormat 负责“修复格式”

---

## 2. 构建与日志工具

### xcodebuild
用途：
- 命令行构建
- 测试
- 归档
- CI 集成

常用命令：

```bash
# 查看 schemes
xcodebuild -list

# 构建
xcodebuild -scheme MyApp -configuration Debug

# 测试
xcodebuild test -scheme MyApp -destination 'platform=iOS Simulator,name=iPhone 15'

# 归档
xcodebuild archive -scheme MyApp -archivePath build/MyApp.xcarchive
```

### xcbeautify
用途：
- 美化 `xcodebuild` 输出
- 提高 CI 日志可读性

常见用法：

```bash
xcodebuild test -scheme MyApp | xcbeautify
```

### AI 驱动的构建速度优化

如果 clean / 增量 build 已经慢到影响日常迭代，直接用 AI Skill 跑基准 + 出优化计划：见 [进阶篇 · Skill 推荐 → Xcode Build Optimization Agent Skill](./进阶篇/04-Rules与Skill/02-Skill推荐.md#xcode-build-optimization-agent-skill)。

---

## 3. 依赖管理工具

### Swift Package Manager
用途：
- 官方依赖管理方案
- 新项目优先推荐

优点：
- 集成度高
- 配置简单
- 维护成本低

### CocoaPods
用途：
- 老项目依赖管理
- 某些历史库仍依赖它

适用场景：
- 维护旧项目
- 无法快速迁移到 SPM 的仓库

建议：
- 新项目优先 SPM
- 老项目逐步迁移，不要一次性大爆改

---

## 4. 网络调试工具

### Charles
用途：
- 抓包
- 改包
- 查看接口耗时
- 调试 HTTPS 请求

### Proxyman
用途：
- macOS 下体验更现代的抓包工具
- 对 iOS 开发者更友好

适合场景：
- 登录流程排查
- Header / Cookie / Token 检查
- Mock 返回值

---

## 5. 性能分析工具

### Instruments
用途：
- 内存分析
- 泄漏分析
- CPU 分析
- 启动耗时分析
- 卡顿定位

高频模块：
- Time Profiler
- Allocations
- Leaks
- Network

建议：
- 列表卡顿先看主线程热点
- 内存暴涨先看图片与大对象生命周期

### RocketSim
用途：
- 增强模拟器体验
- 快速查看布局、截屏、调试状态

适合日常开发提效。

---

## 6. 工程治理工具

### Tuist
用途：
- 管理大型 Xcode 工程
- 减少 `.xcodeproj` / `.pbxproj` 冲突
- 做模块化工程更舒服

适用场景：
- 多模块项目
- 团队协作频繁
- 工程文件冲突严重

### Periphery
用途：
- 查找未使用代码
- 清理死代码

价值：
- 帮你发现“看起来还在，其实没人用”的 ViewModel、Helper、Extension

### Sourcery
用途：
- 模板生成代码
- 减少样板代码

适合场景：
- 自动生成 Mock
- 自动生成协议适配代码

---

## 7. 测试与质量工具

### XCTest
用途：
- 单元测试
- 集成测试

### XCUITest
用途：
- UI 自动化测试

### Snapshot Testing
用途：
- 视图截图对比
- 防止 UI 回归

### Danger
用途：
- 在 PR 阶段自动检查规则
- 比如提醒：未更新 changelog、PR 过大、无测试

---

## 8. 推荐的最小工具链

如果你是个人项目或小团队，建议先用这套：

- SwiftLint
- SwiftFormat
- xcodebuild
- xcbeautify
- Swift Package Manager
- Proxyman 或 Charles
- Instruments

如果你是中大型项目，再追加：

- Tuist
- Periphery
- Danger
- Snapshot Testing

---

## 9. 提交前自检清单

- [ ] `swiftformat .` 已执行
- [ ] `swiftlint lint --strict` 通过
- [ ] `xcodebuild test` 通过
- [ ] 无明显死代码
- [ ] 无未删除的调试日志
- [ ] 网络请求可通过抓包工具验证

---

## 小结

iOS 工程化不需要一开始就堆很多工具，但至少应当有：

- 代码规范工具
- 构建与测试入口
- 抓包调试工具
- 性能分析工具
- 一套可以逐步扩展的工程治理方案

先把最小工具链建起来，再逐步增强，成本最低，收益最大。
