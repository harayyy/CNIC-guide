#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""网站层匿名化脚本（构建期运行，仓库源文件不受影响）

由构建脚本（build-site.sh）在把内容同步到 docs_src/ 之后、mkdocs build 之前调用，
对 docs_src/ 中的 markdown 副本做精确字符串替换：
  * 具体学校名 → 学校层次（985 / 双非 / 四非 等）
  * 删除个别联系方式节（QQ 等）

关键点：markdown 链接 `[显示文字](路径.md)` 只替换显示文字，路径（href）
保持原文件名不动——因为源文件没有改名，网站 URL 也不应改变。

作者昵称与供稿署名保留。

用法: python anonymize.py <docs_dir>
"""
import re
import sys
from pathlib import Path

# CNIC 版匿名化规则：如需在网站上隐藏具体校名/人名，请在此添加
# (原文, 替换后文字)。链接的显示文字会被替换，文件路径不会改变。
REPLACEMENTS = [
]

# 需要整体删除的章节标题（从该节到文件尾）
DROP_SECTIONS = ["## 联系方式"]

_LINK_RE = re.compile(r"\[([^\]]*)\]\(([^)]*)\)")


def protect_links(text: str) -> tuple[str, dict]:
    """把 markdown 链接的 href 换成占位符，避免被全局替换误改。"""
    placeholder = {}
    counter = 0

    def _repl(m: re.Match) -> str:
        nonlocal counter
        key = f"\x00LINK{counter}\x00"
        placeholder[key] = m.group(2)
        counter += 1
        return f"[{m.group(1)}]({key})"

    return _LINK_RE.sub(_repl, text), placeholder


def restore_links(text: str, placeholder: dict) -> str:
    for key, url in placeholder.items():
        text = text.replace(key, url)
    return text


def main(docs_dir: str) -> None:
    root = Path(docs_dir)
    if not root.is_dir():
        sys.exit(f"目录不存在: {docs_dir}")
    changed = 0
    for md in sorted(root.rglob("*.md")):
        original = md.read_text(encoding="utf-8")
        text, placeholder = protect_links(original)
        for old, new in REPLACEMENTS:
            text = text.replace(old, new)
        for section in DROP_SECTIONS:
            if section in text:
                text = text.split(section)[0].rstrip() + "\n"
        text = restore_links(text, placeholder)
        if text != original:
            md.write_text(text, encoding="utf-8")
            print(f"  [anonymize] 已处理 {md.relative_to(root)}")
            changed += 1
    print(f"匿名化完成，共处理 {changed} 个文件。")


if __name__ == "__main__":
    main(sys.argv[1])
