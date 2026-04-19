# Project Overview: AI Coding Guide Book 📚

A comprehensive, systematic guide for iOS developers to master AI-assisted programming. It covers everything from environment setup to multi-agent collaboration, focusing on tools like Claude Code, Cursor, and Codex.

- **Project Type:** Documentation (GitBook Git Sync)
- **Target Audience:** iOS Developers (Swift/Xcode), Independent Developers
- **Core Technologies:** Markdown, GitBook.com SaaS
- **Key Frameworks/Concepts:** Model Context Protocol (MCP), AI Agents, Prompt Engineering

## 📁 Directory Structure

The repo follows the official GitBook Git Sync spec: **all book content lives under `docs/`**, which is the GitBook content root.

- `docs/`: GitBook content root (README.md + SUMMARY.md + all chapters).
  - `docs/基础篇/` · `docs/进阶篇/` · `docs/实战篇/` · `docs/大师篇/`: Four learning stages.
  - `docs/ios-*.md`: iOS-specific appendix chapters.
  - `docs/examples/`: Prompt templates, AGENTS examples, Swift templates (referenced from SUMMARY).
- `scripts/`: Bootstrap scripts (`setup.sh`, `verify.sh`) for setting up a macOS dev environment.
- `resources/`: External links and resources.
- `.gitbook.yaml`: GitBook Git Sync config (`root: ./docs`).

## 🛠 Building and Running

This project **does not use gitbook-cli** (the legacy CLI was deprecated and no longer installs on modern Node). Publishing is fully handled by **GitBook.com SaaS** via Git Sync: push to `main`, GitBook.com auto-rebuilds.

### Key Commands
- **Environment bootstrap:** `bash scripts/setup.sh` (Homebrew, nvm, Node.js LTS, Git).
- **Verify env:** `bash scripts/verify.sh`.
- **Local preview:** none — preview via GitBook.com space, or use a community fork like Honkit if you need offline preview.
- **CI checks:** markdown lint + link check + shellcheck (see `.github/workflows/ci.yml`).

## ✍️ Development Conventions

### Documentation Standards
- **File Naming:** Chinese for folders (e.g., `基础篇/`) and numeric prefixes for sorting (e.g., `01-环境搭建.md`).
- **Markdown Style:**
  - Standard Markdown with relative links (`[link](./file.md)`).
  - Code blocks MUST include language tags (e.g., ` ```swift `).
  - Hierarchy: H1 (Title) -> H2 (Section) -> H3 (Sub-section).
- **Emoji Usage:** Strategic use for readability (🎯 goals, 🛠 tools, 💡 tips).
- **SUMMARY paths** are relative to `docs/` (the content root). Do NOT prefix with `./docs/`.

### Maintenance Guidelines (See AGENTS.md for full details)
- **Conciseness:** Avoid filler; get straight to the point.
- **Accuracy:** Prioritize Tier 1 sources (Official docs from Anthropic, OpenAI, Apple, MCP).
- **Structure:** Every chapter follows: Concept -> Importance -> Practice -> Best Practices -> FAQ -> Summary.
- **Quality Check:** Ensure all links are valid and code snippets are runnable (Swift examples target iOS 17+).

## 🔑 Key Files
- `README.md`: GitHub repo homepage (not rendered by GitBook).
- `docs/README.md`: Book homepage (GitBook's first page).
- `docs/SUMMARY.md`: GitBook TOC — single source of truth for navigation.
- `AGENTS.md`: CRITICAL instructions for AI agents maintaining this project.
- `.gitbook.yaml`: GitBook Git Sync config.
- `CONTRIBUTING.md`: Contribution guidelines and coding standards.
