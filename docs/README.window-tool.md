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
| `active-window [--id]` | Print info about the frontmost app's primary window |
| `border <window> [--color C] [--width N]` | Add a persistent border that tracks a window |
| `columnize <w> <w> [<w>...] [--gap N]` | Arrange windows side-by-side in columns |
| `count` | Print number of windows |
| `dim <window> [--opacity N] [--duration N]` | Dim everything except a window |
| `flash <window> [--color C] [--count N]` | Flash a colored overlay on a window |
| `focus <window>` | Bring window to front |
| `fullscreen <window>` | Enter macOS fullscreen mode |
| `highlight <window> [--color C] [--duration S]` | Briefly highlight a window (auto-dismisses) |
| `info <window>` | Show detailed info for a window |
| `list` | List windows (all apps, or one app with `--app`) |
| `maximize <window>` | Maximize window to fill screen |
| `minimize <window>` | Minimize a window |
| `move <window> <x> <y> [<w> <h>]` | Move/resize window |
| `move-to-screen <window> <screen>` | Move window to a different display |
| `preview <window> [--output <path>]` | Capture a window screenshot as PNG |
| `record <window> --output <path> [options]` | Record video of a window |
| `resize <window> <width> <height>` | Resize window |
| `restore` | Restore all minimized windows |
| `restore-layout <file>` | Restore window layout from a JSON file |
| `save-layout <file>` | Save window layout to a JSON file |
| `screens` | List all displays with bounds |
| `shake <window> [offset] [count] [delay]` | Shake a window |
| `shell-init <shell>` | Print shell integration snippet (zsh, bash, fish) |
| `snap <window> <position>` | Snap window to screen region |
| `stack [offset]` | Cascade windows with offset (default: 30) |
| `unborder [<window>]` | Remove borders for target app (or one window) |
| `unborder-all` | Remove all active borders |
| `undim` | Remove active dim overlay |
| `unfullscreen <window>` | Exit macOS fullscreen mode |
| `watch [interval]` | Watch for window changes (default: 1.0s) |

### Window selectors

`<window>` can be:
- An index: `0`, `1`, `2`...
- A window ID: `id=<window_id>` (e.g., `id=1341`)
- A title match: `title=<pattern>` (e.g., `title="my notes"`)

Use `list` to see available indices and window IDs.

### Record options

| Option | Description |
|--------|-------------|
| `--fps N` | Frames per second (default: 30) |
| `--duration N` | Recording duration in seconds |
| `--no-countdown` | Skip countdown before recording |
| `--no-border` | Don't show recording border |

### Snap positions

`left`, `right`, `top`, `bottom`, `top-left`, `top-right`, `bottom-left`, `bottom-right`, `center`, `maximize`

### Colors

`red`, `green`, `blue`, `yellow`, `orange`, `purple`, `white`, `cyan`, `magenta`, `random`

## Options

| Option | Description |
|--------|-------------|
| `--app <name-or-id>` | Target application by name or bundle ID (default: `com.googlecode.iterm2`) |
| `--json` | Output in JSON format |
| `--version, -v` | Print version and exit |
| `-h, --help` | Show help message |

## Command Chaining

Use `+` to run multiple commands in sequence, sharing `--app` and `--json` flags:

```bash
window-tool --app Safari focus 0 + highlight 0 --color red
window-tool --app iTerm info 0 + info 1
```

## Examples

```bash
# List all displays
window-tool screens

# Get active screen bounds for positioning
window-tool active-screen

# Move window by title
window-tool move title="my-notes" 0 0 1400 1000

# Snap window to right half of screen
window-tool snap 0 right

# Save and restore window layouts
window-tool save-layout ~/layout.json
window-tool restore-layout ~/layout.json

# Count Safari windows (by name or bundle ID)
window-tool --app Safari count

# Arrange windows side-by-side in columns
window-tool columnize 0 1 2 --gap 10

# Highlight a window with a color flash
window-tool highlight 0 --color green

# Add a persistent border to track a window
window-tool border 0 --color blue --width 3

# Dim everything except a window
window-tool dim 0 --opacity 0.5

# Capture a window screenshot
window-tool preview 0 --output ~/screenshot.png

# Chain commands
window-tool --app Safari focus 0 + highlight 0 --color red

# Get window list as JSON
window-tool --json list
```

## See Also

- [Source Repository](https://github.com/zdennis/window-tool) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
