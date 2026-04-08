# GitBook 自定义域名配置说明

> 本项目当前通过 GitBook 对外发布，正式访问域名为 `aicoding-guide-book.kaelinda.vip`。

---

## 当前发布方式

本仓库的在线文档站点使用 **GitBook 托管**，而不是 GitHub Pages 直接托管。

这意味着：

- GitHub 仓库负责存放内容与版本管理
- GitBook 负责内容同步、页面渲染、HTTPS 证书与外部访问
- 自定义域名绑定应在 **GitBook 后台** 完成
- DNS 应将子域名 **CNAME 到 GitBook**，而不是解析到固定 IP

---

## 正式域名

```text
aicoding-guide-book.kaelinda.vip
```

---

## DNS 配置原则

对于子域名 `aicoding-guide-book.kaelinda.vip`，推荐使用以下解析：

```text
主机记录: aicoding-guide-book
记录类型: CNAME
记录值: cname.gitbook.com
```

### 为什么不建议配置固定 IP

GitBook 作为托管服务，底层通常使用可变的基础设施与证书分发机制。

因此：

- 不应把域名解析到某个固定 IP
- 不应在 GitHub 仓库中通过 GitHub Pages 的 `CNAME` 文件来驱动 GitBook 域名
- 应以 GitBook 后台中的自定义域名设置为准

---

## GitBook 后台配置

在目标 Space 中添加以下域名：

```text
aicoding-guide-book.kaelinda.vip
```

当 DNS 生效后，GitBook 会完成：

- 域名归属校验
- HTTPS 证书签发
- 公开访问启用

常见状态包括：

- `Pending verification`
- `SSL provisioning`
- `Connected`

---

## 仓库侧需要注意什么

由于本项目不是通过 GitHub Pages 直接发布，因此仓库中：

- **不需要** 添加 GitHub Pages 专用 `CNAME` 文件
- **不需要** 配置 Pages 源分支来承载正式域名
- **不需要** 维护固定 IP 的 A 记录说明

仓库需要做的是：

- 保持 `README.md`、`SUMMARY.md` 与 `docs/` 内容结构稳定
- 保持 GitBook 同步路径配置正确
- 在文档中记录正式访问域名，便于维护

---

## 推荐维护方式

建议后续在仓库中统一使用以下约定：

- GitHub 仓库：内容源
- GitBook Space：发布源
- 自定义域名：正式入口

如果未来更换域名或增加新子域名，请同时更新：

1. DNS 解析
2. GitBook Space 的 Custom Domain 配置
3. 本文档中的正式域名说明

---

## 常见问题

### 1. 已经加了 DNS，为什么打不开？
可能原因包括：

- DNS 还未生效
- GitBook 仍在签发 SSL 证书
- GitBook 后台尚未绑定该域名
- 同名记录冲突（例如已有 A/AAAA/CNAME）

### 2. 是否要在仓库根目录加入 `CNAME` 文件？
对于 **GitBook 托管站点**，通常不需要。

`CNAME` 文件主要是 GitHub Pages 的工作方式，不应与 GitBook 的域名绑定逻辑混用。

### 3. 是否需要固定 IP？
不需要。应使用 GitBook 官方建议的 CNAME 方式。

---

## 小结

本项目当前的正确域名发布链路是：

```text
GitHub 仓库 -> GitBook Space -> 自定义域名 aicoding-guide-book.kaelinda.vip
```

因此，仓库层面的“域名适配”主要是：

- 记录并固化这条发布链路
- 避免引入 GitHub Pages 风格的错误配置
- 为后续维护者提供清晰的运维说明
