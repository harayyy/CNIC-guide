param(
    [switch]$Serve
)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# 首次运行自动安装构建依赖（requirements.txt）
if (-not (python -c "import material" 2>$null)) {
    Write-Host "首次运行：安装构建依赖（requirements.txt）..."
    python -m pip install -r requirements.txt
}

# 同步内容到 docs_src/（临时构建源，不入库）
if (Test-Path -LiteralPath "docs_src") {
    Remove-Item -LiteralPath "docs_src" -Recurse -Force
}
New-Item -ItemType Directory -Path "docs_src" | Out-Null

$ContentDirs = @("初试准备", "复试准备", "上岸经验分享", "毕业去向")
foreach ($dir in $ContentDirs) {
    if (Test-Path -LiteralPath $dir) {
        Copy-Item -LiteralPath $dir -Destination "docs_src" -Recurse
    }
}
Copy-Item -LiteralPath "CONTRIBUTORS.md" -Destination "docs_src"
Copy-Item -LiteralPath "免责声明.md" -Destination "docs_src"

# 网站层匿名化（仅作用于 docs_src 副本，仓库源文件不受影响）
python anonymize.py docs_src

# 首页（公开层级描述，复制到 index.md）
Copy-Item -LiteralPath "homepage.md" -Destination "docs_src\index.md"

# 构建
python -m mkdocs build
Write-Host "构建完成：$((Get-Location).Path)\site\index.html"

if ($Serve) {
    python -m mkdocs serve
}
