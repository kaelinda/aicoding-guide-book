# Claude Code 环境配置

> 让 Claude Code 适配你的模型、API 和工作流

## 🎯 这章解决什么问题

很多人装好 Claude Code 后，只会用默认配置。但实际项目中：

- 你可能有多个 API Key（公司/个人）
- 你可能用第三方模型（Azure、Ollama、LiteLLM）
- 你可能需要自定义模型参数（temperature、max_tokens）
- 你可能在国内需要配置代理

这章就是解决这些配置问题。

---

## 章节导航

- [01-环境变量配置](./01-环境变量配置.md) — API Key、Base URL、代理、企业认证
- [02-自定义模型配置](./02-自定义模型配置.md) — 第三方模型、企业部署、模型别名
- [03-配置文件详解](./03-配置文件详解.md) — settings.json 完整字段说明

## 学习路径

建议按顺序阅读：

1. 先了解环境变量，这是最直接的配置方式
2. 再看自定义模型，了解如何接入第三方 provider
3. 最后掌握 settings.json 的完整配置能力

---

## 🔧 配置方式概览

Claude Code 有两种配置方式：

### 方式 1：环境变量（临时 / 项目级）

```bash
# 临时生效
export ANTHROPIC_API_KEY=sk-xxx

# 项目级（写入 .claude/settings.local.json）
```

### 方式 2：settings.json（推荐）

```json
{
  "env": {
    "ANTHROPIC_API_KEY": "sk-xxx"
  }
}
```

**优先级：**
```
Local settings > Project settings > User settings > Managed settings
```

---

## ⚠️ 重要前提

Claude Code 的配置字段在不断更新，以下内容基于 **v2.1.x** 版本（最后同步：2026-04-13）。

建议定期检查官方文档：
- [官方环境变量文档](https://code.claude.com/docs/en/env-vars)
- [官方设置文档](https://docs.anthropic.com/zh-CN/docs/claude-code/settings)
- [官方模型配置](https://docs.anthropic.com/en/docs/claude-code/model-config)

---

## 📚 相关资源

| 资源 | 链接 |
|------|------|
| Claude Code 官方文档 | [docs.anthropic.com/claude-code](https://docs.anthropic.com/zh-CN/docs/claude-code/settings) |

> 💡 LLM 网关（LiteLLM / OpenRouter）、Azure AI Foundry、AWS Bedrock 的专题接入指南仍在撰写中，见 `TODO.md`。
