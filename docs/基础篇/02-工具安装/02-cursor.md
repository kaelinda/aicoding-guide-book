# Cursor 安装

> 最强 AI IDE，5 分钟上手

## 📦 安装步骤

### 步骤 1：下载 Cursor

访问官网：**https://cursor.sh**

或直接下载：
```bash
# macOS
open https://cursor.sh/api/download/mac
```

### 步骤 2：安装

1. 打开下载的 `.dmg` 文件
2. 拖动 Cursor 到 Applications
3. 打开 Cursor

### 步骤 3：登录

首次启动会提示登录：

1. 选择登录方式：
   - Sign in with Google
   - Sign in with GitHub
   - Sign in with Email

2. 完成授权

### 步骤 4：导入 VS Code 配置（可选）

如果你之前使用 VS Code：

```
Cursor 会自动检测 → 一键导入：
- 扩展插件
- 用户设置
- 快捷键配置
```

## 🔧 基础配置

### 设置默认模型

打开设置（`Cmd + ,`）：

```json
{
  "cursor.aiModel": "claude-3.5-sonnet"
}
```

### 配置 .cursorrules

在项目根目录创建 `.cursorrules`：

```markdown
# 项目规则

## 技术栈
- Swift 5.9
- SwiftUI
- MVVM 架构

## 编码规范
- 使用 4 空格缩进
- 所有 public 方法添加文档注释
```

### 推荐扩展

```
1. Swift (Apple) - Swift 语言支持
2. SwiftUI Preview - SwiftUI 预览
3. GitLens - Git 增强
4. Code Spell Checker - 拼写检查
```

## ✅ 验证安装

### 测试 AI 对话

```
1. 按 Cmd + L 打开 AI 对话框
2. 输入：创建一个简单的 SwiftUI 视图
3. 观察生成的代码
```

### 测试代码补全

```
1. 创建新文件 test.swift
2. 输入：func 
3. 观察 AI 自动补全
```

## ⚠️ 常见问题

### 问题 1：打开 iOS 项目报错

```
解决方案：
Cursor 本身不能运行 iOS 项目

工作流：
1. 用 Cursor 编写代码
2. 用 Xcode 运行调试
```

### 问题 2：AI 响应很慢

```
解决方案：
1. 检查网络连接
2. 切换模型：
   - Claude 3.5 Sonnet（快）
   - GPT-4（慢但强）
```

### 问题 3：无法导入 VS Code 扩展

```
解决方案：
手动安装扩展：
1. 打开扩展面板（Cmd + Shift + X）
2. 搜索扩展名称
3. 点击 Install
```

## 🎯 快捷键速查

| 功能 | 快捷键 |
|------|--------|
| AI 对话 | Cmd + L |
| 内联编辑 | Cmd + K |
| 代码补全 | Tab |
| 全局搜索 | Cmd + Shift + L |
| 打开设置 | Cmd + , |

## 📚 下一步

- [Codex 安装 →](./03-codex.md)
- [Cursor 实战教程 →](../../实战篇/02-Cursor实战/README.md)

## 🔗 相关资源

### 官方文档
- [Cursor 官网](https://cursor.sh) ⭐⭐⭐⭐⭐
- [Cursor 文档](https://cursor.com/docs) ⭐⭐⭐⭐⭐

### 社区
- [Cursor 论坛](https://forum.cursor.sh/) ⭐⭐⭐⭐
