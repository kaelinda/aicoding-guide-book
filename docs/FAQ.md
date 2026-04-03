# 故障排查指南

> 遇到问题不要慌，这里有解决方案

## 📋 目录

- [环境问题](#环境问题)
- [工具安装问题](#工具安装问题)
- [Claude Code 问题](#claude-code-问题)
- [Cursor 问题](#cursor-问题)
- [Codex 问题](#codex-问题)
- [Git 问题](#git-问题)
- [网络问题](#网络问题)

---

## 环境问题

### ❌ 问题：Homebrew 安装失败

**错误信息：**
```
curl: (7) Failed to connect to raw.githubusercontent.com
```

**解决方案：**

```bash
# 方案 1：使用镜像源
/bin/bash -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"

# 方案 2：手动下载安装脚本
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o install.sh
bash install.sh

# 方案 3：使用代理
export https_proxy=http://127.0.0.1:7890
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

### ❌ 问题：nvm: command not found

**原因：** 环境变量未加载

**解决方案：**

```bash
# 检查 nvm 是否安装
ls -la ~/.nvm

# 如果存在，添加到配置文件
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc

# 重新加载
source ~/.zshrc

# 验证
nvm --version
```

---

### ❌ 问题：Node.js 版本不对

**症状：**
```
node -v
v16.x.x  # 需要 v18+
```

**解决方案：**

```bash
# 查看已安装版本
nvm ls

# 安装 LTS 版本
nvm install --lts

# 使用新版本
nvm use --lts

# 设置默认版本
nvm alias default lts/*

# 验证
node -v
```

---

## 工具安装问题

### ❌ 问题：npm install 很慢或失败

**解决方案：**

```bash
# 方案 1：使用国内镜像
npm config set registry https://registry.npmmirror.com

# 方案 2：使用 pnpm（更快）
npm install -g pnpm
pnpm install -g @anthropic-ai/claude-code

# 方案 3：清除缓存重试
npm cache clean --force
npm install -g package-name

# 方案 4：使用代理
npm config set proxy http://127.0.0.1:7890
npm config set https-proxy http://127.0.0.1:7890
```

---

### ❌ 问题：权限被拒绝

**错误信息：**
```
EACCES: permission denied
```

**解决方案：**

```bash
# ❌ 不要使用 sudo
# sudo npm install -g xxx

# ✅ 正确做法：修改 npm 全局路径
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# 添加到 PATH
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

# 重新安装
npm install -g @anthropic-ai/claude-code
```

---

## Claude Code 问题

### ❌ 问题：认证失败

**错误信息：**
```
Authentication failed
```

**解决方案：**

```bash
# 步骤 1：退出登录
claude --logout

# 步骤 2：清除缓存
rm -rf ~/.claude/cache

# 步骤 3：重新登录
claude

# 如果还是失败，检查订阅状态
# 访问：https://www.anthropic.com/account
```

---

### ❌ 问题：找不到命令

**错误信息：**
```
claude: command not found
```

**解决方案：**

```bash
# 检查安装位置
npm list -g @anthropic-ai/claude-code

# 查找可执行文件
which claude

# 如果找不到，检查 PATH
echo $PATH

# 添加 npm 全局路径
echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# 重新安装
npm install -g @anthropic-ai/claude-code
```

---

### ❌ 问题：响应很慢

**可能原因：**
1. 网络问题
2. 任务太复杂
3. 模型推理慢

**解决方案：**

```bash
# 切换到更快的模型
/model claude-3.5-sonnet

# 简化任务描述
# 把复杂任务拆分成多个小任务

# 检查网络
ping api.anthropic.com

# 使用代理
export https_proxy=http://127.0.0.1:7890
```

---

### ❌ 问题：修改了不该修改的文件

**解决方案：**

```bash
# 方案 1：Git 回退
git checkout -- file.txt

# 方案 2：撤销最近提交
git reset --soft HEAD~1

# 方案 3：查看改动
git diff

# 方案 4：使用 approval 模式
claude --approval interactive
```

---

## Cursor 问题

### ❌ 问题：无法打开 iOS 项目

**原因：** Cursor 本身不能运行 iOS 项目

**解决方案：**

```
正确工作流：

1. 用 Cursor 编写代码
2. 用 Xcode 运行和调试

步骤：
- 在 Cursor 中打开项目文件夹
- 编写代码，AI 辅助
- 在 Xcode 中打开 .xcodeproj
- Cmd + R 运行
```

---

### ❌ 问题：AI 补全不准确

**原因：** 缺少项目上下文

**解决方案：**

```markdown
# 创建 .cursorrules 文件

# 项目配置
## 技术栈
- Swift 5.9
- SwiftUI
- MVVM

## 编码规范
- 使用 4 空格缩进
- 遵循 Swift API 设计指南
```

---

### ❌ 问题：快捷键不生效

**解决方案：**

```
检查快捷键冲突：

1. 打开系统偏好设置 → 键盘 → 快捷键
2. 检查是否有冲突
3. 在 Cursor 中自定义快捷键：
   Cmd + , → 键盘快捷方式
```

---

## Codex 问题

### ❌ 问题：需要 ChatGPT Plus

**错误信息：**
```
Your account doesn't have access to Codex
```

**解决方案：**

```
Codex 需要 ChatGPT Plus / Pro 订阅

订阅步骤：
1. 访问 https://chat.openai.com/subscribe
2. 选择 ChatGPT Plus ($20/月)
3. 完成订阅
4. 重新运行 codex
```

---

### ❌ 问题：API Key 无效

**错误信息：**
```
Invalid API key
```

**解决方案：**

```bash
# 重新生成 API Key
# 访问：https://platform.openai.com/api-keys

# 设置环境变量
export OPENAI_API_KEY=sk-xxx

# 或在配置文件中设置
echo 'export OPENAI_API_KEY=sk-xxx' >> ~/.zshrc
source ~/.zshrc
```

---

## Git 问题

### ❌ 问题：SSH 连接失败

**错误信息：**
```
git@github.com: Permission denied (publickey)
```

**解决方案：**

```bash
# 步骤 1：检查密钥
ls -la ~/.ssh

# 步骤 2：生成新密钥
ssh-keygen -t ed25519 -C "your.email@example.com"

# 步骤 3：启动 SSH agent
eval "$(ssh-agent -s)"

# 步骤 4：添加密钥
ssh-add ~/.ssh/id_ed25519

# 步骤 5：复制公钥
cat ~/.ssh/id_ed25519.pub

# 步骤 6：添加到 GitHub
# Settings → SSH and GPG keys → New SSH key

# 步骤 7：测试连接
ssh -T git@github.com
```

---

### ❌ 问题：合并冲突

**错误信息：**
```
CONFLICT (content): Merge conflict in file.txt
```

**解决方案：**

```bash
# 查看冲突文件
git status

# 打开冲突文件
# <<<<<<< HEAD
# 你的修改
# =======
# 别人的修改
# >>>>>>> branch-name

# 手动解决冲突
# 选择保留的内容，删除标记

# 标记为已解决
git add file.txt

# 完成合并
git commit
```

---

### ❌ 问题：想撤销最近的提交

**解决方案：**

```bash
# 撤销最近一次提交（保留修改）
git reset --soft HEAD~1

# 撤销最近一次提交（丢弃修改）
git reset --hard HEAD~1

# 修改最后一次提交信息
git commit --amend -m "新的提交信息"

# 创建反向提交
git revert commit-hash
```

---

## 网络问题

### ❌ 问题：API 请求超时

**解决方案：**

```bash
# 方案 1：使用代理
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890

# 方案 2：设置超时时间
# 在工具配置中增加超时时间

# 方案 3：切换网络
# 尝试使用手机热点或 VPN
```

---

### ❌ 问题：GitHub 访问慢

**解决方案：**

```bash
# 方案 1：使用镜像
# https://github.com → https://github.com.cnpmjs.org

# 方案 2：修改 hosts
sudo nano /etc/hosts

# 添加：
# 140.82.112.4 github.com
# 199.232.69.194 github.global.ssl.fastly.net

# 方案 3：使用代理
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890
```

---

## 🔍 调试技巧

### 查看详细日志

```bash
# Claude Code 详细日志
claude --verbose

# Codex 详细日志
codex --verbose

# Git 详细日志
GIT_TRACE=1 git command
```

### 清除缓存

```bash
# 清除 npm 缓存
npm cache clean --force

# 清除 Claude Code 缓存
rm -rf ~/.claude/cache

# 清除 Codex 缓存
rm -rf ~/.codex/cache

# 清除 Git 缓存
git gc --prune=now
```

### 环境检查

```bash
# 检查所有工具版本
echo "Node: $(node -v)"
echo "npm: $(npm -v)"
echo "Git: $(git --version)"
echo "Claude: $(claude --version)"
echo "Codex: $(codex --version)"

# 检查路径
echo $PATH

# 检查环境变量
env | grep -E "NODE|NVM|GIT|PROXY"
```

---

## 📚 获取帮助

### 官方支持

- [Claude Code 文档](https://docs.anthropic.com/claude-code)
- [Codex 文档](https://developers.openai.com/codex)
- [Cursor 文档](https://cursor.com/docs)

### 社区支持

- [GitHub Issues](https://github.com/kaelinda/aicoding-guide-book/issues)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/ai-coding)

---

**还没找到答案？** [提交 Issue](https://github.com/kaelinda/aicoding-guide-book/issues)
