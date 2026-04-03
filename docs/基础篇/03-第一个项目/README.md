# 03-第一个项目

> 用 AI 完成你的第一个实战项目

## 🎯 项目目标

创建一个简单的 **待办事项 App**，学习 AI 编程的完整流程。

### 你将学到

- ✅ 如何描述需求给 AI
- ✅ 如何与 AI 协作开发
- ✅ 如何迭代优化代码
- ✅ 如何完成项目交付

## 📋 项目需求

### 功能列表

```
核心功能：
- 添加待办事项
- 标记完成/未完成
- 删除待办事项
- 本地持久化

进阶功能：
- 分类管理
- 优先级设置
- 搜索过滤
```

### 技术选型

```
- SwiftUI（UI 框架）
- SwiftData（数据持久化）
- MVVM 架构
```

## 🚀 开发步骤

### 步骤 1：创建项目

使用 Cursor 创建项目：

```
你（Cursor）：
创建一个 SwiftUI 项目，名称为 TodoApp，
使用 SwiftData 进行数据持久化，
采用 MVVM 架构

Cursor：
[创建项目结构]

TodoApp/
├── TodoAppApp.swift
├── ContentView.swift
├── Models/
│   └── TodoItem.swift
├── ViewModels/
│   └── TodoListViewModel.swift
└── Views/
    ├── TodoListView.swift
    ├── AddTodoView.swift
    └── Components/
```

### 步骤 2：定义数据模型

```
你：
创建 TodoItem 模型，包含以下属性：
- id: UUID
- title: String
- isCompleted: Bool
- createdAt: Date
- priority: Int (1-3)

使用 SwiftData 的 @Model 宏

Cursor：
[生成代码]

import SwiftData
import Foundation

@Model
final class TodoItem {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var priority: Int
    
    init(title: String, priority: Int = 2) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
        self.priority = priority
    }
}
```

### 步骤 3：创建 ViewModel

```
你：
创建 TodoListViewModel，提供以下功能：
- 添加待办事项
- 删除待办事项
- 切换完成状态
- 按优先级排序
- 搜索过滤

使用 @Observable 宏

Cursor：
[生成代码]

import Foundation
import SwiftData

@Observable
class TodoListViewModel {
    var todoItems: [TodoItem] = []
    var searchText: String = ""
    var sortBy: SortOption = .priority
    
    enum SortOption {
        case priority
        case date
        case title
    }
    
    func addTodo(title: String, priority: Int) {
        let todo = TodoItem(title: title, priority: priority)
        todoItems.append(todo)
    }
    
    func deleteTodo(_ todo: TodoItem) {
        todoItems.removeAll { $0.id == todo.id }
    }
    
    func toggleCompletion(_ todo: TodoItem) {
        todo.isCompleted.toggle()
    }
    
    var filteredTodos: [TodoItem] {
        if searchText.isEmpty {
            return todoItems
        }
        return todoItems.filter { 
            $0.title.localizedCaseInsensitiveContains(searchText) 
        }
    }
}
```

### 步骤 4：创建主视图

```
你：
创建 TodoListView，包含：
- 待办事项列表
- 添加按钮
- 搜索栏
- 按优先级显示不同颜色

使用 SwiftUI

Cursor：
[生成代码]

import SwiftUI

struct TodoListView: View {
    @State private var viewModel = TodoListViewModel()
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // 搜索栏
                SearchBar(text: $viewModel.searchText)
                
                // 待办列表
                List {
                    ForEach(viewModel.filteredTodos) { todo in
                        TodoRowView(todo: todo) {
                            viewModel.toggleCompletion(todo)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            viewModel.deleteTodo(viewModel.filteredTodos[index])
                        }
                    }
                }
            }
            .navigationTitle("待办事项")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showingAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddTodoView { title, priority in
                    viewModel.addTodo(title: title, priority: priority)
                }
            }
        }
    }
}
```

### 步骤 5：创建添加视图

```
你：
创建 AddTodoView，包含：
- 标题输入框
- 优先级选择器
- 取消和保存按钮

使用 SwiftUI 表单样式

Cursor：
[生成代码]

import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var priority = 2
    
    let onSave: (String, Int) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("待办事项") {
                    TextField("标题", text: $title)
                }
                
                Section("优先级") {
                    Picker("优先级", selection: $priority) {
                        Text("高").tag(1)
                        Text("中").tag(2)
                        Text("低").tag(3)
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("新建待办")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        onSave(title, priority)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
```

### 步骤 6：运行测试

