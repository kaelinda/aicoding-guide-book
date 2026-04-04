# 05-Bugbot 自动修复

> Bugbot Autofix 自动定位并修复 Bug，一键创建 PR 并自动合并，让 Bug 修复流程零人工干预。

---

## 目标

- 🐛 理解 Bugbot 的工作原理
- 🔧 掌握 Autofix 使用流程
- 🔀 了解自动 PR 创建与合并机制
- ⚙️ 学会配置合并规则

---

## 什么是 Bugbot

Bugbot 是 Cursor 内置的自动化 Bug 修复工具，核心能力是**自动定位问题根因并生成修复代码**。与传统 AI 辅助修复不同，Bugbot 采用"感知-分析-修复-验证"的闭环流程，不仅生成修复方案，还会自动创建 PR、运行测试，必要时自动合并。

Bugbot 的设计理念是：**让开发者从重复性的 Bug 修复中解放出来，专注于更有价值的创造性工作。**

---

## Autofix 工作原理

```
Bug 触发（测试失败 / 用户报告 / CI 告警）
         ↓
  Bugbot 感知
         ↓
  上下文收集（错误日志、堆栈信息、相关代码）
         ↓
  根因分析（AI 分析问题本质）
         ↓
  修复方案生成（多种方案比较）
         ↓
  自动化测试验证
         ↓
  创建 PR
         ↓
  CI 通过后自动合并
```

---

## 使用流程

### 方式一：测试失败触发

```bash
# 运行测试，发现失败
swift test

# 自动启动 Bugbot 修复
/bugbot fix --test LoginTests/testFailure

# Bugbot 会：
# 1. 分析测试失败原因
# 2. 定位问题代码
# 3. 生成修复补丁
# 4. 重新运行测试验证
```

### 方式二：CI 告警触发

```bash
# 在 CI 中配置 Bugbot
# .github/workflows/ci.yml
- name: Run Tests
  run: swift test

- name: Bugbot Fix
  if: failure()
  run: |
    cursor bugbot fix \
      --ci \
      --commit-hash ${{ github.sha }} \
      --notify slack:#dev-alerts
```

### 方式三：手动指定

```bash
# 指定文件和行号
/bugbot fix --file src/AuthService.swift --line 42

# 描述问题
/bugbot fix --describe "用户登出后 Token 未清除"
```

---

## 自动 PR 创建

### PR 自动生成

Bugbot 修复完成后，会自动创建 PR：

```bash
# 查看 Bugbot 生成的 PR
/bugbot pr list

# 查看 PR 详情
/bugbot pr show <pr-id>

# 手动触发 PR 创建
/bugbot pr create
```

PR 内容包含：
- **修复说明**：问题的根本原因
- **修复方案**：具体的代码改动
- **测试验证**：通过哪些测试用例
- **风险评估**：对其他模块的影响

### 合并规则配置

```json
{
  "bugbot": {
    "autoMerge": {
      "enabled": true,
      "conditions": {
        "testsPass": true,
        "reviewersApproved": 1,
        "noConflicts": true,
        "riskLevel": "low"    // low/medium/high
      },
      "maxWaitMinutes": 60   // 最多等待 60 分钟
    }
  }
}
```

### 风险等级判定

| 风险等级 | 判定条件 | 合并策略 |
|----------|----------|----------|
| Low | 单文件修改、无依赖变更 | 直接合并 |
| Medium | 多文件修改、有依赖更新 | 需要 1 人审批 |
| High | 核心模块、安全相关 | 需要 2 人审批 |

---

## 典型使用场景

### 场景一：CI 失败自动修复

```
1. 开发者 Push 代码
2. CI 运行测试
3. 测试失败 → 触发 Bugbot
4. Bugbot 分析并修复
5. Bugbot 创建 PR 并通知
6. CI 重跑 → 通过
7. 自动合并 PR
整个过程无需开发者介入。
```

### 场景二：生产环境 Bug 快速响应

```bash
# 收到告警
/bugbot fix --production \
  --error "Database connection pool exhausted" \
  --severity critical

# Bugbot 立即：
# 1. 分析错误日志
# 2. 生成热修复
# 3. 创建紧急 PR
# 4. 通知相关人员
# 5. 待审批后合并
```

---

## 注意事项

- **自动合并风险**：High 风险修复不会自动合并，必须人工审批，避免引入生产问题
- **PR 数量管理**：大量 Bugbot 自动修复可能产生 PR 海啸，建议设置每日合并上限
- **上下文丢失**：修复后记得在 PR 评论中补充业务背景，方便代码审查
- **测试覆盖**：Bugbot 的修复质量依赖测试用例质量，确保项目有足够的测试覆盖

---

## 小结

```
✅ Bugbot Autofix - 自动定位和修复 Bug
✅ 感知-分析-修复-验证 闭环流程
✅ 自动创建 PR，包含修复说明和风险评估
✅ 条件满足后自动合并（Low 风险）
✅ 支持 CI 集成，CI 失败自动触发修复
```

> 下一步：MCP Apps 应用集成 →
