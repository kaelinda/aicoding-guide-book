# 04-Cloud Agents 云端代理

> 云端运行 Agent，支持 Computer Use，99.9% 可用性保障，随时随地接入开发。

---

## 目标

- ☁️ 理解 Cloud Agents 的核心优势
- 🖥️ 掌握 Computer Use 云端操作方式
- 🎬 学会录制和回放 Agent 操作视频
- 🛡️ 了解 SLA 保障和服务级别

---

## 什么是 Cloud Agents

Cloud Agents 是 Cursor 推出的云端 AI Agent 服务，将 Agent 的运行环境从本地迁移到云端。与本地 Agent 相比，Cloud Agents 具备以下核心优势：

| 特性 | 本地 Agent | Cloud Agents |
|------|-----------|-------------|
| 可用性 | 依赖本地机器 | 99.9% SLA 保障 |
| 资源 | 受限于本地算力 | 弹性计算资源 |
| 录制 | 需额外配置 | 内置视频录制 |
| 协作 | 单人使用 | 多人共享 |
| 网络 | 需本地翻墙 | 云端直连 |

Cloud Agents 基于分布式云计算架构，在全球多个区域部署节点，自动选择最优路径接入。这意味着即使本地网络不稳定，也可以通过 Cloud Agents 获得流畅的 AI 编程体验。

---

## Computer Use 云端操作

Computer Use 是 Cloud Agents 的核心技术，允许 AI Agent 在云端虚拟机中执行完整的操作——包括打开浏览器、操作桌面应用、执行命令行等。

### 工作原理

```
用户指令 → Cloud Agent（云端）
                ↓
         ┌──────────────────┐
         │  云端虚拟机      │
         │  ├── 浏览器环境   │
         │  ├── 文件系统     │
         │  └── 终端环境     │
         └──────────────────┘
                ↓
         操作录制 → 视频输出
                ↓
         结果回传 → 本地展示
```

### 开启 Cloud Agent

```bash
# 启用云端 Agent
/captain cloud on

# 指定区域（可选）
/captain cloud region us-west

# 查看可用区域
/captain cloud regions
```

### 基础使用

```bash
# 在云端执行任务
/captain cloud run "帮我检查 GitHub 最新的 PR"

# 使用 Computer Use
/captain cloud computer "打开 Safari 访问 cursor.com"
```

---

## 操作视频录制

Cloud Agents 内置视频录制功能，每一次 Agent 执行都会自动生成录制文件，方便回放和分享。

### 录制控制

```bash
# 查看当前录制
/cloud recording status

# 下载当前录制
/cloud recording download

# 列出历史录制
/cloud recording list

# 分享录制链接
/cloud recording share <recording-id>
```

### 典型使用场景

- **Code Review**：录制 PR 审查过程，团队成员可回看 AI 的审查逻辑
- **Bug 定位**：录制 Agent 定位 Bug 的过程，方便开发人员理解
- **培训教学**：录制完整开发流程，作为新成员培训素材
- **进度汇报**：向非技术人员展示 AI 辅助开发的成果

### 录制隐私设置

```json
{
  "cloud": {
    "recording": {
      "enabled": true,
      "autoDelete": 7,          // 7 天后自动删除
      "excludePatterns": [     // 排除敏感内容
        "**/credentials.json",
        "**/*.key"
      ],
      "blurSensitive": true     // 模糊敏感输入
    }
  }
}
```

---

## 可用性保障

### SLA 服务级别

Cloud Agents 提供 99.9% 可用性保障，具体承诺：

| 指标 | 承诺值 |
|------|--------|
| 月度可用性 | 99.9% |
| 平均响应时间 | < 500ms |
| Agent 启动时间 | < 10s |

### 故障处理

```bash
# 查看服务状态
/cloud status

# 切换备用节点
/cloud failover

# 提交工单
/cloud support ticket
```

### 缓存与离线

Cloud Agents 支持操作缓存，即使短暂断网也能继续工作：

```json
{
  "cloud": {
    "cache": {
      "enabled": true,
      "maxSize": "1GB",
      "syncInterval": "5m"
    }
  }
}
```

---

## 使用注意事项

- **数据安全**：云端操作会传输代码内容，确保项目不在禁止云端处理的合规范围内
- **成本计费**：Cloud Agents 按使用时长计费，长时间任务注意成本控制
- **区域延迟**：不同区域节点延迟差异明显，建议选择物理距离较近的区域
- **敏感数据**：录制功能默认包含屏幕内容，避免在录制期间处理高度敏感信息

---

## 小结

```
✅ Cloud Agents - 云端 Agent 运行环境
✅ Computer Use - 云端虚拟机完整操作
✅ 内置视频录制 - 方便回放和分享
✅ 99.9% SLA - 高可用性保障
✅ 全球多节点 - 自动选择最优接入
```

> 下一步：Bugbot 自动修复 Bug →
