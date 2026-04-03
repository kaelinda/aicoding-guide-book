# AI 编程快速参考卡片

> 一页纸速查，常用命令和技巧

---

## 🚀 快速开始

### Claude Code
```bash
# 安装
npm install -g @anthropic-ai/claude-code

# 启动
claude

# 常用命令
/model claude-3.5-sonnet  # 切换模型
/clear                    # 清空对话
/help                     # 查看帮助
```

### Cursor
```bash
# 下载
open https://cursor.sh

# 快捷键
Cmd + L              # AI 对话
Cmd + K              # 内联编辑
Tab                  # 代码补全
Cmd + Shift + L      # 全局搜索
```

### Codex
```bash
# 安装
npm install -g @openai/codex

# 启动
codex

# 常用命令
/model gpt-5-codex   # 切换模型
/reasoning high      # 调整推理
/help                # 查看帮助
```

---

## 📝 Prompt 模板

### 创建新功能
```
创建一个 [功能名称]，包含：
- [功能点 1]
- [功能点 2]
- [功能点 3]

技术要求：
- 使用 [框架/库]
- 遵循 [架构]
- [其他约束]
```

### 修复 Bug
```
问题描述：[具体现象]

复现步骤：
1. [步骤 1]
2. [步骤 2]

错误信息：
[错误日志]

相关代码：
文件：[文件路径]
```

### 代码重构
```
重构目标：[为什么要重构]

当前代码：
[当前实现]

目标架构：
[期望架构]

约束：
- 保持功能不变
- 通过现有测试
```

---

## 🎯 常用 Git 命令

### 日常工作流
```bash
# 查看状态
git status

# 添加修改
git add .

# 提交
git commit -m "feat: 功能描述"

# 推送
git push origin main

# 拉取
git pull origin main
```

### 分支管理
```bash
# 创建分支
git checkout -b feature/new-feature

# 切换分支
git checkout main

# 合并分支
git merge feature/new-feature

# 删除分支
git branch -d feature/new-feature
```

### 撤销操作
```bash
# 撤销工作区修改
git checkout -- file.txt

# 撤销暂存
git reset HEAD file.txt

# 撤销提交（保留修改）
git reset --soft HEAD~1

# 撤销提交（丢弃修改）
git reset --hard HEAD~1
```

---

## 🔧 环境管理

### Node.js
```bash
# 查看版本
node -v

# 切换版本
nvm use 20

# 设置默认版本
nvm alias default 20

# 查看已安装
nvm ls
```

### npm
```bash
# 全局安装
npm install -g package-name

# 本地安装
npm install package-name

# 查看全局包
npm list -g --depth=0

# 更新包
npm update -g package-name

# 设置镜像
npm config set registry https://registry.npmmirror.com
```

---

## 📱 iOS 开发常用

### Xcode 命令行
```bash
# 构建
xcodebuild -scheme MyProject -configuration Debug

# 测试
xcodebuild test -scheme MyProject

# 归档
xcodebuild archive -scheme MyProject -archivePath build/App.xcarchive

# SwiftLint
swiftlint --strict
```

### SwiftUI 视图模板
```swift
struct MyView: View {
    @State private var viewModel = MyViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("标题")
        }
    }
    
    private var content: some View {
        // 视图内容
    }
}
```

---

## 🛡 安全检查清单

### 代码提交前
- [ ] 无敏感信息（密码、密钥）
- [ ] 无调试代码（print、console.log）
- [ ] 无编译警告
- [ ] 测试通过
- [ ] Lint 检查通过

### AGENTS.md 配置
```markdown
## 禁止事项
- 不要使用强制解包 !
- 不要硬编码密钥
- 不要提交 .env 文件
```

---

## ⚡ 效率技巧

### 1. 分步骤开发
```
第一轮：创建项目骨架
第二轮：实现核心功能
第三轮：添加进阶功能
第四轮：优化和测试
```

### 2. 及时反馈
```
AI 生成代码 → 运行测试 → 发现问题 → 让 AI 修复
```

### 3. 利用模板
```
保存常用代码模板
→ 需要时快速复用
→ 减少重复劳动
```

---

## 🎨 配置文件模板

### AGENTS.md 最小模板
```markdown
# 项目配置

## 技术栈
- Swift 5.9
- SwiftUI

## 编码规范
- 使用 4 空格缩进
- 遵循 Swift API 设计指南

## 禁止事项
- 不要使用强制解包 !
```

### .cursorrules 最小模板
```markdown
# 项目规则

## 技术栈
- Swift 5.9
- SwiftUI
- MVVM

## 编码规范
- 使用 4 空格缩进
```

---

## 📊 工具对比速查

| 特性 | Claude Code | Cursor | Codex |
|------|-------------|--------|-------|
| 环境 | 终端 | IDE | 终端 |
| 模型 | Claude 3.5 | Claude/GPT | GPT-5 |
| 价格 | $20/月 | $20/月 | 含在 ChatGPT Plus |
| 自主性 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 上手难度 | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |

**选择建议：**
- 新手 → Cursor
- 终端用户 → Claude Code
- ChatGPT 用户 → Codex

---

## 🔍 常见错误速查

| 错误 | 解决方案 |
|------|----------|
| `command not found` | 检查 PATH，重新安装 |
| `EACCES permission denied` | 修改 npm 全局路径 |
| `Authentication failed` | 重新登录认证 |
| `Connection timeout` | 检查网络，使用代理 |
| `SSL certificate problem` | 更新证书或使用镜像 |

---

## 📚 快速链接

### 官方文档
- [Claude Code](https://docs.anthropic.com/claude-code)
- [Codex](https://developers.openai.com/codex)
- [Cursor](https://cursor.com/docs)
- [SwiftUI](https://developer.apple.com/documentation/swiftui)

### 学习资源
- [Prompt Engineering](https://www.promptingguide.ai/)
- [Swift by Sundell](https://www.swiftbysundell.com/)
- [Hacking with Swift](https://www.hackingwithswift.com/)

---

**保存此页面，随时查阅！**
