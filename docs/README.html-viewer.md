# html-viewer

An always-on-top macOS window for viewing HTML files and URLs from the command line.

## Installation

```bash
brew install zdennis/bin/html-viewer
```

Requires [Node.js](https://nodejs.org) (installed automatically as a dependency) and [Electron](https://electronjs.org) (bundled via npm).

## Quick Start

```bash
# View a local HTML file
html-viewer ~/Desktop/page.html

# View a URL
html-viewer https://example.com

# Auto-close after 10 seconds
html-viewer ~/Desktop/page.html --exit-after-delay 10
```

## Options

| Option | Description |
|--------|-------------|
| `<file-or-url>` | Path to a local HTML file or an http/https URL |
| `--exit-after-delay <secs>` | Automatically quit after N seconds |
| `-h, --help` | Show help message |

## Examples

```bash
# Open an HTML report from CI
html-viewer /tmp/report.html

# Preview a remote page
html-viewer https://example.com

# View and auto-close (useful in scripts)
html-viewer ~/output.html --exit-after-delay 5
```

## See Also

- [Source Repository](https://github.com/zdennis/html-viewer) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
