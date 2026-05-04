# Jinja JSON Formatter

![License](https://img.shields.io/badge/license-MIT-blue) ![UI](https://img.shields.io/badge/UI-Glassmorphism-7c3aed) ![Python](https://img.shields.io/badge/requires-Python%203-yellow)

---

## The Problem

JSON and Jinja templating are used together across many automation platforms, workflow tools, and custom applications. But when you copy JSON from a text editor, API docs, or another tool, it often contains things that break strict JSON parsers:

| Problem | Example | What happens |
|---------|---------|--------------|
| Line comments | `// this is a comment` | Rejected as invalid JSON |
| Block comments | `/* comment */` | Rejected as invalid JSON |
| Literal newlines inside strings | A multi-line value | Breaks JSON structure |
| Raw control characters | Invisible copy-paste artifacts | Causes silent failures |
| Jinja expressions with special chars | `{{ value \| default("x") }}` | Gets corrupted by generic formatters |

Generic JSON formatters also don't understand Jinja — they mangle `{{ }}` and `{% %}` expressions when trying to escape or reformat the content around them.

---

## What This Tool Does

**Jinja JSON Formatter** is a single-page browser tool that cleans up JSON containing Jinja template expressions so it parses correctly and is easy to read. It:

- **Strips comments** (`//` and `/* */`) automatically
- **Escapes control characters** — literal newlines, tabs, and other invisible characters inside string values
- **Protects Jinja expressions** (`{{ }}` and `{% %}`) during processing so they are never corrupted — pipes, filters, whitespace control, and nested expressions all come through intact
- **Highlights the result** with Jinja-aware syntax colors — Jinja expressions appear in amber so they stand out clearly from surrounding JSON content
- **Logs errors** when JSON is too broken to fix automatically, with a persistent history across sessions
- **Runs 100% locally** — your JSON never leaves your machine

---

## Install

Requires Python 3. No other dependencies, no `pip install`, no Node.js.

**Linux / macOS** — paste into a terminal:
```bash
curl -fsSL https://raw.githubusercontent.com/jminiel89/rewst-json-formatter/main/install.sh | bash
```

**Windows** — paste into PowerShell:
```powershell
irm https://raw.githubusercontent.com/jminiel89/rewst-json-formatter/main/install.ps1 | iex
```

Both scripts will:
1. Check that Python 3 is available
2. Clone the repo via git (or download the files directly if git is not installed)
3. Print the exact command to start the tool

> Re-run the same install command at any time to update to the latest version.

---

## Running the Tool

**Linux / macOS:**
```bash
bash ~/jinja-json-formatter/start.sh
```

**Windows (PowerShell):**
```powershell
powershell -File "$env:USERPROFILE\jinja-json-formatter\start.ps1"
```

Then open **http://localhost:8080** in your browser.

The server binds to `127.0.0.1` (your machine only) by default. To make it accessible on your local network, open `start.sh` or `start.ps1` and change the bind address to `0.0.0.0`.

---

## How to Use It

1. **Paste** your JSON into the left panel
   *(Formatting triggers automatically on paste — no button click needed)*

2. **Review** the auto-fix summary below the toolbar
   *(Example: "Auto-fixed: Stripped line comments · Fixed literal newlines in strings")*

3. **Check** the right panel for the syntax-highlighted result
   - Blue = JSON keys
   - Rose = string values
   - Amber = Jinja expressions (`{{ }}` / `{% %}`)
   - Green dot = valid, ready to copy

4. **Click Copy Output** and paste wherever you need it

> **Keyboard shortcut:** `Ctrl+Enter` (or `Cmd+Enter` on Mac) triggers formatting from anywhere on the page.

---

## Example Template

Click **Load Example** in the toolbar to load a sample JSON payload showing how Jinja variables and filters look inside a real JSON structure. Use it as a reference or starting point.

---

## Error Log

When JSON can't be fixed automatically, the error is recorded in the **Error Log** (click the ⚠ button in the toolbar). The log:

- Persists across browser sessions (stored in browser `localStorage`)
- Can be exported as a JSON file for sharing or troubleshooting
- **Does not store your input JSON** — only the error message, timestamp, and what fixes were attempted

---

## Files

```
index.html      # The entire app — HTML, CSS, and JavaScript in one file. No build step.
template.json   # Example JSON payload with Jinja expressions
start.sh        # Starts the local server on Linux / macOS
start.ps1       # Starts the local server on Windows
install.sh      # One-liner installer for Linux / macOS
install.ps1     # One-liner installer for Windows
```

---

## License

MIT — free to use, modify, and share.
