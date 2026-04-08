# iOS 发布与 ASC

> 汇总 iOS 项目从本地构建、签名、归档、上传 TestFlight 到 App Store Connect 自动化发布的常用工具与命令。

---

## ASC 是什么

ASC 通常指 **App Store Connect**。

常见用途：
- 管理应用版本
- 上传构建包
- 管理 TestFlight
- 管理元数据、截图、审核信息
- 配置 API Key 供 CI 自动发布

---

## 发布流程总览

典型流程：

1. 本地或 CI 构建 Release 包
2. 完成签名与描述文件配置
3. Archive 应用
4. Export IPA
5. 上传到 TestFlight
6. 检查版本说明、截图、审核信息
7. 提交审核或继续灰度测试

---

## fastlane

### fastlane pilot
用途：
- 上传构建到 TestFlight
- 管理测试分发

常见用法：

```bash
fastlane pilot upload
```

适用场景：
- CI 自动上传
- 版本回归测试
- 内部测试分发

---

### fastlane deliver
用途：
- 上传 App Store 元数据
- 更新描述、关键词、截图、版本说明

常见用法：

```bash
fastlane deliver
```

适用场景：
- 自动化发布
- 多语言元数据管理

---

### fastlane match
用途：
- 管理证书与描述文件
- 统一团队签名配置

常见用法：

```bash
fastlane match appstore
fastlane match development
```

适用场景：
- 多人协作
- CI/CD 签名管理
- 减少本地签名混乱

---

## App Store Connect API Key

用途：
- 让 CI 或 fastlane 无需登录交互即可访问 ASC
- 自动上传构建和管理版本信息

常见做法：
- 在 App Store Connect 创建 API Key
- 将 Key ID、Issuer ID、私钥内容配置到 CI Secrets
- 在 fastlane 中引用 API Key

建议：
- 不要把私钥提交到仓库
- 使用 CI Secret 管理
- 为不同环境区分权限与用途

---

## 命令行构建

### Archive

```bash
xcodebuild archive \
  -scheme MyApp \
  -configuration Release \
  -archivePath build/MyApp.xcarchive
```

用途：
- 生成归档包
- 为后续导出 IPA 做准备

---

### Export Archive

```bash
xcodebuild -exportArchive \
  -archivePath build/MyApp.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath build/output
```

用途：
- 导出 IPA
- 配合不同导出方式控制签名与分发方式

---

## 版本号管理

### agvtool
用途：
- 管理 build number
- 管理 marketing version

常见用法：

```bash
agvtool next-version -all
agvtool new-marketing-version 1.2.0
```

适用场景：
- 发版前自动自增版本号
- CI 中统一更新构建号

---

## 上传工具

### Transporter
用途：
- 上传 IPA 到 App Store Connect
- 适合手动发布流程

适用场景：
- 不走 fastlane
- 需要人工确认上传步骤

---

## 签名与发布注意事项

重点检查：
- Bundle Identifier 是否一致
- Provisioning Profile 是否匹配
- 证书是否过期
- ExportOptionsPlist 是否正确
- Build Configuration 是否为 Release
- 版本号与 build number 是否递增

常见问题：
- 签名不匹配导致 archive 失败
- API Key 权限不足
- TestFlight 构建上传成功但处理失败
- 审核信息缺失导致无法提交

---

## 推荐自动化流程

### 本地发布最小流程
1. 更新版本号
2. 运行测试
3. Archive
4. Export IPA
5. 上传 TestFlight

### CI 自动发布流程
1. 拉取代码
2. 安装依赖
3. 注入签名证书与描述文件
4. 执行测试
5. Archive / Export
6. 用 fastlane pilot 上传
7. 用 deliver 更新元数据

---

## 提交前检查清单

- [ ] 版本号已更新
- [ ] Build number 已更新
- [ ] Release 配置正确
- [ ] SwiftLint / 测试通过
- [ ] API Key 配置正确
- [ ] 描述文件与证书有效
- [ ] TestFlight 上传成功
- [ ] 版本说明与截图已更新

---

## 常用命令速查

```bash
# 自增 build number
agvtool next-version -all

# 设置版本号
agvtool new-marketing-version 1.2.0

# archive
xcodebuild archive \
  -scheme MyApp \
  -configuration Release \
  -archivePath build/MyApp.xcarchive

# export
xcodebuild -exportArchive \
  -archivePath build/MyApp.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath build/output

# 上传 TestFlight
fastlane pilot upload

# 上传元数据
fastlane deliver
```

---

## 相关章节

- [iOS AI Skills](./ios-ai-skills.md)
- [iOS 开发工具](./ios-tools.md)
