# 中国科学院计算机网络信息中心（CNIC）考研报考指南

> ⚠️ **免责声明**：本指南为历届考生公益维护，非盈利，与中国科学院计算机网络信息中心无任何隶属或关联关系，非官方渠道。内容仅供参考，请以官方发布为准。详见 [免责声明](免责声明.md)。

本站面向报考中国科学院计算机网络信息中心硕士研究生的同学，整理真实招生数据、报考全流程、复试要点与上岸经验。内容由历届考生志愿维护，欢迎投稿。

站点技术栈沿用兄弟站点方案：**MkDocs + Material for MkDocs**，内容即仓库中的 Markdown 文件，构建后得到静态网页，可免费部署到 GitHub Pages 或 Cloudflare Pages。

---

## 本地预览（需要 Python 3.10+，推荐 3.13）

1. 安装 Python：前往 <https://www.python.org/downloads/> 下载 3.13 版本，安装时务必勾选 **Add python.exe to PATH**
2. 打开 PowerShell，进入本目录：

```powershell
cd D:\CNIC
python -m pip install -r requirements.txt
.\build-site.ps1 -Serve
```

3. 浏览器打开 <http://127.0.0.1:8000> 即可预览

> 如果提示"禁止运行脚本"，是因为 Windows 默认执行策略限制。在管理员 PowerShell 中执行一次
> `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`，或改用
> `powershell -ExecutionPolicy Bypass -File .\build-site.ps1 -Serve` 运行。

> 也可以直接双击 `preview.bat` 一键启动预览（会自动使用 `cnic` conda 环境的 Python）。

## 构建与部署

```powershell
# 构建静态网站到 site/
.\build-site.ps1

# 一键构建并部署到 GitHub Pages（gh-pages 分支，需先配置好 git remote）
.\deploy.ps1
```

也可以部署到 Cloudflare Pages：新建 Pages 项目，构建命令填 `bash build-site.sh`，输出目录填 `site`，推送到 GitHub 后自动构建发布。

## 内容结构

| 路径 | 说明 |
|---|---|
| `homepage.md` | 首页（精装落地页） |
| `初试准备/初试报考指南.md` | 招生专业、科目、名额、学费待遇、时间线 |
| `复试准备/复试考核指南.md` | 复试流程与经验 |
| `上岸经验分享/` | 考生投稿的经验贴 |
| `毕业去向/` | 毕业去向收集 |
| `经验分享投稿模板.md` | 投稿模板 |
| `overrides/` | 首页样式与组件 |
| `mkdocs.yml` | 站点配置（站点名、导航、主题） |

## 如何投稿

1. **提交 Issue**：在仓库 Issues 页提出修改建议或补充内容
2. **提交 Pull Request**：Fork 本仓库，按 [投稿模板](经验分享投稿模板.md) 写好内容后提交 PR
3. **联系维护者**：不熟悉 GitHub 操作，可把内容发给维护者代为整理

## 许可与致谢

本站内容采用 **CC BY-NC-SA 4.0** 许可协议，可自由分享与转载，但需注明出处且不得用于商业用途。

站点模板与样式改造自《中科院软件所考研报考指南》（<https://github.com/feiyu1104/ISCAS-Application-Guide>，<https://guide.iscas.win/>），按许可要求保留署名。感谢软件所与杭高院指南维护者们的开源分享。

---

*最后更新：2026 年 8 月*
