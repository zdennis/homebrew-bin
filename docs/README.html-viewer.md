# html-viewer

An always-on-top macOS window for viewing HTML files, Markdown files, and URLs from the command line.

## Installation

```bash
brew install zdennis/bin/html-viewer
```

Requires [Node.js](https://nodejs.org) (installed automatically as a dependency) and [Electron](https://electronjs.org) (bundled via npm).

## Quick Start

```bash
# View a local HTML file
html-viewer ~/Desktop/page.html

# View a Markdown file
html-viewer ~/Documents/notes.md

# View a URL
html-viewer https://example.com

# Auto-close after 10 seconds
html-viewer ~/Desktop/page.html --exit-after-delay 10
```

## Options

| Option | Description |
|--------|-------------|
| `<file-or-url>` | Path to a local HTML/Markdown file or an http/https URL |
| `--exit-after-delay <secs>` | Automatically quit after N seconds |
| `-h, --help` | Show help message |

## Features

- **Always-on-top window** — floats above all other windows
- **Markdown rendering** — GitHub-flavored Markdown with syntax highlighting
- **Hot-reload** — automatically reloads when the local file changes on disk
- **Auto-height** — window resizes to fit content (capped at 80% of screen height)
- **Shrink to corner** — collapse to a 100×100 square in the upper-right corner
- **Recent files** — last 10 opened files/URLs available under File > Recent Files

## Examples

```bash
# Open an HTML report
html-viewer /tmp/report.html

# Preview Markdown notes (hot-reloads as you edit)
html-viewer ~/Documents/notes.md

# Preview a remote page
html-viewer https://example.com

# View and auto-close (useful in scripts)
html-viewer ~/output.html --exit-after-delay 5
```

## See Also

- [Source Repository](https://github.com/zdennis/html-viewer) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
