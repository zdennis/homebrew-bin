# set-random-background-color

Set iTerm2 background to a random dark color. Useful for visually distinguishing terminal sessions.

## Installation

```bash
brew install zdennis/bin/set-random-background-color
```

## Quick Start

```bash
# Set a random dark background color
set-random-background-color
```

That's it! Each run picks a new random dark color.

## Options

| Option | Description |
|--------|-------------|
| `-v, --version` | Show version |

## Use Cases

- **Distinguish sessions**: Give each terminal tab/window a unique color
- **Project identification**: Run on shell startup in project-specific terminals
- **Visual organization**: Quickly identify terminals at a glance

## How It Works

The script generates a random color from 256 dark color combinations:
- 8 red levels (0-77)
- 8 green levels (0-77)
- 4 blue levels (0-75)

Colors are kept in the dark range to ensure text remains readable.

## Shell Integration

Add to your shell profile to get a random color on each new terminal:

```bash
# ~/.bashrc or ~/.zshrc
set-random-background-color
```

Or use it in project-specific shell hooks (e.g., direnv).

## Requirements

- iTerm2 (macOS terminal emulator)

## See Also

- [homebrew-bin](../README.md) - Full list of available tools
