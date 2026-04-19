# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a GitBook-based documentation book (AI 编程完全指南) covering AI-assisted iOS development with tools like Claude Code, Cursor, and Codex. Content is written in Simplified Chinese.

## Build & Preview Commands

```bash
# Install GitBook CLI
npm install -g gitbook-cli

# Install dependencies
gitbook install

# Preview locally (serves at http://localhost:4000)
gitbook serve

# Build static site
gitbook build

# Build PDF
gitbook pdf
```

## CI/CD

GitHub Actions runs on every push to `main` and PRs:
- **markdown-link-check**: Validates all markdown links via `.github/mlc_config.json`
- **markdownlint**: Lints all `.md` files via `.github/markdownlint.json`

## Architecture

**Content root**: `docs/`

**Book structure** defined in two places that must stay in sync:
- `SUMMARY.md` (root) — top-level navigation structure
- `docs/SUMMARY.md` — full chapter structure with all sections

**GitBook config**: `.gitbook.yaml`
- `root: ./docs` — content lives in docs/
- `structure.readme: ../README.md` — entry point
- `structure.summary: SUMMARY.md` — references docs/SUMMARY.md

**Entry flow**: `README.md` → `docs/00-quick-start.md` → learning path through 基础篇/进阶篇/实战篇/大师篇

## Content Organization

```
docs/
├── 基础篇/      # Environment setup, tool installation, first project
├── 进阶篇/      # Core concepts: Agent, MCP, Prompt, Rules
├── 实战篇/      # Tool-specific实战 (Claude Code, Cursor, Codex)
├── 大师篇/      # Advanced: multi-Agent, OpenClaw, workflows
└── iOS专项/     # iOS-specific scenarios (SwiftUI, networking, etc.)
```

## Key Files

- `book.json` — GitBook configuration (plugins, PDF settings, language)
- `.gitbook.yaml` — Root/content path mapping for GitBook
- `docs/gitbook-migration-checklist.md` — GitBook setup documentation

## Notes

- All documentation is in Simplified Chinese (`zh-hans`)
- MD013 (line length), MD033 (inline HTML), MD040 (fenced code language) are disabled in lint rules
- The book targets iOS developers with basic Swift knowledge who want to integrate AI tools
