# 03-Node.js 配置

> JavaScript 运行时，AI 工具的基础依赖

## 🤔 为什么 iOS 开发者需要 Node.js

虽然 iOS 开发主要用 Swift，但很多 AI 编程工具需要 Node.js：

| 工具 | 需要 Node.js | 原因 |
|------|--------------|------|
| Claude Code | ✅ | 基于 Node.js 开发 |
| Codex CLI | ✅ | 通过 npm 安装 |
| Cursor | ❌ | 独立应用 |
| OpenClaw | ✅ | 基于 Node.js |

**结论：** Node.js 是 AI 编程工具链的基础设施。

## 📦 安装 Node.js

### 推荐方式：通过 nvm

```bash
# 安装最新 LTS 版本（推荐）
nvm install --lts

# 或安装指定版本
nvm install 20.11.0

# 查看已安装版本
nvm ls

# 使用指定版本
nvm use 20.11.0
```

### 验证安装

```bash
# 检查 Node.js 版本
node -v
# 输出：v20.11.0

# 检查 npm 版本
npm -v
# 输出：10.2.4
```

## 🔧 Node.js 版本选择

### 版本类型

```
LTS (Long Term Support) - 长期支持版
├─ 偶数版本（18, 20, 22...）
├─ 稳定性高，推荐生产使用
└─ 支持 30 个月

Current - 当前版本
├─ 奇数版本（19, 21, 23...）
├─ 最新特性
└─ 支持 6 个月
```

### 推荐版本

```
推荐：Node.js 20 LTS（或更高 LTS 版本）

原因：
1. Claude Code 要求：Node 18+
2. Codex CLI 要求：Node 18+
3. OpenClaw 要求：Node 22+（推荐 24）
4. 大多数工具都兼容 Node 20
```

### 查看可用版本

```bash
# 查看所有可用版本
nvm ls-remote

# 只看 LTS 版本
nvm ls-remote --lts

# 安装最新的 LTS
nvm install --lts
```

## 📚 npm 基础使用

### npm 是什么

npm (Node Package Manager) 是 Node.js 的包管理器，类似于：
- iOS 的 CocoaPods / Swift Package Manager
- Android 的 Gradle
- Python 的 pip

### 常用命令

#### 查看配置

```bash
# 查看 npm 配置
npm config list

# 查看全局安装路径
npm root -g

# 查看缓存路径
npm cache ls
```

#### 安装包

```bash
# 全局安装（命令行工具）
npm install -g @anthropic-ai/claude-code
npm install -g @openai/codex
npm install -g openclaw

# 项目本地安装
cd ~/Projects/my-project
npm install lodash

# 安装开发依赖
npm install -D typescript
```

#### 查看已安装

```bash
# 查看全局包
npm list -g --depth=0

# 查看项目依赖
npm list --depth=0

# 查看过期的包
npm outdated
```

#### 更新包

```bash
# 更新 npm 自己
npm install -g npm@latest

# 更新全局包
npm update -g

# 更新项目依赖
npm update
```

#### 卸载包

```bash
# 卸载全局包
npm uninstall -g package-name

# 卸载项目依赖
npm uninstall package-name
```

## 🎯 配置优化

### 设置镜像源

```bash
# 使用国内镜像（加速下载）
npm config set registry https://registry.npmmirror.com

# 验证设置
npm config get registry

# 恢复官方源
npm config set registry https://registry.npmjs.org
```

### 设置缓存

```bash
# 查看缓存位置
npm config get cache

# 清除缓存
npm cache clean --force
```

### 设置代理（如需要）

```bash
# 设置 HTTP 代理
npm config set proxy http://127.0.0.1:7890
npm config set https-proxy http://127.0.0.1:7890

# 删除代理
npm config delete proxy
npm config delete https-proxy
```

## 🛠 常用全局包推荐

### AI 编程工具

```bash
# Claude Code
npm install -g @anthropic-ai/claude-code

# Codex CLI
npm install -g @openai/codex

# OpenClaw
npm install -g openclaw@latest
```

### 开发工具

```bash
# TypeScript
npm install -g typescript ts-node

# 代码格式化
npm install -g prettier

# Lint 工具
npm install -g eslint

# YAML 工具
npm install -g yaml

# JSON 工具
npm install -g json
```

### 实用工具

```bash
# 静态服务器
npm install -g serve

# 文件监听
npm install -g nodemon

# 进程管理
npm install -g pm2
```

## 📝 package.json 详解

### 创建项目

```bash
# 创建新项目
mkdir my-project
cd my-project
npm init -y

# 查看生成的 package.json
cat package.json
```

### package.json 结构

```json
{
  "name": "my-project",
  "version": "1.0.0",
  "description": "项目描述",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "jest"
  },
  "keywords": ["关键词"],
  "author": "作者",
  "license": "MIT",
  "dependencies": {
    "lodash": "^4.17.21"
  },
  "devDependencies": {
    "typescript": "^5.3.0"
  }
}
```

### 版本号规则

```
^4.17.21  → 兼容更新（推荐）
├─ 允许 4.x.x（不改变主版本号）
└─ 例如：4.17.21 → 4.18.0 ✅
           4.17.21 → 5.0.0 ❌

~4.17.21  → 补丁更新
├─ 允许 4.17.x
└─ 例如：4.17.21 → 4.17.22 ✅
           4.17.21 → 4.18.0 ❌

4.17.21   → 精确版本
└─ 锁定，不允许任何更新
```

## ⚠️ 常见问题

### 问题 1：npm install 很慢

```
解决：
1. 使用国内镜像
   npm config set registry https://registry.npmmirror.com

2. 或使用 pnpm / yarn（更快的包管理器）
   npm install -g pnpm
   pnpm install
```

### 问题 2：权限错误

```
错误：EACCES: permission denied

解决：
1. 不要使用 sudo
2. 修改 npm 全局路径
   mkdir ~/.npm-global
   npm config set prefix '~/.npm-global'
   
3. 添加到 PATH
   echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
   source ~/.zshrc
```

### 问题 3：版本冲突

```
错误：peer dep missing

解决：
1. 使用 --legacy-peer-deps
   npm install --legacy-peer-deps

2. 或使用 --force
   npm install --force
```

### 问题 4：node-sass 安装失败

```
解决：
使用 dart-sass 替代
npm uninstall node-sass
npm install sass
```

## 📊 Node.js vs 其他运行时

| 特性 | Node.js | Bun | Deno |
|------|---------|-----|------|
| 包管理器 | npm | bun | 内置 |
| 速度 | 快 | 更快 | 快 |
| 兼容性 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| AI 工具支持 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| 推荐度 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |

**推荐：** AI 编程工具链首选 Node.js。

## 🔗 相关资源

### 官方文档
- [Node.js 官网](https://nodejs.org/) ⭐⭐⭐⭐⭐
- [npm 文档](https://docs.npmjs.com/) ⭐⭐⭐⭐⭐

### 学习资源
- [Node.js 最佳实践](https://github.com/goldbergyoni/nodebestpractices) ⭐⭐⭐⭐

---

**下一步：** [Git 配置 →](./04-git.md)