```
你：
生成单元测试，测试以下场景：
- 添加待办事项
- 删除待办事项
- 切换完成状态
- 搜索过滤功能

Cursor：
[生成测试代码]

import XCTest
@testable import TodoApp

final class TodoAppTests: XCTestCase {
    var viewModel: TodoListViewModel!
    
    override func setUp() {
        viewModel = TodoListViewModel()
    }
    
    func testAddTodo() {
        // Given
        let initialCount = viewModel.todoItems.count
        
        // When
        viewModel.addTodo(title: "Test Todo", priority: 2)
        
        // Then
        XCTAssertEqual(viewModel.todoItems.count, initialCount + 1)
        XCTAssertEqual(viewModel.todoItems.last?.title, "Test Todo")
    }
    
    func testDeleteTodo() {
        // Given
        viewModel.addTodo(title: "Test", priority: 2)
        let todo = viewModel.todoItems.first!
        let initialCount = viewModel.todoItems.count
        
        // When
        viewModel.deleteTodo(todo)
        
        // Then
        XCTAssertEqual(viewModel.todoItems.count, initialCount - 1)
    }
    
    func testToggleCompletion() {
        // Given
        viewModel.addTodo(title: "Test", priority: 2)
        let todo = viewModel.todoItems.first!
        let initialState = todo.isCompleted
        
        // When
        viewModel.toggleCompletion(todo)
        
        // Then
        XCTAssertNotEqual(todo.isCompleted, initialState)
    }
    
    func testSearchFilter() {
        // Given
        viewModel.addTodo(title: "Buy milk", priority: 2)
        viewModel.addTodo(title: "Walk dog", priority: 2)
        viewModel.searchText = "milk"
        
        // When
        let filtered = viewModel.filteredTodos
        
        // Then
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered.first?.title, "Buy milk")
    }
}
```

## ✅ 验收标准

### 功能验收

- [ ] 可以添加待办事项
- [ ] 可以标记完成
- [ ] 可以删除待办事项
- [ ] 数据本地持久化
- [ ] 搜索功能正常
- [ ] 优先级显示正确

### 代码质量

- [ ] 无编译警告
- [ ] 测试通过
- [ ] 符合 SwiftLint 规范
- [ ] 代码结构清晰

## 🎓 学习要点总结

### 1. 需求描述技巧

```
❌ 糟糕的描述：
"写个待办 App"

✅ 好的描述：
"创建一个 SwiftUI 待办事项 App：
- 使用 SwiftData 持久化
- MVVM 架构
- 功能：添加、删除、标记完成、搜索"
```

### 2. 迭代开发流程

```
第一轮：创建项目骨架
第二轮：实现核心功能
第三轮：添加进阶功能
第四轮：优化和测试
```

### 3. 遇到问题时的处理

```
问题：编译错误

你：
编译报错：[错误信息]
请帮我修复

AI：
[分析错误]
[提供修复方案]

问题：功能不符合预期

你：
搜索功能有问题，输入文字后没有过滤结果

AI：
[定位问题]
[修复代码]
```

## 📚 进阶练习

### 练习 1：添加分类功能

```
需求：
- 支持工作、生活、学习等分类
- 按分类筛选
- 分类标签显示
```

### 练习 2：添加提醒功能

```
需求：
- 设置提醒时间
- 本地通知
- 提醒列表管理
```

### 练习 3：添加小组件

```
需求：
- 显示今日待办数量
- 快速添加入口
- 不同尺寸适配
```

## 🎯 最佳实践

### 1. 分步骤完成

```
不要一次性要求 AI 完成所有功能

正确做法：
1. 先完成核心功能
2. 验证可用
3. 添加新功能
4. 再验证
```

### 2. 及时测试

```
每完成一个功能：
1. 运行项目
2. 手动测试
3. 发现问题
4. 让 AI 修复
```

### 3. 保留关键代码

```
AI 生成的代码可能需要调整：
1. 理解代码逻辑
2. 记录关键实现
3. 手动优化细节
```

## ✅ 小结

- 第一个项目重点是流程，不是代码
- 学会如何描述需求
- 掌握迭代开发节奏
- 培养与 AI 协作的感觉

## 📚 下一步

- [进阶篇：Agent 概念 →](../../进阶篇/01-Agent概念/README.md)
- [实战篇：Claude Code →](../../实战篇/01-ClaudeCode实战/README.md)

## 🔗 相关资源

### 官方文档
- [SwiftUI 教程](https://developer.apple.com/tutorials/swiftui) ⭐⭐⭐⭐⭐
- [SwiftData 文档](https://developer.apple.com/documentation/swiftdata) ⭐⭐⭐⭐⭐

### 示例代码
- [Apple 示例项目](https://developer.apple.com/sample-code/) ⭐⭐⭐⭐
