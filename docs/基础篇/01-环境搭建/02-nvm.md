# nvm 安装 - Node.js 版本管理

> 像管理 App 版本一样管理 Node.js 版本

## 🤔 为什么需要 nvm

Node.js 更新很快，不同项目可能需要不同版本：

```
项目 A → 需要 Node.js 18
项目 B → 需要 Node.js 20
全局工具 → 想用最新版 Node.js 22
```

如果没有版本管理器，你会遇到：
- 版本冲突
- 权限问题（sudo 安装）
- 切换版本麻烦

**nvm (Node Version Manager)** 解决这些问题。

## 📦 安装 nvm

### 方法一：官方脚本安装（推荐）

```bash
# 使用 curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# 或使用 wget
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

### 方法二：通过 Homebrew 安装

```bash
brew install nvm
```

安装后需要手动配置环境变量：

```bash
# 创建 nvm 工作目录
mkdir ~/.nvm

# 添加到配置文件
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"' >> ~/.zshrc

# 使配置生效
source ~/.zshrc
```

### 验证安装

```bash
nvm --version
```

看到版本号（如 `0.39.7`）就表示成功。

## 🎯 基本使用

### 安装 Node.js

```bash
# 安装最新 LTS 版本（推荐）
nvm install --lts

# 安装最新版本
nvm install node

# 安装指定版本
nvm install 18.19.0
nvm install 20.11.0

# 查看可安装的版本
nvm ls-remote
nvm ls-remote --lts  # 只看 LTS 版本
```

### 切换版本

```bash
# 查看已安装版本
nvm ls

# 切换到指定版本
nvm use 18.19.0

# 切换到最新版本
nvm use node

# 切换到 LTS 版本
nvm use --lts
```

### 设置默认版本

```bash
# 设置默认版本（新终端窗口会使用这个版本）
nvm alias default 18.19.0

# 或设置默认使用 LTS
nvm alias default lts/*
```

### 查看当前版本

```bash
# 当前使用的版本
nvm current

# Node.js 版本
node -v

# npm 版本
npm -v
```

## 💡 项目级版本管理

在项目根目录创建 `.nvmrc` 文件：

```bash
# 创建 .nvmrc
echo "18.19.0" > .nvmrc
```

之后进入项目目录时，只需：

```bash
# 自动使用 .nvmrc 指定的版本
nvm use

# 或配置自动切换（见进阶配置）
```

## 🔧 进阶配置

### 自动切换版本

在 `~/.zshrc` 中添加：

```bash
# 自动加载 .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

这样每次进入项目目录，会自动切换到对应的 Node.js 版本。

### 加速下载

默认从 nodejs.org 下载，速度可能较慢。可以设置镜像：

```bash
# 设置 Node.js 镜像
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node

# 或添加到配置文件
echo 'export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node' >> ~/.zshrc
source ~/.zshrc
```

## ⚠️ 常见问题

### 问题 1：nvm: command not found

**原因：** 环境变量未加载

**解决：**

```bash
# 重新加载配置
source ~/.zshrc

# 或重新打开终端
```

如果还不行，检查 `~/.zshrc` 是否包含 nvm 配置：

```bash
cat ~/.zshrc | grep nvm
```

应该看到类似：

```
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

### 问题 2：安装 Node.js 很慢

**解决：** 使用镜像（见上方"加速下载"）

### 问题 3：全局安装的包找不到了

**原因：** 每个 Node.js 版本有独立的包目录

**解决：** 重新安装全局包，或使用 `npm install -g` 时指定版本

```bash
# 查看全局包
npm list -g --depth=0

# 重新安装常用工具
nvm use 18
npm install -g typescript ts-node
```

### 问题 4：zsh 启动变慢

**原因：** nvm 初始化较慢

**解决：** 延迟加载 nvm

```bash
# 在 ~/.zshrc 中替换原有的 nvm 配置为：
export NVM_DIR="$HOME/.nvm"
# 延迟加载
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
}
```

## 📚 管理全局包

### 查看全局包

```bash
npm list -g --depth=0
```

### 常用全局包推荐

```bash
# npm 自升级
npm install -g npm@latest

# 常用工具
npm install -g yarn pnpm
npm install -g typescript ts-node
npm install -g nodemon
npm install -g @anthropic-ai/claude-code  # Claude Code CLI
npm install -g @openai/codex              # Codex CLI
```

## ✅ 小结

- nvm 是 Node.js 版本管理器
- 可以安装多个版本并快速切换
- `.nvmrc` 文件可以实现项目级版本管理
- 可以配置镜像加速下载

## 🔗 相关资源

- [nvm GitHub](https://github.com/nvm-sh/nvm)
- [Node.js 官网](https://nodejs.org/)
- [Node.js 镜像](https://npmmirror.com/)

---

**下一步：** [Node.js 配置 →](./03-nodejs.md)
