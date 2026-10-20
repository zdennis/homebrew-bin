# window-tool

Fast macOS CLI for listing, inspecting, moving, and resizing application windows using the Accessibility API.

## Installation

```bash
brew install zdennis/bin/window-tool
```

**Note:** Requires Accessibility permissions for your terminal app (System Settings > Privacy & Security > Accessibility). Run `window-tool doctor` to check.

## Quick Start

```bash
# List windows for the default app (iTerm2)
window-tool list

# List all windows, all apps
window-tool list --all

# Move window 0 to position (100, 50)
window-tool move 0 100 50

# Move and resize window 0
window-tool move 0 100 50 1200 900

# Snap window to left half of screen
window-tool snap 0 left

# Target a different app by name or bundle ID
window-tool --app Safari list

# Check permissions and version
window-tool doctor
```

## Commands

### Query

| Command | Description |
|---------|-------------|
| `list [<window>]` | List windows (all apps, or one app with `--app`); many filters: `--title`, `--screen`, `--visible`, `--no-minimized`, `--sort`, `--ids`, `--fields` |
| `info <window>` | Show detailed info for a window |
| `tree <window>` | Print a window's accessibility element tree: role, title, value, frame and actions (`--depth N`, `--max-value N`) |
| `text <window>` | Print the text inside a window, one value per line (`--path`, `--focused`, `--raw`, `--max-value N`) |
| `count` | Print the number of windows for `--app` |
| `active-window [--id]` | Print info about the frontmost app's primary window |
| `active-screen` | Print the active screen's usable bounds |
| `screens` | List all displays with bounds and scale |
| `pick` | Click a window to print its ID (blocks until you click) |
| `watch [--interval <s>] [--ndjson] [--once] [--timeout <s>]` | Print window changes for `--app` until interrupted, `--once` or `--timeout` |
| `wait <window>` | Block until a window exists (`--gone`: is gone; `--stable <s>`, `--timeout <s>`) |

### Move & size

| Command | Description |
|---------|-------------|
| `press <window>` | Press a button or perform another accessibility action on one element, found by `--path`, `--role` and/or `--title` (`--action`, default `AXPress`) |
| `snap <window> <position>` | Snap a window to a screen region, or `--rect=<x,y,w,h>` fractions, or `--grid=<cols>x<rows> --cell=<col>,<row> [--span=<cols>,<rows>]` |
| `move <window> <x> <y> [<w> <h>]` | Move a window, optionally resizing it |
| `resize <window> <w> <h>` | Resize a window |
| `center <window>` | Center a window on its screen (`--size N` or `--size W,H` to resize first) |
| `maximize <window>` | Maximize a window to fill its screen |
| `move-to-screen <window> <screen>` | Move a window to another display (index, or primary/external/left/right/next/prev) |
| `focus <window>` | Bring a window to the front |
| `minimize <window>` | Minimize a window |
| `close <window> \| --all` | Close a window, or every window of `--app` |
| `quit` | Quit `--app` and wait until it has exited (`--force`) |
| `restore [<window>]` | Restore minimized windows: all for `--app`, or just one |
| `fullscreen <window>` / `unfullscreen <window>` | Enter / exit macOS fullscreen |

### Layout

| Command | Description |
|---------|-------------|
| `tile [<window>...]` | Tile windows in a grid (`--gap N`, `--cols N`, `--untile`) |
| `columnize <w> <w> [<w>...]` | Arrange windows side by side in columns (`--gap N`) |
| `stack [<window>...]` | Cascade the windows for `--app`, or just the ones named (`--offset N`, default 30) |
| `sidebar <window>` | Pin a window to an edge of its screen (`--side`, `--full-height`, `--full-width`, `--push`, `--unpush`) |
| `save-layout <name-or-file>` | Save windows as a named layout (in `~/.config/window-tool/layouts/`) or to a JSON file |
| `restore-layout <name-or-file>` | Move windows back to a saved layout (`--launch`, `--dry-run`) |
| `layouts` | List named layouts |
| `undo [--steps N \| --list]` | Revert the last command that moved or resized windows |

### Overlays

