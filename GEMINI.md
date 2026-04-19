# Project Overview: AI Coding Guide Book 📚

A comprehensive, systematic guide for iOS developers to master AI-assisted programming. It covers everything from environment setup to multi-agent collaboration, focusing on tools like Claude Code, Cursor, and Codex.

- **Project Type:** Documentation (GitBook-based)
- **Target Audience:** iOS Developers (Swift/Xcode), Independent Developers
- **Core Technologies:** Markdown, GitBook, Bash
- **Key Frameworks/Concepts:** Model Context Protocol (MCP), AI Agents, Prompt Engineering

## 📁 Directory Structure

- `docs/`: Core documentation content (Basic, Advanced, Practical, Master levels).
- `examples/`: Code templates (Swift) and Prompt templates.
- `scripts/`: Automation scripts for environment setup and site preview.
- `resources/`: External links and resources.
- `styles/`: Custom CSS for web and PDF versions.

## 🛠 Building and Running

### Prerequisites
- macOS (recommended for iOS development contexts)
- Node.js (LTS version)
- GitBook CLI (`npm install -g gitbook-cli`)

### Key Commands
- **Environment Setup:** `bash scripts/setup.sh` (Installs Homebrew, nvm, Node.js, and Git).
- **Local Preview:** `bash scripts/preview.sh` (Runs `gitbook serve` on http://localhost:4000).
- **Build Site:** `gitbook build`.
- **Install Plugins:** `gitbook install`.

## ✍️ Development Conventions

### Documentation Standards
- **File Naming:** Use Chinese for folders (e.g., `基础篇/`) and numeric prefixes for sorting (e.g., `01-环境搭建.md`).
- **Markdown Style:** 
  - Standard Markdown with relative links (`[link](./file.md)`).
  - Code blocks MUST include language tags (e.g., ` ```swift `).
  - Hierarchy: H1 (Title) -> H2 (Section) -> H3 (Sub-section).
- **Emoji Usage:** Strategic use of emojis for better readability (e.g., 🎯 for goals, 🛠 for tools, 💡 for tips).

### Maintenance Guidelines (See AGENTS.md for details)
- **Conciseness:** Avoid filler; get straight to the point.
- **Accuracy:** Prioritize Tier 1 sources (Official docs from Anthropic, OpenAI, Apple, MCP).
- **Structure:** Every chapter should follow: Concept -> Importance -> Practice -> Best Practices -> FAQ -> Summary.
- **Quality Check:** Ensure all links are valid and code snippets are runnable (Swift examples should aim for iOS 17+ standards).

## 🔑 Key Files
- `README.md`: Project entry and high-level overview.
- `SUMMARY.md`: Definitive structure and navigation for GitBook.
- `AGENTS.md`: CRITICAL instructions for AI agents maintaining this project.
- `.gitbook.yaml`: GitBook configuration.
- `CONTRIBUTING.md`: Contribution guidelines and coding standards.
