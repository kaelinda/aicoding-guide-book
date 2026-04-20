# 🚀 快速开始

> 10~15 分钟跑通你的第一个 AI 编程项目（含工具安装 + 首次登录 + 项目构建）

---

## 先看 60 秒：AI 帮你写一个 SwiftUI 小页面

环境装完之后，这是你会在终端里看到的东西。**真实会话截录，不是演示稿**：

```text
$ cd ~/Projects && mkdir DailyQuote && cd DailyQuote
$ claude

▸ 你：
  用 SwiftUI 做一个最小 app，主屏显示一条每日名言，
  点屏幕随机换一条（本地 10 条写死），深色模式适配。
  iOS 17+，用 @Observable，不要 ViewController。
  给我完整的 App.swift 和 ContentView.swift。

▸ Claude:
  好的，这是两个文件：

  # App.swift
  import SwiftUI
  @main struct DailyQuoteApp: App {
      var body: some Scene {
          WindowGroup { ContentView() }
      }
  }

  # ContentView.swift
  import SwiftUI
  @Observable class QuoteStore {
      let quotes = [
          "稳定比聪明更重要",
          "写代码前先写边界",
          ...（共 10 条）
      ]
      var current: String
      init() { current = quotes.randomElement()! }
      func shuffle() {
          var next = quotes.randomElement()!
          while next == current { next = quotes.randomElement()! }
          current = next
      }
  }

  struct ContentView: View {
      @State private var store = QuoteStore()
      var body: some View {
          VStack {
              Text(store.current)
                  .font(.title2).multilineTextAlignment(.center)
                  .padding()
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color(.systemBackground))
          .contentShape(Rectangle())
          .onTapGesture { store.shuffle() }
      }
  }

  # Preview 在 Xcode 里 Cmd+Option+P 打开，或直接跑模拟器
  # iOS 17+ 必须，因为 @Observable 是 Observation framework 的宏

▸ 你：
  在 Xcode 里跑通了，换条名言会抖动一下，看起来很僵硬。
  给 current 的切换加一个 .transition(.opacity) 淡入淡出。

▸ Claude:
  给 Text 加一个 .id(store.current) 让 SwiftUI 认为它是新 View，
  外层包 withAnimation：

  Text(store.current)
      .font(.title2)
      .id(store.current)
      .transition(.opacity.combined(with: .scale(scale: 0.95)))

  onTapGesture { withAnimation(.easeInOut(duration: 0.25)) { store.shuffle() } }

▸ 你：
  好了，提交一下。commit message 用"feat: 每日名言 MVP"。

▸ Claude:
  [运行 git add + git commit，返回 commit hash]
```

这 60 秒里你做了 3 件事：**描述需求 → 贴代码进 Xcode 跑起来 → 一句话追加动画效果**。
没写一行 Swift，拿到一个能跑的 SwiftUI 小 app。

这本书接下来教的，就是**把这种"60 秒体验"变成你日常工作流**，而不是偶尔一次的魔法。

---

## 目标

本篇帮助你在 **10~15 分钟** 完成：
1. 安装 AI 编程工具（Claude Code）
2. 创建你的第一个 iOS 项目
3. 运行成功，获得正反馈

> 💡 已经装过 Node.js / Xcode 的读者通常 5 分钟就能跑完。**第一次配环境的读者别卡在"5 分钟"这个数字**——我们优先保证你跑通，而不是比快。

::: tip 前提条件
- macOS 13.0 或更高版本（2026 年主流机型均满足）
- Xcode 16.0+ 推荐（最低 15.0，低于此版本无法使用 `#Preview` 宏等新 API）
- Node.js 20 LTS 或更高（Node.js 18 已于 2025-04 停止维护，Claude Code 官方最低建议 20）
- XcodeGen：`brew install xcodegen`（本篇用它一条命令生成 `.xcodeproj`）
:::

---

## 第一步：安装 Claude Code

Claude Code 是当前最强大的 AI 编程工具，支持 macOS、Linux。

### 方法一：npm 安装（推荐）

```bash
# 安装
npm install -g @anthropic-ai/claude-code

# 验证安装
claude --version
```

### 方法二：Homebrew 安装

```bash
brew install --cask claude
```

### 首次登录

```bash
# 启动 Claude Code
claude

# 首次使用会提示登录
# 按提示在浏览器中完成认证
```

---

## 第二步：创建你的第一个 iOS 项目

### 使用 Xcode 创建项目