| Command | Description |
|---------|-------------|
| `highlight <window>` | Briefly highlight a window (`--color`, `--duration <s>`) |
| `flash <window>` | Flash a colored overlay on a window (`--color`, `--count N`) |
| `border <window>` | Add a persistent border that tracks a window (`--color`, `--width N`) |
| `unborder [<window>]` | Remove borders for `--app`, or for one window |
| `unborder-all` | Remove all active borders |
| `dim <window>` | Dim everything except a window while it is active (`--opacity`, `--duration <s>`) |
| `undim` | Remove the active dim overlay |
| `identify` | Label visible windows with their IDs (`--color`, `--duration <s>`) |
| `shake <window>` | Shake a window to draw attention (`--offset N`, `--count N`, `--delay <s>`) |

### Capture

| Command | Description |
|---------|-------------|
| `preview <window>` | Save a screenshot of a window as PNG (`--output <path>`) |
| `record <window> --output <path>` | Record video of a window (`--fps N`, `--duration <s>`, `--no-countdown`, `--no-border`) |
| `pip <window>` | Show a live, always-on-top thumbnail of a window (`--scale`, `--position`, `--fps`, `--duration`) |

### Meta

| Command | Description |
|---------|-------------|
| `help [<command>]` | Show all commands, or one command's arguments and options |
| `commands` | List every command (`--json`: arguments, options and more) |
| `doctor` | Report the version and whether Accessibility and Screen Recording are granted |
| `shell-init <shell>` | Print a shell integration snippet (zsh, bash, fish) |

### Window selectors

`<window>` can be:
- An index: `0`, `1`, `2`...
- A window ID: `id=<window_id>` (e.g., `id=1341`)
- A title match: `title=<pattern>` (e.g., `title="my notes"`; `--first` uses the first match when several match)

Use `list` or `pick` to find indexes and window IDs.

### Snap positions

`left`, `right`, `top`, `bottom`, `top-left`, `top-right`, `bottom-left`, `bottom-right`, `center`, `maximize` — or a custom region with `--rect=<x,y,w,h>` (fractions of the visible frame) or `--grid`/`--cell`/`--span`.

### Colors

`red`, `green`, `blue`, `yellow`, `orange`, `purple`, `white`, `cyan`, `magenta`, `random`

## Options

Global options (before or after any command):

| Option | Description |
|--------|-------------|
| `--app <name-or-id>` | Target application by name or bundle ID (an exact name wins over substrings); in a chain, it applies to its command and later ones |
| `--exact` | Match `--app` only as a whole app name or bundle ID, ignoring case |
| `--json` | Output in JSON format |
| `--keep-going` | In a chain, run the remaining commands after one fails |
| `--first` | With `title=`, use the first match when several windows match |
| `--verbose` | After a command that changes windows, print one line per window |
| `--help, -h` | Show help; after a command, show that command's help |
| `--version, -v` | Print version and exit |

## Command Chaining

Use `+` to run multiple commands in sequence. Subsequent commands inherit the window selector from the previous command, and `--app` applies to its command and later ones:

```bash
window-tool --app Safari snap 0 center + focus + highlight --color red
window-tool --app iTerm info 0 + info 1
window-tool focus id=2457 + highlight + dim id=2789
window-tool + --app Notes list
```

Under `--json`, a chain prints a `{"results", "failed_at"}` envelope with one entry per command.

## Undo

Commands that move or resize windows record an undo entry. Revert with:

```bash
window-tool undo           # revert the last change
window-tool undo --steps 3 # revert the last 3 changes, newest first
window-tool undo --list    # show the undo history
```

## Examples

```bash
# List all displays
window-tool screens

# Get active screen bounds for positioning
window-tool active-screen

# Move window by title
window-tool move title="my-notes" 0 0 1400 1000

# Snap to a custom region: left 70% of the screen
window-tool snap 0 --rect=0,0,0.7,1

# Snap to a grid cell (6x4 grid, cell 1,0, spanning 2 columns)
window-tool snap 0 --grid=6x4 --cell=1,0 --span=2,1

# Inspect a window's UI elements, then press a button by role
window-tool --app Safari tree 0 --depth 3
window-tool --app Safari press 0 --role AXButton --title "Reload"

# Read the focused text field
window-tool --app Notes text 0 --focused

# Wait for a window to appear (e.g., after launching an app)
window-tool --app "System Settings" wait --timeout 10

# Save and restore window layouts
window-tool save-layout work
window-tool restore-layout work

# Tile Safari's windows in a grid, then undo it
window-tool --app Safari tile
window-tool tile --untile

# Count Safari windows (by name or bundle ID)
window-tool --app Safari count

# Arrange windows side-by-side in columns
window-tool columnize 0 1 2 --gap 10

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
