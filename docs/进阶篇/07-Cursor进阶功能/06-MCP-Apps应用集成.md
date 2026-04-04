# 06-MCP Apps 应用集成

> MCP Apps 在 Agent 聊天中渲染交互式图表，将复杂数据可视化，让 AI 分析更直观。

---

## 目标

- 📊 理解 MCP Apps 的核心能力
- 🛠️ 掌握 MCP Apps 配置方法
- 📈 了解典型可视化场景

---

## 什么是 MCP Apps

MCP Apps（Model Context Protocol Applications）是 Cursor 3.0 引入的应用集成框架，允许在 AI Agent 聊天中嵌入可交互的应用程序组件。与传统文本回复不同，MCP Apps 可以渲染：

- **交互式图表**：折线图、饼图、柱状图、热力图
- **数据表格**：可排序、可筛选的动态表格
- **代码编辑器**：内置代码片段展示
- **文件预览**：图片、PDF、Markdown 实时预览
- **自定义组件**：根据需求开发专用可视化组件

MCP Apps 的核心理念是：**让 AI 的输出不再局限于文字，而是成为可直接交互的数据分析界面。**

---

## 核心能力

### 交互式图表

Agent 在分析数据时，可以直接渲染可视化图表：

```
Agent: "分析过去三个月的代码提交趋势..."
        ↓
渲染输出：
📊 提交趋势图（可交互）
├── 筛选时间范围
├── 查看具体提交
└── 导出 PNG
```

支持的图表类型：

| 类型 | 适用场景 |
|------|----------|
| 折线图 | 随时间变化的数据（提交量、Bug 数） |
| 饼图 | 占比分析（代码分布、语言占比） |
| 柱状图 | 对比分析（团队成员贡献、模块大小） |
| 热力图 | 分布密度（提交时间、文件修改频率） |
| 树图 | 层级结构（项目结构、依赖关系） |

### 动态数据表格

```
Agent: "显示项目中未解决的 Issue..."
        ↓
渲染输出：
📋 Issue 列表（可筛选排序）
├── 按优先级筛选
├── 按负责人筛选
├── 点击跳转详情
└── 批量操作
```

### 组件嵌入示例

```markdown
# Agent 请求 MCP App 渲染
```mcp
app: charts
type: line
data: commits
x: date
y: count
title: "近三月提交趋势"
interactive: true
```
```

---

## 如何使用 MCP Apps

### 基础调用

在 Agent 对话中，通过特殊标记调用 MCP App：

```bash
# 请求渲染图表
"分析项目依赖，展示依赖关系图 [mcp:dependency-graph]"

# 请求数据表格
"列出所有待修复的 Bug [mcp:issue-table:severity=critical]"

# 请求文件预览
"查看这个 API 文档 [mcp:file-preview:path=docs/api.md]"
```

### MCP App 市场

Cursor 内置 MCP App 市场，可安装社区开发的组件：

```bash
# 查看可用 Apps
/mcp apps list

# 安装 App
/mcp apps install dependency-graph

# 卸载 App
/mcp apps uninstall dependency-graph
```

### 常用官方 Apps

| App | 功能 |
|-----|------|
| `dependency-graph` | 项目依赖可视化 |
| `git-history` | Git 提交历史时间线 |
| `api-tester` | API 接口测试 |
| `db-explorer` | 数据库结构浏览 |
| `perf-flamegraph` | 性能火焰图 |

---

## 自定义 MCP App

### 开发规范

```json
// my-app.json
{
  "name": "my-custom-app",
  "version": "1.0.0",
  "entry": "./dist/index.html",
  "manifest": {
    "height": 400,
    "width": "full",
    "actions": ["refresh", "export"]
  }
}
```

### 与 Agent 交互

```javascript
// index.html
class MyCustomApp {
  async onMessage(message) {
    // 接收 Agent 发送的数据
    const data = message.data;
    // 渲染自定义 UI
    this.render(data);
  }

  sendToAgent(payload) {
    // 向 Agent 发送消息
    this.postMessage({ type: 'response', payload });
  }
}
```

### 注册 App

```bash
# 本地开发
/mcp apps dev ./my-app

# 发布到市场
/mcp apps publish my-custom-app
```

---

## 使用场景

### 场景一：代码质量分析

```
Agent: "分析项目的代码质量..."
        ↓
渲染：
├── 📊 复杂度趋势图（折线图）
├── 📋 问题列表（表格，支持筛选）
├── 🔥 热点文件（热力图）
└── 📄 详细报告（PDF）
```

### 场景二：依赖分析

```
Agent: "分析项目依赖安全..."
        ↓
渲染：
├── 🌲 依赖树（树图）
├── ⚠️ 漏洞标记（红色高亮）
└── 📝 更新建议（列表）
```

### 场景三：性能分析

```
Agent: "分析 App 启动性能..."
        ↓
渲染：
├── 🔥 火焰图（性能可视化）
├── ⏱️ 时间分布（柱状图）
└── 📄 优化建议（卡片）
```

---

## 注意事项

- **Token 消耗**：渲染复杂图表会额外消耗 Token，注意成本控制
- **数据安全**：图表数据来源于项目代码，避免渲染高度敏感信息
- **性能影响**：大量图表同时渲染可能影响 Cursor 响应速度
- **App 来源**：安装第三方 MCP App 时注意来源可信度

---

## 小结

```
✅ MCP Apps - Agent 聊天中的交互式应用
✅ 图表类型：折线图、饼图、柱状图、热力图、树图
✅ 动态表格：可筛选、可排序
✅ MCP App 市场：官方 + 社区组件
✅ 支持自定义开发
```

> 下一步：Team 团队协作功能 →
