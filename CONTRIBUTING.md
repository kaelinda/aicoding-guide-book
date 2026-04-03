# 贡献指南

感谢你对 AI Coding Guide Book 的关注！

---

## 🤝 如何贡献

### 报告问题

如果你发现了错误或有改进建议：

1. 检查 [Issues](https://github.com/kaelinda/aicoding-guide-book/issues) 中是否已有相同问题
2. 如果没有，创建新 Issue：
   - 使用清晰的标题描述问题
   - 详细说明问题出现的位置
   - 提供复现步骤（如适用）
   - 附上截图或代码片段

### 改进文档

1. **Fork 本仓库**

2. **创建分支**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **进行修改**
   - 遵循现有的文档格式
   - 确保代码示例可运行
   - 添加必要的说明

4. **提交更改**
   ```bash
   git add .
   git commit -m "docs: 改进说明"
   ```

5. **推送到 GitHub**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **创建 Pull Request**
   - 描述你的更改
   - 关联相关 Issue

---

## 📝 文档规范

### Markdown 格式

- 使用标准 Markdown 语法
- 代码块指定语言：
  ```swift
  // Swift 代码
  ```
- 使用相对链接：`[链接](./file.md)`
- 标题层级清晰：H1 → H2 → H3

### 代码示例

- 必须可编译运行
- 包含必要的注释
- 遵循语言最佳实践
- 标注版本要求：
  ```swift
  // iOS 17+
  @Observable
  class ViewModel { }
  ```

### 内容要求

- **准确性**：优先引用官方文档
- **清晰性**：简洁明了，避免冗余
- **实用性**：提供可操作的步骤
- **时效性**：标注工具版本

---

## ✅ 审核标准

PR 会被检查以下内容：

- [ ] 内容准确性
- [ ] 代码可运行
- [ ] 格式规范
- [ ] 无敏感信息
- [ ] 链接有效

---

## 📚 信息来源优先级

```
⭐⭐⭐⭐⭐ Tier 1 - 官方文档
├─ Anthropic 官网
├─ OpenAI 官网
├─ Apple Developer
└─ modelcontextprotocol.io

⭐⭐⭐⭐ Tier 2 - GitHub 官方仓库
├─ openai/codex
├─ anthropics/claude-code
└─ openclaw/openclaw

⭐⭐⭐ Tier 3 - 技术社区
├─ Stack Overflow
├─ Medium 技术博客
└─ 掘金、知乎专栏
```

---

## 🎯 贡献类型

### 欢迎的贡献

- ✅ 修正拼写错误
- ✅ 改进说明文字
- ✅ 添加代码示例
- ✅ 补充实战案例
- ✅ 修复失效链接
- ✅ 翻译文档

### 暂不接受的贡献

- ❌ 未经证实的技巧
- ❌ 第三方付费服务推广
- ❌ 与主题无关的内容
- ❌ 包含敏感信息

---

## 📧 联系方式

- **Issues**: [GitHub Issues](https://github.com/kaelinda/aicoding-guide-book/issues)
- **Discussions**: [GitHub Discussions](https://github.com/kaelinda/aicoding-guide-book/discussions)

---

## 📄 许可证

贡献的内容将采用项目的 MIT 许可证。

---

再次感谢你的贡献！🎉
