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

# Snap window to left half of screen
window-tool snap 0 left

# Target a different app
window-tool --app com.apple.Safari list
```

## Commands

| Command | Description |
|---------|-------------|
| `list` | List all windows with index, position, size, and title |
| `info <index>` | Show detailed info for a window |
| `count` | Print number of windows |
| `move <index> <x> <y> [<w> <h>]` | Move/resize window by index |
| `move-by-title <pattern> <x> <y> [<w> <h>]` | Move/resize windows matching title substring |
| `resize <index> <w> <h>` | Resize window by index |
| `resize-by-title <pattern> <w> <h>` | Resize windows matching title |
| `snap <index> <position>` | Snap window to screen region |
| `snap-by-title <pattern> <position>` | Snap window to screen region by title |
| `move-to-screen <index> <screen>` | Move window to a different display |
| `move-to-screen-by-title <pattern> <screen>` | Move window to display by title |
| `minimize <index>` | Minimize a window by index |
| `minimize-by-title <pattern>` | Minimize a window by title match |
| `restore` | Restore all minimized windows |
| `save-layout <file>` | Save window layout to a JSON file |
| `restore-layout <file>` | Restore window layout from a JSON file |
| `focus <index>` | Bring window to front by index |
| `focus-by-title <pattern>` | Bring window to front by title match |
| `shake <index> [offset] [count] [delay]` | Shake a window by index |
| `shake-by-title <pattern> [offset] [count] [delay]` | Shake a window by title match |
| `stack [offset]` | Cascade windows with offset (default: 30) |
| `watch [interval]` | Watch for window changes (default: 1.0s) |
| `list-open-windows` | List apps with open windows |
| `screens` | List all displays with bounds |
| `active-screen` | Print active screen bounds (where mouse cursor is) |

### Snap positions

`left`, `right`, `top`, `bottom`, `top-left`, `top-right`, `bottom-left`, `bottom-right`, `center`, `maximize`

## Options

| Option | Description |
|--------|-------------|
| `--app <bundle-id>` | Target application (default: `com.googlecode.iterm2`) |
| `--json` | Output in JSON format |
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

# Snap window to right half of screen
window-tool snap 0 right

# Save and restore window layouts
window-tool save-layout ~/layout.json
window-tool restore-layout ~/layout.json

# Count Safari windows
window-tool --app com.apple.Safari count

# Get window list as JSON
window-tool --json list
```

## See Also

- [Source Repository](https://github.com/zdennis/window-tool) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
