# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

GitBook-based documentation book (AI 编程完全指南) for iOS developers learning AI-assisted coding with Claude Code, Cursor, and Codex. All prose is Simplified Chinese (`zh-hans`). Target reader: iOS developer with basic Swift knowledge, new to AI tooling.

## Build & Preview

```bash
# one-time env bootstrap (Homebrew / nvm / Node / Git)
./scripts/setup.sh
./scripts/verify.sh          # sanity-check the env

# book workflow
npm install -g gitbook-cli
gitbook install              # install plugins from book.json
./scripts/preview.sh         # == gitbook serve  → http://localhost:4000
./scripts/build.sh           # == gitbook build . _book
gitbook pdf                  # PDF via styles/pdf.css (book.json)
```

`gitbook build` in CI runs from repo root (`gitbook build . _book`). There is no package.json — GitBook CLI and its plugins are the only build dependency.

## CI

`.github/workflows/`:
- **ci.yml** — `markdown-link-check` (config: `.github/mlc_config.json`) + `markdownlint-cli2` (config: `.github/markdownlint.json`)
- **build-smoke.yml** — `gitbook build` smoke test + `shellcheck scripts/*.sh`
- **gitbook.yml** — deploys `_book/` to GitHub Pages on push to `main`; copies `robots.txt` and `sitemap.xml` into the build

Markdown lint disables MD013 (line length), MD033 (inline HTML), MD040 (fenced code language).

## Architecture

### Two configs, kept aligned
- `book.json` → `"root": "."`, `"summary": "SUMMARY.md"` (local `gitbook-cli`).
- `.gitbook.yaml` → `root: .`, `structure.readme: README.md`, `structure.summary: SUMMARY.md` (GitBook.com SaaS).

Both point to the repo-root `README.md` + `SUMMARY.md`. When editing the TOC, edit `SUMMARY.md` at repo root — it is the single source of truth. Keep SUMMARY link paths as `./docs/...` (repo-root-relative) so both `book.json` and `.gitbook.yaml` resolve them identically. If you change one config's root, change the other in the same commit, otherwise GitBook.com falls back to auto-discovering `docs/*.md` and the sidebar becomes a flat mess.

### Content layout
```
docs/
├── 00-quick-start.md                 # 5-minute entry after README
├── 基础篇/        01–05: env setup, tool install, first project, Agent basics, practice apps
├── 进阶篇/        01–10: Agent/MCP/Prompt/Rules/safety/ClaudeCode/Cursor deep-dives
├── 实战篇/        01–05: per-tool实战 (ClaudeCode, Cursor, Codex) + failures + iOS scenarios
├── 大师篇/        01–03: multi-Agent, OpenClaw remote coding, advanced workflows
├── ios-*.md                          # flat iOS appendix (skills/debug/release/tools/interview)
├── gitbook-*.md                      # GitBook deployment/domain documentation
└── FAQ.md / glossary.md / learning-path.md / cheat-sheet.md / writing-style.md
```

Chapter directories (`基础篇/01-环境搭建/` etc.) contain a `README.md` as the section landing page plus numbered sub-pages. TOC entries in `SUMMARY.md` reference `./docs/...` paths explicitly.

### Writing conventions (enforced by review, not lint)
`AGENTS.md` is the authoritative style guide. Key rules when editing or adding chapters:

- **Chapter skeleton**: `# 标题` → `> 一句话概述` → `## 🤔 是什么` → `## 🎯 为什么重要` → `## 🛠 怎么做` → `## 💡 最佳实践` → `## ⚠️ 常见问题` → `## ✅ 小结` → `## 🔗 相关资源`.
- **Filenames**: Chinese folder names (`基础篇/`), numeric prefixes for ordering (`01-环境搭建/`), `README.md` per section.
- **Source tiers**: Prefer Tier 1 (official docs: Anthropic, OpenAI, Apple, modelcontextprotocol.io) over blogs. Cross-verify anything from Tier 3 before merging.
- **Audience**: junior iOS developer — avoid jargon-dense AI terminology without a plain-language definition first.

### When adding a new chapter
1. Create `docs/<篇>/<NN-name>/README.md` (and sub-pages as needed).
2. Add entries to root `SUMMARY.md` using `./docs/...` paths.
3. Update any cross-links from `docs/learning-path.md` / parent section `README.md` if the new chapter belongs in a learning sequence.
4. Run `./scripts/build.sh` locally to catch broken TOC references before pushing.

## Related files worth knowing

- `AGENTS.md` — full writing/style/maintenance guide (richer than this file for content work)
- `CONTRIBUTING.md` — PR checklist, source-credibility tiers
- `GEMINI.md` — parallel guidance for Gemini CLI users (keep in sync if project norms change)
- `docs/gitbook-migration-checklist.md` — history of the GitBook setup
- `styles/website.css`, `styles/pdf.css` — theme overrides
- `examples/` — companion code referenced from chapters
- `resources/` — curated external links
