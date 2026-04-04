# 01-计数器 App

> 用 AI 编程开发你的第一个交互式 iOS 应用

---

## 目标

- 创建一个可以点击增加/减少的数字计数器
- 学习如何描述基础交互需求
- 掌握与 AI 协作的基本流程

---

## 技能点

- SwiftUI 基础
- @State 数据绑定
- 基础用户交互
- 简单动画

---

## 步骤

### 第一步：创建项目结构

在 Claude Code 中输入：

```
创建一个计数器 App，使用 SwiftUI：
- iOS 项目
- 项目名叫 CounterApp
- 使用 XcodeGen 管理项目
```

Claude Code 会帮你创建：
- `project.yml` 配置文件
- `CounterApp` 源码目录
- `CounterApp.swift` 主文件
- `Info.plist`

### 第二步：描述界面需求

继续在 Claude Code 中输入：

```
实现计数器的 UI：
- 屏幕中间显示当前数字，72号字体，黑色
- 数字下方显示文字"点击次数"
- 底部有两个按钮：
  - 左边红色"−"按钮
  - 右边绿色"+"按钮
- 按钮尺寸 60x60，圆形
```

### 第三步：描述交互逻辑

```
添加交互逻辑：
- 点击"+"按钮，数字 +1
- 点击"−"按钮，数字 -1
- 数字不能小于 0
- 每次点击按钮有轻微放大动画（0.1秒）
```

### 第四步：运行验证

```bash
# 打开项目
open CounterApp.xcodeproj

# 选择 iPhone 15 模拟器
# 按 Cmd+R 运行
```

---

## 完整代码

如果 AI 生成的代码有问题，使用这个版本：

```swift
import SwiftUI

struct ContentView: View {
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Text("\(count)")
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(.black)
            
            Text("点击次数")
                .font(.system(size: 18))
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack(spacing: 50) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        if count > 0 {
                            count -= 1
                        }
                    }
                }) {
                    Text("−")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.red)
                        .clipShape(Circle())
                }
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        count += 1
                    }
                }) {
                    Text("+")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
            .padding(.bottom, 50)
        }
        .padding()
    }
}

@main
struct CounterAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

---

## 常见问题

### Q: 按钮点击没反应

检查 `@State` 是否正确标注：
```swift
@State private var count = 0  // 正确
private var count = 0         // 错误，不会响应点击
```

### Q: 数字不更新

确保在修改状态变量的地方使用 `.constant` 或者在按钮 action 中直接修改：
```swift
Button(action: {
    count += 1  // 直接在 action 里修改
}) { ... }
```

### Q: 模拟器没有反应

1. 检查 Xcode 左上角是否选中了模拟器
2. 按 `Cmd+R` 重新运行
3. `Product > Clean Build Folder` 然后重试

---

## 扩展练习

完成基础版后，尝试让 AI 添加：

1. **重置按钮** - 长按数字清零
2. **历史记录** - 记录每次点击的值
3. **步进设置** - 可以设置每次增加/减少的数量

---

## 小结

```
✅ 创建了第一个交互式 App
✅ 学会了描述 UI 需求
✅ 掌握了 @State 数据绑定
✅ 理解了 AI 协作流程

下一步：学习如何调用 API 获取数据 →
```
