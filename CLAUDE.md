# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

GitBook-based documentation book (AI 编程完全指南) for iOS developers learning AI-assisted coding with Claude Code, Cursor, and Codex. All prose is Simplified Chinese (`zh-hans`). Target reader: iOS developer with basic Swift knowledge, new to AI tooling.

## Publishing model — GitBook.com Git Sync

**There is no local build step.** The repo follows the [GitBook Git Sync spec](https://gitbook.com/docs/product-tour/git-sync): push to `main`, GitBook.com auto-rebuilds the space.

- `.gitbook.yaml` at repo root declares the content root.
  ```yaml
  root: ./docs
  structure:
    readme: README.md     # → docs/README.md (book homepage)
    summary: SUMMARY.md   # → docs/SUMMARY.md (TOC)
  redirects:
    quick-start: 00-quick-start.md
  ```
- The legacy `gitbook-cli` pipeline (`book.json`, `scripts/build.sh`, GitHub Pages deploy) was **retired** — `gitbook-cli` is deprecated and no longer installs on modern Node. Don't reintroduce it without discussion.
- If you need offline preview, consider Honkit (community fork) — but GitBook.com's own space is the authoritative preview.

## Scripts & CI

```bash
# one-time macOS env bootstrap (Homebrew / nvm / Node / Git)
bash scripts/setup.sh
bash scripts/verify.sh
```

CI (`.github/workflows/ci.yml`):
- `markdown-link-check` — `.github/mlc_config.json`
- `markdownlint-cli2` — `.github/markdownlint.json` (MD013/MD033/MD040 disabled)
- `shellcheck` over `scripts/*.sh`

## Architecture

### Content root: `docs/`
Everything GitBook renders lives under `docs/`. Paths in `docs/SUMMARY.md` are **relative to `docs/`** — never prefix with `./docs/`. The repo-root `README.md` is the GitHub homepage only; GitBook uses `docs/README.md`.

```
docs/
├── README.md                 # book homepage (GitBook's first page)
├── SUMMARY.md                # TOC — single source of truth
├── 00-quick-start.md         # 5-minute entry
├── 基础篇/    01–05: env setup, tool install, first project, Agent basics, practice apps
├── 进阶篇/    01–10: Agent / MCP / Prompt / Rules / safety / ClaudeCode / Cursor deep-dives
├── 实战篇/    01–05: per-tool 实战 (ClaudeCode / Cursor / Codex) + failures + iOS scenarios
├── 大师篇/    01–03: multi-Agent, OpenClaw remote coding, advanced workflows
├── ios-*.md                  # iOS appendix (skills / debug / release / tools / interview / index)
├── gitbook-*.md              # GitBook deployment/domain documentation (content chapters)
├── examples/                 # Prompt templates, AGENTS examples, Swift templates
└── FAQ.md / glossary.md / learning-path.md / best-practices.md / cheat-sheet.md / writing-style.md
```

Each chapter directory (`基础篇/01-环境搭建/` etc.) has a `README.md` as the section landing page plus numbered sub-pages.

### Writing conventions (enforced by review, not lint)
`AGENTS.md` is the authoritative style guide. Quick rules:

- **Chapter skeleton**: `# 标题` → `> 一句话概述` → `## 🤔 是什么` → `## 🎯 为什么重要` → `## 🛠 怎么做` → `## 💡 最佳实践` → `## ⚠️ 常见问题` → `## ✅ 小结` → `## 🔗 相关资源`.
- **Filenames**: Chinese folder names, numeric prefixes for ordering, `README.md` per section.
- **Source tiers**: Prefer Tier 1 (official docs: Anthropic, OpenAI, Apple, modelcontextprotocol.io) over blogs. Cross-verify Tier 3 sources before merging.
- **Audience**: junior iOS developer — avoid jargon-dense AI terminology without a plain-language definition first.

### When adding a new chapter
1. Create `docs/<篇>/<NN-name>/README.md` (and sub-pages as needed).
2. Add entries to `docs/SUMMARY.md` using paths relative to `docs/` (e.g. `进阶篇/11-xxx/README.md`, not `./docs/...`).
3. Update cross-links from `docs/learning-path.md` or parent-section `README.md` if the chapter belongs to a learning sequence.
4. Validate all SUMMARY links resolve:
   ```bash
   cd docs && python3 -c "import re,os; s=open('SUMMARY.md').read(); \
     [print('MISSING:',p) for p in re.findall(r'\\]\\(([^)]+\\.md)\\)', s) if not os.path.exists(p)]"
   ```

### Things to NOT do
- Don't put book content outside `docs/` — GitBook's content root is `./docs`, anything outside won't be synced.
- Don't prefix SUMMARY links with `./docs/` — those paths resolve relative to the content root already.
- Don't re-add `book.json` or gitbook-cli workflows — that path is retired.

## Related files

- `AGENTS.md` — full writing/style/maintenance guide (richer than this file for content work)
- `CONTRIBUTING.md` — PR checklist, source-credibility tiers
- `GEMINI.md` — parallel guidance for Gemini CLI users
- `docs/gitbook-migration-checklist.md` / `docs/gitbook-deployment.md` — historical GitBook setup docs (now content chapters)
- `resources/` — curated external links
