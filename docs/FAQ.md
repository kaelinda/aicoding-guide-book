# 故障排查指南

> 按"出问题时你在想什么"分组。找不到你的问题？`Ctrl/Cmd + F` 搜关键词，或 [提交 issue](https://github.com/kaelinda/aicoding-guide-book/issues)。

## 📋 按场景快速定位

| 你遇到的情况 | 看哪节 |
|------|------|
| 装不上 / 命令找不到 / PATH 问题 | [1. 安装与环境](#1-安装与环境) |
| 登录不上 / 认证失败 / API Key 无效 | [2. 登录与认证](#2-登录与认证) |
| 不知道怎么计费 / 要不要升订阅 / 额度怎么看 | [3. 账单与额度](#3-账单与额度) |
| AI 输出不对 / 响应慢 / 改错文件 / 幻觉 API | [4. 生成质量](#4-生成质量) |
| Xcode / 签名 / 模拟器 / Swift 专属 | [5. iOS 特有](#5-ios-特有) |
| 多人协作 / 共享配置 / PR review | [6. 团队协作](#6-团队协作) |
| Git 操作 / 网络代理 | [7. Git 与网络](#7-git-与网络) |
| 任何时候都能用的调试套路 | [🔍 调试技巧](#-调试技巧) |

---

## 1. 安装与环境

### ❌ Homebrew 安装失败

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

### ❌ `nvm: command not found`

**原因**：环境变量未加载。

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

### ❌ Node.js 版本不对

**症状**：`node -v` 低于 v20（书里默认 v20 LTS）。

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

### ❌ `npm install` 很慢或失败

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

### ❌ npm `EACCES: permission denied`

**不要** `sudo npm install -g`。正确做法：

```bash
# 修改 npm 全局路径
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# 添加到 PATH
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc

# 重新安装
npm install -g @anthropic-ai/claude-code
```

---

### ❌ `claude: command not found`（装过了但找不到）

先诊断，再动手：

```bash
# 1. 确认是否真的装了
npm list -g @anthropic-ai/claude-code

# 2. 查可执行文件在哪
which claude

# 3. 查 PATH 里有没有 npm 全局目录
echo $PATH
npm config get prefix  # 应该在 PATH 里

# 4. 如果缺，加进去
echo 'export PATH="$(npm config get prefix)/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# 5. 还不行再重装
npm install -g @anthropic-ai/claude-code
```

---

### ❌ Cursor / Claude Code 快捷键不生效

```
检查快捷键冲突：

1. 打开系统偏好设置 → 键盘 → 快捷键
2. 检查是否有冲突（输入法切换、聚焦、截图都常冲突）
3. 在工具内自定义：
   - Cursor: Cmd+, → 键盘快捷方式
   - Claude Code: ~/.claude/keybindings.json
```

---

## 2. 登录与认证

### ❌ Claude Code 认证失败

先诊断："是网络问题 / 订阅过期 / 本地 cache 坏了？" 别一上来就重装。

```bash
# 1. 检查当前登录状态
claude --version   # 看版本
# 在交互里试：/login 会显示账号或报错

# 2. 检查订阅
# 访问 https://www.anthropic.com/account 确认订阅是否有效

# 3. 检查网络（是否能到 api）
curl -I https://api.anthropic.com

# 以上都 OK，再清 cache + 重登
claude --logout
rm -rf ~/.claude/cache   # 谨慎：只清 cache 不要删整个 ~/.claude
claude
```

---

### ❌ Codex: "Your account doesn't have access"

Codex 需要 ChatGPT Plus / Pro 订阅：

```
1. 访问 https://chat.openai.com/subscribe
2. 选择 Plus（$20/月）或 Pro 更高阶
3. 完成订阅
4. 重新运行 codex login
```

---

### ❌ Codex `Invalid API key`

```bash
# 1. 确认 key 没过期或被吊销
#    访问 https://platform.openai.com/api-keys

# 2. 确认 env 变量真的加载了
echo "$OPENAI_API_KEY" | head -c 10  # 应该看到前 10 位

# 3. 如果是空的，说明 shell 没加载
export OPENAI_API_KEY=sk-xxx

# 4. 持久化
echo 'export OPENAI_API_KEY=sk-xxx' >> ~/.zshrc
source ~/.zshrc
```

> ⚠️ 不要把 API Key 直接写进代码或 commit 进 git。用环境变量 / 系统 Keychain / 1Password CLI 管理。

---

## 3. 账单与额度

### ❓ Claude Code 怎么看我用了多少钱？

**用订阅**（Pro / Max / Team / Enterprise）：

- 看 <https://www.anthropic.com/account> 的 usage 面板
- 订阅是固定额度，超了就限流直到下个周期，**不会"爆金币"**

**用 API Key**（按量计费）：

- 看 <https://console.anthropic.com/settings/billing>
- 设置**预算告警**（billing alerts），防止写 bug 烧钱

**会话内查看近似消耗**（Claude Code 交互式）：

```
/cost   # 查看本会话的估算 token 消耗
```

---

### ❓ Claude Pro / Max / API 我该选哪个

| 用法 | 推荐 |
|------|------|
| 每周几次，主要做讨论和小项目 | Pro（$20/mo） |
| 每天重度使用，常跑 Claude Code | Max（Anthropic 面向重度用户的订阅） |
| 做 SaaS、需要在自己服务里调用 Claude | API Key（按 token 计费） |
| 团队一起用，需要共享计费 / 管理后台 | Team / Enterprise |

**我的经验**：先 Pro 一个月摸清用量，超限多了再升 Max。

---

### ❓ Codex 额度怎么看

- 额度显示在 <https://chat.openai.com/> 的账号面板
- Pro 比 Plus 宽松很多；Team 有共享池
- 开长会话 / 用 `--agent` 模式时额度消耗快，随时留意

---

### ❓ 省 token 的几个常识

- 开新 session 而不是把一个 session 拖很长（长上下文越往后越贵）
- 用 `/compact` 或 `/clear` 压缩历史
- 简单问题别挂 `--think-hard` / `ultrathink` 标志
- 用 Haiku 处理"读 / 找 / 简单改"，Sonnet/Opus 处理决策和复杂生成

---

## 4. 生成质量

### ❌ Claude Code 响应很慢

**可能原因**：网络、任务太复杂、模型本身慢。

```bash
# 切换到更快的模型（haiku/sonnet 比 opus 快）
/model

# 开 fast 模式（opus 4.6）
/fast

# 简化任务描述，把复杂任务拆小步
# 把长上下文清掉再开一轮
/clear

# 检查网络
ping api.anthropic.com

# 用代理
export https_proxy=http://127.0.0.1:7890
```

---

### ❌ Claude Code 改了不该改的文件

```bash
# 1. 先看改了什么（不要慌，先诊断）
git status
git diff

# 2. 选择性撤销
git checkout -- path/to/unwanted-file.swift

# 3. 如果已经 commit 了
git reset --soft HEAD~1      # 撤销 commit 保留改动
git reset --hard HEAD~1      # 撤销 commit 丢弃改动（谨慎）

# 4. 下次防护：
#   - 在 CLAUDE.md 写明"不要修改 xxx 目录"
#   - 使用 plan mode 让它先说再做
#   - 用 freeze 限制只能改某个目录
```

---

### ❌ Cursor AI 补全不准确

**原因**：缺少项目上下文。写 `.cursorrules`：

```markdown
# 项目配置

## 技术栈
- Swift 5.9
- SwiftUI
- MVVM

## 编码规范
- 使用 4 空格缩进
- 遵循 Swift API 设计指南
- 命名用 camelCase
- 不要引入新依赖（讨论后再加）
```

---

### ❌ AI 编的 API 不存在（幻觉）

**症状**：AI 写了一个看起来很合理的函数调用，但编译器报错"cannot find in scope"。

**应对**：

1. **让 AI 自己承认边界**：
   ```text
   这个 API 你确定 iOS 17 能用吗？请给出 Apple 官方文档链接，
   找不到就告诉我你不确定。
   ```

2. **限定信息来源**：
   ```text
   在动手之前，先通过 Context7 MCP 查 SwiftUI 官方文档，
   确认这个 API 签名。
   ```

3. **先测后用**：把可疑 API 放进一个最小文件 `xcrun swift build` 验证。

4. **用 `Grep` 确认项目里自己是否定义过**（别假设它是系统 API）。

---

### ❌ AI 生成的代码编译不过

大概率属于这几类：

- **语法陈旧**：用了 Swift 4 写法，项目是 Swift 5.9+ → 让它按 `@MainActor` / `async/await` 重写
- **API 版本不匹配**：用了 iOS 18 的 API，项目最低 iOS 17 → 在 prompt 里钉死 "iOS 17+ 兼容"
- **依赖没引入**：调了第三方库但没改 Package.swift / Podfile → 让它一起改
- **幻觉 API** → 见上一条

---

## 5. iOS 特有

### ❌ Cursor 无法打开 / 运行 iOS 项目

**原因**：Cursor 是 VSCode 衍生，不是 Xcode。它不能替代 Xcode 做编译、签名、调试。

正确工作流：

```
1. 用 Cursor / Claude Code 写代码
2. 用 Xcode 构建、运行、调试、签名
3. 两边同时开着，代码改动自动同步
```

---

### ❌ Xcode 签名 / 证书问题，想让 AI 帮忙

AI 没法直接操作 Xcode GUI，但可以：

- **看 `*.xcodeproj/project.pbxproj` 里的签名配置**，告诉你哪个 target 的 team / provisioning profile 写错
- **解析签名错误日志**：把 `xcodebuild` 的完整报错贴给它
- **生成 fastlane / match 配置**：如果你走 CI 签名，AI 可以生成 `Fastfile` 和 `Matchfile`

典型 prompt：

```text
xcodebuild 报错如下，请先判断是 code signing / provisioning / entitlement 哪一类问题：
<贴完整错误日志>
不要猜，只看日志里提到的具体文件。
```

---

### ❌ iOS 模拟器一直转圈 / 跑不起来

AI 能做的：帮你写个"重置模拟器"脚本，不是替你点按钮。

```bash
# 保底重置脚本（AI 可以帮你写 / 解释）
xcrun simctl shutdown all
xcrun simctl erase all
killall Simulator
open -a Simulator
```

如果是特定设备类型跑不起来，检查：

- Xcode 和 iOS 版本匹配（Xcode 15 跑 iOS 18 模拟器会挂）
- `/Library/Developer/CoreSimulator/` 磁盘满了（常见）

---

### ❌ iOS 项目已存在，让 AI 接手怎么开工

别直接丢一句"帮我改这个项目"。走这套流程：

```text
不要改代码。先做三件事：

1. 列出 Podfile / Package.swift / project.pbxproj 里的主要依赖和版本
2. 走一遍 AppDelegate / SceneDelegate / 入口 View，画出启动流程
3. 找出 3 个"改动最危险"的模块（路由、网络层、登录态）

完成后我再决定从哪里开工。
```

这套流程在 [实战篇/01-11-完整项目实战](实战篇/01-ClaudeCode实战/11-ClaudeCode完整项目实战.md) 里有完整示范。

---

## 6. 团队协作

### ❓ `.cursorrules` / `CLAUDE.md` 怎么在团队里共享

**规则文件入 git**，像代码一样 review：

```
项目根/
├── CLAUDE.md          # Claude Code 项目级规则，团队共享
├── .cursorrules       # Cursor 项目级规则，团队共享
└── .claude/
    ├── commands/      # 团队共享的 slash command
    ├── agents/        # 团队共享的 subagent 定义
    └── settings.json  # 只入 git 非敏感部分（见 settings.local.json）
```

**个人覆盖**走：

- `~/.claude/CLAUDE.md`（个人全局）
- `.claude/settings.local.json`（项目内个人配置，加入 `.gitignore`）

---

### ❓ AI 生成的 PR 怎么 review

当作"新来的实习生写的 PR"来 review。额外重点：

- 看它改了哪些**它没被要求改的文件**（常见问题）
- 看它**删了哪些代码 / 测试**（比新增更危险）
- 用 [05-CodeReview 模板](examples/prompts/05-CodeReview模板.md) 跑一次独立 review session（换另一个 AI 或人）

---

### ❓ 多人同时改 `.claude/commands/` 冲突怎么办

- 命令按**功能命名**而不是按作者命名：`review.md` 比 `zhou-review.md` 好
- 一个命令一个文件，避免合并冲突
- 有争议时：保留两个版本，`review-quick.md` / `review-deep.md`

---

## 7. Git 与网络

### ❌ SSH 连接 GitHub 失败

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

### ❌ 合并冲突

```bash
# 查看冲突文件
git status

# 打开冲突文件手动解决
# <<<<<<< HEAD ... ======= ... >>>>>>> branch

# 标记已解决
git add file.txt

# 完成合并
git commit
```

> 💡 让 AI 帮你解决冲突：把 `git diff :1:file` / `:2:file` / `:3:file`（base/ours/theirs）三份贴给它，让它**解释各版本意图**再决定保哪边。不要让它盲目"合并"。

---

### ❌ 想撤销最近的提交

```bash
# 撤销最近一次提交（保留修改）
git reset --soft HEAD~1

# 撤销最近一次提交（丢弃修改）⚠️ 不可恢复
git reset --hard HEAD~1

# 修改最后一次提交信息
git commit --amend -m "新的提交信息"

# 创建反向提交（已 push 的安全做法）
git revert <commit-hash>
```

---

### ❌ API 请求超时 / GitHub 访问慢

```bash
# 通用代理
export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890

# Git 专用代理
git config --global http.proxy http://127.0.0.1:7890
git config --global https.proxy http://127.0.0.1:7890

# npm 代理
npm config set proxy http://127.0.0.1:7890
npm config set https-proxy http://127.0.0.1:7890

# 用完记得去除
git config --global --unset http.proxy
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
GIT_TRACE=1 git <command>
```

### 清除缓存

```bash
# npm
npm cache clean --force

# Claude Code
rm -rf ~/.claude/cache

# Codex
rm -rf ~/.codex/cache

# Git 本地 gc
git gc --prune=now
```

### 一键环境体检

```bash
echo "Node: $(node -v)"
echo "npm: $(npm -v)"
echo "Git: $(git --version)"
echo "Claude: $(claude --version 2>/dev/null || echo 'not installed')"
echo "Codex: $(codex --version 2>/dev/null || echo 'not installed')"

echo "---"
echo "PATH: $PATH"

echo "---"
env | grep -E "NODE|NVM|GIT|PROXY|ANTHROPIC|OPENAI" | sed 's/\(KEY=\).*/\1<redacted>/'
```

---

## 📚 获取帮助

### 官方支持

- [Claude Code 文档](https://docs.claude.com/claude-code)
- [Codex 文档](https://developers.openai.com/codex)
- [Cursor 文档](https://cursor.com/docs)

### 社区支持

- [本书 Issues](https://github.com/kaelinda/aicoding-guide-book/issues)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/ai-coding)

---

**还没找到答案？** [提交 Issue](https://github.com/kaelinda/aicoding-guide-book/issues)，附上：

1. 你在哪一步卡住
2. 完整报错（别截图，贴文本）
3. 你的环境：`macOS 版本 / Xcode / Node / 工具版本`
4. 你已经尝试过的解法
