# Giscus 配置快速指南

## 第一步：启用 GitHub Discussions

1. 访问仓库设置页面：
   ```
   https://github.com/kaelinda/aicoding-guide-book/settings
   ```

2. 在 "Features" 部分，勾选 "Discussions"

## 第二步：安装 Giscus App

1. 访问 Giscus App 安装页面：
   ```
   https://github.com/apps/giscus
   ```

2. 点击 "Install" 或 "Configure"

3. 选择 "Only select repositories"

4. 选择 `aicoding-guide-book` 仓库

5. 点击 "Install" 或 "Save"

## 第三步：获取配置参数

1. 访问 Giscus 配置页面：
   ```
   https://giscus.app/zh-CN
   ```

2. 在 "配置" 部分填写：
   - **仓库**：`kaelinda/aicoding-guide-book`
   - **页面 ↔️ Discussions 映射关系**：选择 "pathname"
   - **Discussion 分类**：选择 "Announcements"

3. 向下滚动到 "启用 giscus" 部分，找到生成的代码

4. 复制以下两个参数：
   - `data-repo-id`: 类似 `R_kgDO...` 的字符串
   - `data-category-id`: 类似 `DIC_kwDO...` 的字符串

## 第四步：更新模板文件

编辑 `_layouts/website/page.html`，替换以下占位符：

```html
data-repo-id="REPO_ID_PLACEHOLDER"          ← 替换为你的 repo-id
data-category-id="CATEGORY_ID_PLACEHOLDER"  ← 替换为你的 category-id
```

## 第五步：测试和部署

```bash
# 进入项目目录
cd ~/.openclaw/workspace-guide/aicoding-guide-book

# 本地测试
gitbook serve
# 访问 http://localhost:4000 验证评论区

# 构建并部署
gitbook build
git add .
git commit -m "feat: 添加 Giscus 评论区"
git push origin main
```

## 常见问题

### Q: 评论区不显示？
A: 检查：
1. 仓库是否公开
2. Discussions 是否启用
3. Giscus App 是否已授权
4. repo-id 和 category-id 是否正确

### Q: 如何禁用特定页面的评论？
A: 在页面的 frontmatter 中添加：
```yaml
---
giscus: false
---
```
然后修改模板以支持此功能（参考技术方案文档）。

### Q: 如何自定义主题？
A: 修改模板中的 `data-theme` 属性：
- `light` - 浅色
- `dark` - 深色
- `preferred_color_scheme` - 跟随系统（默认）
- 自定义 CSS 主题 URL

## 需要帮助？

- Giscus 文档：https://github.com/giscus/giscus/blob/main/ADVANCED-USAGE.md
- GitHub Discussions：https://docs.github.com/en/discussions
