# 🚀 快速开始

> 5 分钟内让你的第一个 AI 编程项目跑起来

---

## 目标

本篇帮助你在 **5 分钟内** 完成：
1. 安装 AI 编程工具
2. 创建你的第一个项目
3. 运行成功，获得正反馈

::: tip 前提条件
- macOS 12.0 或更高版本
- Xcode 14.0 或更高版本
- Node.js 18+（用于 Claude Code）
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
    iOS: "15.0"
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

### Q1: npm 安装报错 EACCES

```bash
# 解决方案：修改 npm 全局目录权限
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```

### Q2: claude 命令找不到

```bash
# 检查 PATH
echo $PATH

# 重新安装
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code
```

### Q3: 登录失败

```bash
# 清除认证信息重新登录
claude auth logout
claude
```

### Q4: XcodeGen 报错

```bash
# 安装 XcodeGen
brew install xcodegen

# 验证
xcodegen version
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
