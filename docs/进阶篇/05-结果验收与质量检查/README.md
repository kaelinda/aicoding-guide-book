# 📋 结果验收与质量检查

> AI 生成的代码需要验收。本章介绍如何系统性地检查 AI 输出，确保代码质量。

---

## 目标

- ✅ 建立代码验收清单
- ✅ 掌握自动化测试方法
- ✅ 学会识别常见质量问题
- ✅ 培养代码审查思维

---

## 验收流程

```
代码生成
    ↓
第一步：功能性验收
    ↓
第二步：代码质量检查
    ↓
第三步：安全检查
    ↓
第四步：性能检查
    ↓
通过 → 合并
失败 → 反馈修复
```

---

## 第一步：功能性验收

### 基础检查清单

- [ ] 代码能编译通过吗？
- [ ] 功能是否按需求实现？
- [ ] 边界情况是否处理？
- [ ] 错误提示是否清晰？
- [ ] 用户流程是否通顺？

### 测试用例设计

```swift
// 测试正常流程
func testLoginSuccess() async {
    let result = await login(phone: "13800138000", code: "123456")
    XCTAssertTrue(result.isSuccess)
}

// 测试错误流程
func testLoginWrongCode() async {
    let result = await login(phone: "13800138000", code: "000000")
    XCTAssertFalse(result.isSuccess)
    XCTAssertEqual(result.error, .wrongCode)
}

// 测试边界情况
func testEmptyPhone() async {
    let result = await login(phone: "", code: "123456")
    XCTAssertFalse(result.isSuccess)
    XCTAssertEqual(result.error, .invalidPhone)
}
```

---

## 第二步：代码质量检查

### 检查清单

| 检查项 | 说明 | 工具 |
|--------|------|------|
| 命名规范 | 变量/函数命名清晰 | - |
| 代码重复 | 是否有重复代码 | Xcode Analyze |
| 注释完整 | 关键逻辑有注释 | - |
| 函数长度 | 单个函数不超过 50 行 | - |
| 复杂度 | 嵌套不要太深 | SwiftLint |

### SwiftLint 规则

```bash
# 安装
brew install swiftlint

# 在项目目录运行
swiftlint
```

### 常用规则配置

```yaml
# .swiftlint.yml
disabled_rules:
  - trailing_whitespace
  - line_length

opt_in_rules:
  - empty_count
  - explicit_init
  - closure_spacing

excluded:
  - Pods
  - .build
```

---

## 第三步：安全检查

### 检查清单

| 检查项 | 风险 | 修复方法 |
|--------|------|----------|
| API Key 硬编码 | 🔴 高 | 使用环境变量 |
| 用户输入未校验 | 🔴 高 | 输入验证 |
| SQL 注入 | 🔴 高 | 参数化查询 |
| 敏感数据日志 | 🟡 中 | 脱敏日志 |
| 内存泄漏 | 🟡 中 | 使用 weak |
| Force unwrap | 🟡 中 | guard let |

### 安全检查 Prompt

```
"检查以下代码的安全问题：
1. 是否有 API Key 硬编码？
2. 用户输入是否验证？
3. 是否有内存泄漏风险？
4. 敏感数据是否加密存储？"
```

---

## 第四步：性能检查

### 检查清单

| 检查项 | 风险 | 修复方法 |
|--------|------|----------|
| 主线程阻塞 | 🔴 高 | 异步处理 |
| 大数组遍历 | 🟡 中 | 懒加载 |
| 图片未压缩 | 🟡 中 | 压缩处理 |
| 重复网络请求 | 🟡 中 | 缓存 |
| 内存占用过高 | 🟡 中 | 及时释放 |

### 性能测试 Prompt

```
"检查代码性能问题：
1. 网络请求是否异步？
2. 大数据量是否分页？
3. 图片是否懒加载？
4. 是否有内存泄漏？"
```

---

## 自动化验收

### CI/CD 集成

```yaml
# .github/workflows/quality.yml
name: Code Quality

on: [pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: SwiftLint
        run: |
          docker run --rm -v $(pwd):/app ghcr.io/realm/swiftlint:latest swiftlint
      
      - name: Build
        run: xcodebuild build
      
      - name: Test
        run: xcodebuild test
```

---

## 常见问题

### Q: 验收清单太长了

A: 先做基础检查（功能性），其他可以逐步完善。

### Q: AI 生成的代码需要全部审查吗？

A: 核心逻辑仔细看，通用代码可以略过。

### Q: 如何平衡速度和质量问题？

A: 先跑通功能，再优化质量。迭代改进。

---

## 小结

```
✅ 建立了完整的验收流程
✅ 掌握了四层检查清单
✅ 学会了自动化测试方法

下一步：了解 AI 编程的安全边界 →
```
