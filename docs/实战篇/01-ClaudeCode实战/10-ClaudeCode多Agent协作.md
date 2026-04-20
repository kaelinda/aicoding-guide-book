# 10-Claude Code 多 Agent 协作

> 让三个角色分别干"拆 / 做 / 审"三件事，比一个 Agent 一口气干完靠谱很多。

---

## 为什么要多 Agent

单 Agent 一口气从"理解需求"做到"提交代码"，常见故障有三种：

1. **偷改不相关文件**：它觉得顺手优化一下，结果 diff 里混了 5 个和任务无关的改动
2. **只给方案不验证**：写完就说"done"，真跑起来 build 失败
3. **自我辩护**：review 自己写的代码，倾向于说"没问题"

多 Agent 协作就是**把流程切开、让不同角色用不同目标去对抗**：

- **Architect**：只管拆任务，不写代码
- **Builder**：只按清单写，不扩大范围
- **Reviewer**：只挑错，不维护原作者的面子

---

## 三角色的 Prompt 模板

### Architect（架构师）

```text
你现在是 Architect 角色。规则：
1. 只读代码、只给方案，不要动任何文件
2. 产出一张任务表（步骤 / 产出文件 / 验收标准）
3. 标注每步之间的依赖关系
4. 如果需求不清楚，先问我，不要猜

任务：<贴需求>
```

典型输出：一张 3-5 步的表格 + 风险提示。
**如果输出直接动手写代码，停下，换 session 重来**。

### Builder（执行者）

```text
你现在是 Builder 角色。规则：
1. 严格按照以下任务清单执行，每次只做一步
2. 不扩大改动范围、不"顺手优化"
3. 每步做完附上：改了哪些文件、为什么改、怎么验证
4. 发现清单和代码现状矛盾，停下问我，不要自己决定

任务清单：
<贴 Architect 的输出>

现在开始第 1 步。
```

关键词是"每次只做一步"。Builder 最容易失控的地方是"反正都在写，索性都写完"。

### Reviewer（审查者）

```text
你现在是 Reviewer 角色。规则：
1. 只看改动，不帮着改
2. 假设作者已经离职，没法问任何问题
3. 优先挑：未覆盖的边界、状态竞争、错误吞掉、测试缺失
4. 用严重度分级：🔴 必改 / 🟡 建议改 / 🟢 可忽略

diff：
<贴 git diff 或 Builder 的产出>

原任务：
<贴 Architect 的任务清单，让 Reviewer 知道验收标准>
```

Reviewer 的价值是"它不知道你写这段代码时的上下文"。别把前面 Builder 的推理过程也贴进来，那会让它偏向于"原谅"。

---

## 完整示例：修一个登录页重复请求的 bug

### Round 1 — Architect

我给 Architect 的任务：

```text
你是 Architect 角色。任务：
LoginView 打开时偶发调用两次登录接口，排查并给出修复方案。

项目代码：SwiftUI，用 @StateObject LoginViewModel。
```

Architect 产出：

| 步骤 | 产出 | 验收 |
|------|------|------|
| ① 定位触发点 | 分析报告（哪几处会调 login()） | 列出所有触发路径 |
| ② 判断根因 | 指出是 View 重建 / onAppear 重入 / 状态闪 | 说清为什么会两次 |
| ③ 最小修复 | patch 清单（改哪个文件、几行） | 不动其他文件 |
| ④ 回归验证 | 如何手工复现 + 手工验证 | 给出点击路径 |

风险：如果是 NavigationStack 里 View 被 pop 又 push，问题可能不在 LoginView。

我同意这个拆法，进下一轮。

### Round 2 — Builder

**新开一个 session**（这一步很重要，别和 Architect 混），贴任务清单：

```text
你是 Builder 角色。按下面清单执行第 ① 步：
<Architect 的表>
```

Builder 读代码后报告：

- `onAppear` 里调了 `vm.login()`
- `LoginViewModel` 的 `init` 里也调了一次
- 所以每次 View 出现时会调两次

继续："现在做第 ③ 步最小修复"：

Builder 产出 diff：只动 `LoginViewModel.swift` 一处，删掉 `init` 里的调用。
改完附验证：

```text
改动：LoginViewModel.swift:23 删除 init 里的 login() 调用
验证：
- 打开 LoginView，Charles 只抓到 1 次 /login
- 登录失败后手动重试，也只有 1 次
```

### Round 3 — Reviewer

再开一个 session，贴 diff 和 Architect 的原表：

```text
你是 Reviewer 角色。
diff：<git diff>
原任务：<Architect 的任务表>
```

Reviewer 回：

- 🟡 改动最小、方向正确
- 🔴 **但**：删掉 `init` 里的 login 会影响 deeplink 启动场景 —— 如果 app 通过 URL scheme 唤起，LoginViewModel 先创建后 View 再挂载，`onAppear` 确实会兜住，但要确认 deeplink 流程也是经过 LoginView
- 🟢 建议加一个 XCTest：测 `onAppear` 多次触发只调一次 API

回到 Builder 补测试、补 deeplink 的注释。

---

## 什么时候该用这个流程

✅ 适合：

- 改动跨 3+ 文件
- 领域你不熟（让 Architect 先画地图）
- 风险改动（涉及钱、权限、数据迁移）
- 需要交给别人 review 的 PR —— Reviewer 角色提前挑一遍，真人 review 更轻松

❌ 不适合：

- 改一个字符串、改一个常量 —— 一轮搞定
- 原型阶段 —— 还没想清楚就上三角色，反而慢
- 明确是体力活（比如把 100 个文件里 `print` 换成 `Logger`）—— 直接 Builder 一把梭

---

## 和 Claude Code 内置 Task / Subagent 的关系

进阶篇 `08-ClaudeCode新功能/01-Task工具与Subagent.md` 讲的是用 Task 工具派发子 Agent。
本篇讲的是**你手动在 3 个 session 之间切换**，是更基础、更可控的做法。

**我的默认选择**：

- 刚接触多 Agent 概念 → 先手动切三个 session 练几次，建立体感
- 流程跑熟了 → 再用 Task/subagent 自动化，但每步还是要人类 gate
- 完全托管的全自动流水线 → 目前阶段我不用，错误成本太高

---

## 三个容易犯的错

1. **三个角色在同一个 session 里对话**：上下文污染，Reviewer 会偏向维护 Builder 的面子。**务必新开 session**
2. **Architect 直接让它开始写代码**：一开始就把"只读不写"的约束说死，一旦它开始改文件立刻 Ctrl+C
3. **Reviewer 的反馈盲从**：Reviewer 也会误报。它提的 🔴 必改要你复核，不是照单全收

---

## 一句话总结

**多 Agent 不是为了让 AI 更聪明，是为了给工作流加 checkpoint。**
每个角色的单一目标 + session 隔离，就是 checkpoint 本身。

---

## 相关资源

- 上一篇：[09-失败案例](09-ClaudeCode失败案例.md)
- 下一篇：[11-完整项目实战](11-ClaudeCode完整项目实战.md)
- 深度阅读：[大师篇/01-多 Agent 协作](../../大师篇/01-多Agent协作/README.md)、[进阶篇/08-01-Task 工具与 Subagent](../../进阶篇/08-ClaudeCode新功能/01-Task工具与Subagent.md)
