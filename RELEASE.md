# Release Guide

## 发布前检查
- 确认主要内容已经更新并同步到 `SUMMARY.md`
- 确认 CI 通过：Markdown lint、链接检查、构建冒烟测试、shellcheck
- 检查 GitHub Pages 最近一次部署成功

## 建议流程
1. 更新必要文档与变更说明
2. 在 `CHANGELOG.md` 中补充本次发布内容
3. 创建版本标签
4. 在 GitHub Release 中填写摘要与迁移提示（如有）

## 发布后验证
- 首页可访问
- 目录跳转不 404
- `robots.txt` 与 `sitemap.xml` 正常可访问
