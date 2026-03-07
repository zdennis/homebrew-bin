# window-tool

Fast macOS CLI for listing, moving, and resizing application windows using the Accessibility API.

## Installation

```bash
brew install zdennis/bin/window-tool
```

**Note:** Requires Accessibility permissions for your terminal app (System Settings > Privacy & Security > Accessibility).

## Quick Start

```bash
# List windows for the default app (iTerm2)
window-tool list

# Move window 0 to position (100, 50)
window-tool move 0 100 50

# Move and resize window 0
window-tool move 0 100 50 1200 900

# Target a different app
window-tool --app com.apple.Safari list
```

## Commands

| Command | Description |
|---------|-------------|
| `list` | List all windows with index, position, size, and title |
| `count` | Print number of windows |
| `move <index> <x> <y> [<w> <h>]` | Move/resize window by index |
| `move-by-title <pattern> <x> <y> [<w> <h>]` | Move/resize windows matching title substring |
| `list-open-windows` | List bundle IDs of apps with open windows |
| `screens` | List all displays with bounds |
| `active-screen` | Print active screen bounds (where mouse cursor is) |

## Options

| Option | Description |
|--------|-------------|
| `--app <bundle-id>` | Target application (default: `com.googlecode.iterm2`) |
| `-h, --help` | Show help message |

## Examples

```bash
# List all displays
window-tool screens

# Get active screen bounds for positioning
window-tool active-screen

# Find which apps have open windows
window-tool list-open-windows

# Move all windows matching a title pattern
window-tool move-by-title "my-notes" 0 0 1400 1000

# Count Safari windows
window-tool --app com.apple.Safari count
```

## See Also

- [Source Repository](https://github.com/zdennis/window-tool) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
