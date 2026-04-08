# 07-Claude Code 记忆管理最佳实践

> 上下文决定短期表现，记忆决定长期稳定性。

---

## 什么是记忆管理

在 Claude Code 中，记忆主要来源于：

- AGENTS.md
- 项目文档（README、docs）
- 代码结构本身
- 你反复使用的 prompt 模式

记忆管理的目标是：

> 让 Claude 在每次进入项目时都“重新成为一个熟悉项目的工程师”。

---

## 1. 不要把关键规则只放在对话里

错误方式：

- 在聊天里说“不要用强制解包”
- 下一轮它就忘了

正确方式：

写进 `AGENTS.md`

```markdown
## 编码规范
- 禁止使用强制解包 !
- 所有网络请求必须通过 Repository
- View 不允许写业务逻辑
```

---

## 2. AGENTS.md 是最核心的“长期记忆”

建议你把这些放进去：

### 技术栈
- SwiftUI / UIKit
- MVVM
- URLSession / Alamofire

### 目录结构
- Views/
- ViewModels/
- Models/
- Services/

### 编码规范
- 命名规则
- 分层规则
- 禁止事项

### 常用命令
- 构建
- 测试
- Lint

---

## 3. 用文档补“架构记忆”

AGENTS.md 适合规则，但不适合复杂说明。

建议补这些文档：

- `docs/architecture.md`
- `docs/network.md`
- `docs/state-management.md`

这样 Claude 可以：
- 理解为什么这样设计
- 不轻易“优化掉”你的结构

---

## 4. 把常用 Skills 固化下来

你已经有一页 Skills，可以进一步做：

- 常用 bug 排查模板
- 常用重构模板
- 常用测试模板

甚至可以写进仓库：

```text
skills/
- bug-fix.txt
- mvvm-refactor.txt
- performance-check.txt
```

---

## 5. 建立“团队记忆”

如果是团队项目，建议：

- 把约束写进仓库，而不是口头
- 把常见坑写成文档
- 把决策过程记录下来

Claude 会自动继承这些内容。

---

## 6. 让 Claude 帮你更新记忆

你可以直接这样说：

```text
请根据当前项目结构，更新 AGENTS.md：
- 补充真实目录
- 补充真实依赖
- 补充常用命令
```

或者：

```text
请总结当前架构，并写入 docs/architecture.md
```

---

## 7. 记忆要定期“清理和升级”

记忆不是越多越好，而是：

- 过时的要删除
- 模糊的要具体化
- 冲突的要统一

否则会导致：
- Claude 不知道听谁的
- 行为变得不稳定

---

## 8. 推荐记忆结构

```text
AGENTS.md           # 全局规则
docs/architecture   # 架构说明
docs/xxx            # 模块说明
skills/             # 常用任务模板
```

---

## 小结

记忆管理的核心是：

- 把规则写下来，而不是只说
- 把结构解释清楚，而不是让 AI 猜
- 把常用模式沉淀下来，而不是每次重想

当你做到这些，Claude Code 会越来越像“熟悉你项目的同事”。
