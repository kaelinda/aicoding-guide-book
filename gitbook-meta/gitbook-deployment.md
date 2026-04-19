# GitBook 部署指南

## 方式一：GitBook.com（推荐）

### 步骤 1：注册 GitBook 账号

访问 https://www.gitbook.com 注册账号

### 步骤 2：导入 GitHub 仓库

1. 点击「New space」
2. 选择「Sync with GitHub」
3. 授权 GitHub 访问
4. 选择 `aicoding-guide-book` 仓库
5. 点击「Import」

### 步骤 3：配置构建设置

GitBook 会自动检测 `SUMMARY.md` 和 `book.json`

### 步骤 4：发布

点击「Publish」按钮，GitBook 会自动构建和发布

**访问地址**：`https://your-username.gitbook.io/aicoding-guide-book`

---

## 方式二：GitHub Pages

### 步骤 1：安装 GitBook CLI

```bash
npm install -g gitbook-cli
```

### 步骤 2：本地构建

```bash
cd aicoding-guide-book
gitbook install
gitbook build
```

构建产物在 `_book/` 目录

### 步骤 3：推送到 gh-pages 分支

```bash
git checkout -b gh-pages
cp -r _book/* .
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages
```

### 步骤 4：启用 GitHub Pages

1. 进入仓库 Settings → Pages
2. Source 选择 `gh-pages` 分支
3. 保存

**访问地址**：`https://kaelinda.github.io/aicoding-guide-book`

---

## 方式三：自动部署（GitHub Actions）

### 创建工作流

```yaml
# .github/workflows/gitbook.yml
name: Deploy GitBook to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '20'
    
    - name: Install GitBook CLI
      run: npm install -g gitbook-cli
    
    - name: Install plugins
      run: gitbook install
    
    - name: Build GitBook
      run: gitbook build
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./_book
```

推送后自动构建和部署！

---

## 方式四：Vercel/Netlify

### Vercel 部署

1. 连接 GitHub 仓库
2. Build Command: `gitbook build`
3. Output Directory: `_book`
4. 点击 Deploy

### Netlify 部署

1. 连接 GitHub 仓库
2. Build Command: `gitbook build`
3. Publish directory: `_book`
4. 点击 Deploy site

---

## 注意事项

### 1. 路径问题

当前项目的图片和链接使用相对路径，GitBook 可以正常解析。

### 2. Mermaid 图表

GitBook 默认不支持 Mermaid，需要：

**方案 A**：使用插件
```json
{
  "plugins": ["mermaid-gb3"]
}
```

**方案 B**：转换为图片
```bash
# 使用 mermaid-cli 转换
npm install -g @mermaid-js/mermaid-cli
mmdc -i diagram.mmd -o diagram.png
```

### 3. 中文字体

`book.json` 已配置中文字体支持

### 4. 代码高亮

GitBook 默认支持代码高亮，无需额外配置

---

## 目录结构要求

GitBook 需要以下结构：

```
aicoding-guide-book/
├── README.md          # 首页
├── SUMMARY.md         # 目录（必需）
├── book.json          # 配置（可选）
├── .gitbook.yaml      # GitBook 配置（可选）
├── styles/
│   └── website.css    # 自定义样式
├── docs/              # 文档目录
│   ├── 基础篇/
│   ├── 进阶篇/
│   └── ...
└── resources/         # 资源文件
```

---

## 推荐方案

### 个人用户：GitBook.com
- ✅ 免费，易于使用
- ✅ 自动同步 GitHub
- ✅ 自定义域名
- ✅ SEO 优化

### 团队用户：GitHub Pages + Actions
- ✅ 完全免费
- ✅ 自动部署
- ✅ 自定义域名
- ✅ 版本控制

### 企业用户：私有部署
- ✅ 完全控制
- ✅ 内网访问
- ✅ 自定义功能
- ✅ 数据安全

---

## 下一步

1. 选择部署方式
2. 创建必要文件（已完成）
3. 推送到 GitHub
4. 配置自动部署
5. 访问在线文档

---

**推荐使用 GitBook.com，最快 5 分钟完成部署！**
