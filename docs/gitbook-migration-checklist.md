# GitBook 迁移检查清单

> 目标：让 GitBook 只使用一套正确的目录源，并确保站内跳转稳定。

---

## 当前建议配置

如果 `.gitbook.yaml` 中使用：

```yaml
root: ./docs
```

则推荐：

```yaml
structure:
  readme: ../README.md
  summary: SUMMARY.md
```

其中 `SUMMARY.md` 指向 `docs/SUMMARY.md`。

---

## 必做检查

- [ ] GitBook 的 Root 已设置为 `docs`
- [ ] GitBook 的 Readme 已设置为 `../README.md`
- [ ] GitBook 的 Summary 已设置为 `SUMMARY.md`
- [ ] 左侧导航已显示“大师篇”
- [ ] 进阶篇与大师篇页面点击后仍在 GitBook 内部跳转
- [ ] iOS 开发专题已出现在目录中

---

## 当前仓库中的正确目录源

正式推荐使用：

```text
docs/SUMMARY.md
```

该文件已经包含：
- 大师篇
- iOS 开发专题
- 近期新增章节

---

## 不再推荐继续使用

```text
../SUMMARY.md
```

原因：
- 这是仓库根目录下的旧目录文件
- 与 `root: ./docs` 的 GitBook 配置不一致
- 容易导致导航与实际内容不同步

---

## 如果仍然异常

请依次检查：

1. GitBook Space 当前绑定的是否为 `main` 分支
2. Git Sync 是否已完成最近一次同步
3. 页面链接是否使用 GitHub blob URL 而不是相对 Markdown 路径
4. GitBook 后台是否仍缓存旧目录结构

---

## 小结

本项目的 GitBook 正确路径体系应统一为：

```text
GitBook root = docs
GitBook summary = SUMMARY.md
实际目录文件 = docs/SUMMARY.md
```
