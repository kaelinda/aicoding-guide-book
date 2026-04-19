# GitBook 自定义域名排障

> 当 GitBook 提示 `Invalid configuration` 时，优先以 GitBook 当前页面提示的目标 CNAME 为准。

---

## 当前问题特征

如果 GitBook 提示类似下面的信息：

```text
The CNAME record for this hostname is not pointing to 9ff1e7ed3a-hosting.gitbook.io
```

说明当前 DNS 记录值不正确，或者尚未生效。

---

## 正确处理方式

请将子域名的 CNAME 记录值改为 **GitBook 当前页面明确显示的目标地址**，例如：

```text
9ff1e7ed3a-hosting.gitbook.io
```

而不是写成通用的：

```text
cname.gitbook.com
```

对于当前域名：

```text
aicoding-guide-book.kaelinda.vip
```

DNS 推荐配置为：

```text
主机记录: aicoding-guide-book
记录类型: CNAME
记录值: 9ff1e7ed3a-hosting.gitbook.io
```

---

## 阿里云 DNS 检查项

- 同名记录只能保留 **1 条 CNAME**
- 删除同名的 A / AAAA / 其他 CNAME
- 保存后等待解析生效

---

## GitBook 后台操作

修改 DNS 后，回到 GitBook 自定义域名页面点击：

```text
Try again
```

如果 DNS 已生效，GitBook 会继续进入 SSL 证书配置阶段。

---

## 小结

当 GitBook 和外部文档说明不一致时，应以 **GitBook 当前域名配置页面显示的目标 CNAME** 为准。
