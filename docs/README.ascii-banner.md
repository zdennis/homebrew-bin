# ascii-banner

Create ASCII art banners from text with color, sizing, and alignment options.

## Installation

```bash
brew install zdennis/bin/ascii-banner
```

## Quick Start

```bash
# Basic usage
ascii-banner "Hello"

# With color
ascii-banner --color coral "Hello"

# Rainbow effect
ascii-banner --rainbow "Success"

# Centered with margin
ascii-banner --center --margin "Welcome"
```

## Options

### Colors

| Option | Description |
|--------|-------------|
| `-c, --color COLOR` | Apply a solid color (see `--list-colors` for options) |
| `--rainbow` | Apply rainbow gradient across text |
| `--random` | Pick a random color |
| `--rainbow --color cyan` | Tinted rainbow effect |
| `--list-colors` | Show all available color names |

### Sizing

By default, ascii-banner auto-scales to fit your terminal. You can override this:

| Option | Description |
|--------|-------------|
| `-s t` or `-s tiny` | Tiny font (3 rows) |
| `-s s` or `-s small` | Small font (4 rows) |
| `-s m` or `-s medium` | Medium font (6 rows) |
| `-s l` or `-s large` | Large font (12 rows, 2x scale) |
| `-s xl` or `-s xlarge` | Extra large font (18 rows, 3x scale) |
| `-s r` or `-s rotate` | Cycle through sizes every 1.5s |
| `--no-auto-scale` | Disable auto-scaling |

### Alignment & Layout

| Option | Description |
|--------|-------------|
| `--left` | Left-align (default) |
| `--center` | Center horizontally and vertically |
| `--right` | Right-align |
| `-w, --width WIDTH` | Set maximum width |
| `--height HEIGHT` | Set maximum height |

### Margin

The `-m, --margin` option supports flexible syntax:

```bash
ascii-banner --margin "Hello"           # Default 2-unit margin all sides
ascii-banner --margin=4 "Hello"         # 4-unit margin all sides
ascii-banner --margin 4,2 "Hello"       # 4 vertical, 2 horizontal
ascii-banner --margin 2,1,3,1 "Hello"   # top, bottom, left, right
```

### Interactive Modes

| Option | Description |
|--------|-------------|
| `-W, --watch` | Re-render on terminal resize or keypress |
| `-s r` | Rotate through font sizes |
| `--minimal` | Hide footer in interactive modes |

Press `q` to quit interactive modes.

## Examples

```bash
# Error banner in red
ascii-banner --color red "ERROR"

# Success message with rainbow
ascii-banner --rainbow --center "SUCCESS"

# Large centered welcome banner
ascii-banner -s l --center --margin "WELCOME"

# Tiny status indicator
ascii-banner -s t --color green "OK"

# Watch mode for dynamic displays
ascii-banner --watch --center --rainbow "HELLO"

# Rotating size demo
ascii-banner -s r --center "DEMO"
```

## Supported Characters

- Letters: A-Z (case insensitive)
- Numbers: 0-9
- Punctuation: `- _ . , : ; ! ? ' "`
- Brackets: `( ) [ ] { } < >`
- Symbols: `+ = * & @ # $ % ^ ~ | / \`
- Space

## See Also

- [homebrew-bin](../README.md) - Full list of available tools
