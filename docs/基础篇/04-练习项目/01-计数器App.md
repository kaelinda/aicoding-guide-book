# 01 计数器 App

> 学习目标：掌握 AI 编程的基本交互流程

---

## 需求说明

用 SwiftUI 实现一个计数器 App：

### 功能

1. 显示当前数字（从 0 开始）
2. 点击「+1」按钮，数字加 1
3. 点击「-1」按钮，数字减 1
4. 点击「重置」按钮，数字归零

### 界面参考

```
┌─────────────────┐
│                 │
│       0         │  ← 数字居中显示
│                 │
│  [-1]   [重置] [+1]  │  ← 三个按钮
│                 │
└─────────────────┘
```

### 约束

- 使用 SwiftUI
- 数字不能小于 0
- 按钮有适当的间距

---

## 提示

> 遇到困难时的线索

1. SwiftUI 中使用 `@State` 管理可变状态
2. `Button` 组件创建按钮
3. `VStack` 和 `HStack` 布局

---

## 验收标准

- [ ] 显示数字从 0 开始
- [ ] 点击 +1 数字加 1
- [ ] 点击 -1 数字减 1
- [ ] 点击重置数字归零
- [ ] 数字最小值为 0（不能变负）
- [ ] 界面美观，按钮有适当间距

---

## 预期对话

```bash
$ claude

你：帮我创建一个计数器 App，使用 SwiftUI

Claude Code：
# 我来帮你创建一个计数器 App。

首先分析一下需求：
- 显示当前计数（初始值 0）
- +1 按钮：计数 +1
- -1 按钮：计数 -1（最小值 0）
- 重置按钮：恢复为 0

让我创建代码：
...

已创建 CounterView.swift：
- 使用 @State 管理计数状态
- VStack 垂直布局
- HStack 水平排列按钮
- 数字格式化显示

需要我运行 Preview 看看效果吗？

你：运行看看

Claude Code：
# Preview 已启动，可以在 Xcode 中看到效果

...
```

---

## 参考答案

<details>
<summary>点击查看完整代码</summary>

```swift
import SwiftUI

struct CounterView: View {
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Text("\(count)")
                .font(.system(size: 72, weight: .bold))
            
            HStack(spacing: 20) {
                Button("-1") {
                    if count > 0 {
                        count -= 1
                    }
                }
                .font(.title2)
                .buttonStyle(.bordered)
                
                Button("重置") {
                    count = 0
                }
                .font(.title2)
                .buttonStyle(.bordered)
                
                Button("+1") {
                    count += 1
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}
```

</details>

---

## 下一步

[天气查询页 →](./02-天气查询页.md)
