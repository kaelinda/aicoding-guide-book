# GitBook 自定义域名当前状态

> 当前正式域名：`aicoding-guide-book.kaelinda.vip`

---

## 当前进度

根据 GitBook 后台状态，当前已经完成：

- 子域名选择
- DNS 配置
- DNS 解析检测通过

当前正在进行：

- SSL 证书配置
- 域名状态从 pending 变为 active / connected

---

## 当前界面状态说明

如果 GitBook 显示类似：

```text
Detected DNS for aicoding-guide-book.kaelinda.vip
DNS for your domain is correctly configured, we are preparing the SSL certificate.
```

说明：

- DNS 已经正确指向 GitBook
- 当前无需再修改阿里云 DNS
- 只需要等待 GitBook 完成 HTTPS 证书签发

---

## 当前建议

- 不要继续修改 DNS 记录
- 等待 GitBook 完成 SSL 配置
- 过几分钟后重新刷新状态
- 最终用 `https://aicoding-guide-book.kaelinda.vip` 验证是否可访问

---

## 小结

当前域名链路已经基本正确：

```text
GitHub 仓库 -> GitBook Space -> aicoding-guide-book.kaelinda.vip
```

剩余步骤主要由 GitBook 自动完成。
