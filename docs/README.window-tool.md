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

# Target a different app by name or bundle ID
window-tool --app Safari list
```

## Commands

| Command | Description |
|---------|-------------|
| `active-screen` | Print active screen bounds (where mouse cursor is) |
| `columnize <i> <i> [<i>...] [--gap N]` | Arrange windows side-by-side in columns |
| `count` | Print number of windows |
| `focus <window>` | Bring window to front by index |
| `focus-by-title <pattern>` | Bring window to front by title match |
| `fullscreen <window>` | Enter macOS fullscreen mode |
| `fullscreen-by-title <pattern>` | Enter fullscreen by title match |
| `info <window>` | Show detailed info for a window |
| `list` | List all windows with index, window ID, position, size, and title |
| `list-open-windows` | List apps with open windows |
| `maximize <window>` | Maximize window to fill screen |
| `maximize-by-title <pattern>` | Maximize windows matching title |
| `minimize <window>` | Minimize a window by index |
| `minimize-by-title <pattern>` | Minimize a window by title match |
| `move <window> <x> <y> [<w> <h>]` | Move/resize window by index |
| `move-by-title <pattern> <x> <y> [<w> <h>]` | Move/resize windows matching title substring |
| `move-to-screen <window> <screen>` | Move window to a different display |
| `move-to-screen-by-title <pattern> <screen>` | Move window to display by title |
| `resize <window> <w> <h>` | Resize window by index |
| `resize-by-title <pattern> <w> <h>` | Resize windows matching title |
| `restore` | Restore all minimized windows |
| `restore-layout <file>` | Restore window layout from a JSON file |
| `save-layout <file>` | Save window layout to a JSON file |
| `screens` | List all displays with bounds |
| `shake <window> [offset] [count] [delay]` | Shake a window by index |
| `shake-by-title <pattern> [offset] [count] [delay]` | Shake a window by title match |
| `snap <window> <position>` | Snap window to screen region |
| `snap-by-title <pattern> <position>` | Snap window to screen region by title |
| `stack [offset]` | Cascade windows with offset (default: 30) |
| `unfullscreen <window>` | Exit macOS fullscreen mode |
| `unfullscreen-by-title <pattern>` | Exit fullscreen by title match |
| `watch [interval]` | Watch for window changes (default: 1.0s) |

### Window selectors

`<window>` can be an index (`0`, `1`, `2`...) or `id=<window_id>` (e.g., `id=1341`). Use `list` to see available indices and window IDs.

### Snap positions

`left`, `right`, `top`, `bottom`, `top-left`, `top-right`, `bottom-left`, `bottom-right`, `center`, `maximize`

## Options

| Option | Description |
|--------|-------------|
| `--app <name-or-id>` | Target application by name or bundle ID (default: `com.googlecode.iterm2`) |
| `--json` | Output in JSON format |
| `--version, -v` | Print version and exit |
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

# Count Safari windows (by name or bundle ID)
window-tool --app Safari count

# Arrange windows side-by-side in columns
window-tool columnize 0 1 2 --gap 10

# Maximize a window to fill the screen
window-tool maximize 0

# Enter/exit macOS fullscreen
window-tool fullscreen 0
window-tool unfullscreen 0

# Get window list as JSON
window-tool --json list
```

## See Also

- [Source Repository](https://github.com/zdennis/window-tool) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
