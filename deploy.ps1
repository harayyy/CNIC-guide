<#
.SYNOPSIS
  一键构建并部署站点到 GitHub Pages（gh-pages 分支）。

.DESCRIPTION
  1. 确保 git 可用
  2. 运行 build-site.ps1 生成 site/
  3. 执行 mkdocs gh-deploy 推送到 GitHub Pages
#>
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# 1) 确保 git 可用
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    $gitCandidates = @(
        "C:\Program Files\Git\bin",
        "C:\Program Files (x86)\Git\bin",
        "$env:LOCALAPPDATA\Programs\Git\bin"
    )
    foreach ($g in $gitCandidates) {
        if (Test-Path -LiteralPath (Join-Path $g "git.exe")) {
            $env:Path = "$g;$env:Path"
            Write-Host "已将 git 加入 PATH: $g"
            break
        }
    }
}
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "未找到 git，请先安装 Git（https://git-scm.com/）或将其加入 PATH 后重试。"
}
Write-Host "使用 git: $((Get-Command git).Source)"

# 2) 构建（生成 docs_src 与 site）
& powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "build-site.ps1")
if ($LASTEXITCODE -ne 0) { throw "build-site.ps1 构建失败" }

# 3) 部署到 gh-pages（需先配置好 git remote）
python -m mkdocs gh-deploy
if ($LASTEXITCODE -ne 0) { throw "mkdocs gh-deploy 部署失败" }
Write-Host "部署完成，站点地址见 GitHub 仓库 Settings → Pages"