```bash
# 创建项目目录
mkdir MyFirstProject && cd MyFirstProject

# 使用 XcodeGen 生成项目
echo 'name: MyFirstProject
options:
  bundleIdPrefix: com.example
  deploymentTarget:
    iOS: "17.0"
targets:
  MyFirstProject:
    type: application
    platform: iOS
    sources: [MyFirstProject]
    settings:
      base:
        INFOPLIST_FILE: MyFirstProject/Info.plist
        PRODUCT_BUNDLE_IDENTIFIER: com.example.myfirstproject
        MARKETING_VERSION: "1.0.0"
        CURRENT_PROJECT_VERSION: "1"
        DEVELOPMENT_TEAM: ""
        CODE_SIGN_IDENTITY: ""
        CODE_SIGNING_REQUIRED: "NO"
        CODE_SIGN_ENTITLEMENTS: ""' > project.yml

# 创建源码目录
mkdir -p MyFirstProject
```

### 让 AI 帮你写代码

```bash
claude
```

在 Claude Code 中输入：

```
帮我创建一个简单的 SwiftUI 应用：
- 只有一个页面
- 显示"Hello, AI!"文字
- 背景色是蓝色
- 文字居中显示，白色，32号字体
```

Claude Code 会自动创建所有需要的文件。

---

## 第三步：运行项目

```bash
# 打开 Xcode
open MyFirstProject.xcodeproj

# 或者用命令行构建
xcodebuild -project MyFirstProject.xcodeproj \
  -scheme MyFirstProject \
  -configuration Debug \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  build
```

---

## 🎉 成功标志

如果看到以下输出，说明项目构建成功：

```
** BUILD SUCCEEDED **
```

---

## 常见问题

> 排查通用顺序：**先诊断，再动手**。下面每题都按"怎么看 → 怎么修"给。

### Q1: npm 安装报错 EACCES（权限拒绝）

**先诊断**：

```bash
# 看看你的 npm 全局目录是不是在 /usr/local 之类需要 sudo 的位置
npm config get prefix
```

如果输出是 `/usr/local` 或 `/usr`，就是权限问题。**别用 `sudo npm install -g`**，它会留下后患。

**修**：

```bash
# 把 npm 全局目录挪到用户目录下
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

# 再试一次安装
npm install -g @anthropic-ai/claude-code
```

### Q2: claude 命令找不到

**先诊断**：

```bash
# 1. 看看它装到哪了
npm root -g
ls "$(npm root -g)/@anthropic-ai/claude-code/bin" 2>/dev/null

# 2. 看看 PATH 里有没有 npm 全局 bin
echo $PATH | tr ':' '\n' | grep -E "(npm|node)"

# 3. 直接 which
which claude
```

**修**：

- 情况 A：`npm root -g` 里有但 `which claude` 找不到 → PATH 没包含 npm 的 bin 目录，回到 Q1 加 `export PATH`。
- 情况 B：`npm root -g` 里也没有 → 装失败了，重装：`npm install -g @anthropic-ai/claude-code`。
- 情况 C：装好了、PATH 也对，但执行报错 → 看看 `node -v` 是否 ≥20。

### Q3: 登录失败

**先诊断**：

```bash
# 看当前登录状态 & 配置
claude /status      # 在 claude 交互界面里运行
cat ~/.claude/.credentials.json 2>/dev/null | head -5   # 不要贴出来，只看有没有
```

常见原因：
- 浏览器没能回跳（公司网络 / VPN / Safari 拦截）
- token 过期或被吊销
- 地区访问受限

**修**：

```bash
# 清除凭证，换一个浏览器（推荐 Chrome）再登一次
rm -rf ~/.claude/.credentials.json
claude
```

还不行：试试浏览器登录 https://claude.ai/ 能否正常；若网页登录也失败，是网络 / 账号问题，不是 CLI 的锅。

### Q4: XcodeGen 报错

**先诊断**：

```bash
xcodegen version   # 看看是否装好
xcodegen generate --spec project.yml --verbose   # 看详细报错
```

**修**：

```bash
# 没装：
brew install xcodegen

# 装了但 project.yml 语法错：
# 看报错的行号，常见是缩进用了 tab（YAML 只认空格）
```

---

## 下一步

- 📖 [工具安装](./基础篇/02-工具安装/README.md) - 了解其他 AI 编程工具
- 📖 [第一个项目](./基础篇/03-第一个项目/README.md) - 完整项目开发流程
- 📖 [Prompt 技巧](./进阶篇/03-Prompt技巧/README.md) - 如何写好提示词

---

## 小结

```
✅ 已安装 Claude Code
✅ 已创建第一个 SwiftUI 项目  
✅ 项目可成功构建

下一步：学习如何用 AI 高效开发完整功能 →
```
