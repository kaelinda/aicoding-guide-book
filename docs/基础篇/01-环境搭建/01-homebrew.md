# Homebrew 安装

> macOS 上的包管理器，开发者的"应用商店"

## 🤔 什么是 Homebrew

Homebrew 是 macOS 上最流行的包管理器。简单说：

```bash
# 没有 Homebrew
1. 打开浏览器
2. 搜索软件官网
3. 下载 .dmg 文件
4. 双击安装
5. 拖到 Applications

# 有 Homebrew
brew install 软件名
# 搞定！
```

## 📦 安装 Homebrew

### 步骤 1：打开终端

- 按 `Cmd + 空格` 打开 Spotlight
- 输入 `Terminal` 或 `终端`
- 回车打开

### 步骤 2：执行安装命令

复制以下命令，粘贴到终端，回车：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 步骤 3：等待安装

安装过程需要：
- 下载安装脚本
- 安装 Command Line Tools (如果未安装)
- 配置环境变量

**预计时间：** 5-15 分钟（取决于网络速度）

### 步骤 4：配置环境变量（M1/M2/M3 芯片）

如果你使用的是 Apple Silicon 芯片（M1/M2/M3），需要额外配置：

```bash
# 添加到 shell 配置文件
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 步骤 5：验证安装

```bash
brew --version
```

看到版本号就表示安装成功：

```
Homebrew 4.x.x
Homebrew/homebrew-core (git revision xxx; last commit xxx)
```

## 🎯 基本使用

### 搜索软件

```bash
# 搜索 node 相关的包
brew search node

# 搜索结果示例
==> Formulae
node ✔        node@14       node@16       node@18       node@20       node_exporter
node-build    node@15       node@17       node@19       nodebrew      nodejs

==> Casks
nodebox       nodeclipse
```

### 安装软件

```bash
# 安装最新版 node
brew install node

# 安装指定版本
brew install node@18
```

### 更新软件

```bash
# 更新 Homebrew 自己
brew update

# 升级所有已安装的软件
brew upgrade

# 升级指定软件
brew upgrade node
```

### 卸载软件

```bash
brew uninstall node
```

### 查看已安装

```bash
brew list
```

## 🔧 常用软件推荐

安装完 Homebrew 后，可以先安装这些常用工具：

```bash
# Git - 版本控制（macOS 自带，但版本可能较旧）
brew install git

# wget - 下载工具
brew install wget

# tree - 目录树显示
brew install tree

# jq - JSON 处理
brew install jq
```

## ⚠️ 常见问题

### 问题 1：安装速度很慢

**原因：** 默认源在国外，网络慢。

**解决：** 更换国内镜像源

```bash
# 更换 brew.git
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

# 更换 homebrew-core.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

# 更新
brew update
```

### 问题 2：权限被拒绝

**错误信息：**
```
Error: Permission denied @ dir_s_mkdir
```

**解决：**
```bash
# 不要使用 sudo！正确的做法是修复权限
sudo chown -R $(whoami) $(brew --prefix)/*
```

### 问题 3：Command Line Tools 安装失败

**解决：** 手动安装

```bash
xcode-select --install
```

会弹出安装窗口，按提示完成。

### 问题 4：brew command not found

**原因：** 环境变量未配置

**解决：**

```bash
# Apple Silicon (M1/M2/M3)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile

# Intel 芯片
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

## 📚 进阶技巧

### 使用 Brewfile 管理软件

创建 `Brewfile` 记录所有安装的软件：

```bash
# 生成当前软件列表
brew bundle dump

# 查看内容
cat Brewfile

# 在新机器上一键安装
brew bundle
```

### 清理旧版本

```bash
# 清理旧版本的软件包
brew cleanup

# 查看会清理什么（不实际执行）
brew cleanup -n
```

### 服务管理

一些软件需要作为服务运行：

```bash
# 安装 MySQL
brew install mysql

# 启动服务
brew services start mysql

# 停止服务
brew services stop mysql

# 重启服务
brew services restart mysql

# 查看所有服务
brew services list
```

## ✅ 小结

- Homebrew 是 macOS 的包管理器
- 安装简单，一行命令搞定
- M 系列芯片需要配置环境变量
- 可以更换国内镜像源加速

## 🔗 相关资源

- [Homebrew 官网](https://brew.sh/)
- [Homebrew 文档](https://docs.brew.sh/)
- [清华镜像源](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)

---

**下一步：** [安装 nvm →](./02-nvm.md)
