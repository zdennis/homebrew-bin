# expand-keyword

Manage `$KEYWORD` text expansions stored in a JSON file, with Claude Code `UserPromptSubmit` hook integration for automatic prompt injection.

## Installation

```bash
brew install zdennis/bin/expand-keyword
```

## Quick Start

```bash
# Initialize configuration and keywords file
expand-keyword init

# Add a keyword expansion
expand-keyword add '$ctx' 'You are working in a Ruby on Rails monolith...'

# List all defined keywords
expand-keyword list

# Expand keywords in text
expand-keyword expand 'Please review $ctx'
```

## Options

| Option | Description |
|--------|-------------|
| `--version, -v` | Show version |
| `--help, -h` | Show help message |

## Subcommands

| Subcommand | Options | Description |
|------------|---------|-------------|
| `init` | `[--config PATH] [--file PATH]` | Initialize config and keywords file |
| `config` | `[--config PATH]` | Show config path and contents |
| `list` | `[--file PATH]` | List all defined keywords |
| `add` | `[--file PATH] [--description DESC] $TOKEN "expansion"` | Add or update a keyword |
| `remove` | `[--file PATH] $TOKEN` | Remove a keyword |
| `expand` | `[--file PATH] [--hook] "text with $keywords"` | Expand keywords in text |
| `edit` | `[--file PATH]` | Open keywords file in `$EDITOR` |
| `doctor` | `[--config PATH]` | Check setup and configuration |

## Examples

```bash
# Add a keyword with a description
expand-keyword add --description 'Project context' '$proj' 'This is a Ruby on Rails app using Solid Queue...'

# Expand inline text
expand-keyword expand 'Help me with $proj'

# Remove a keyword
expand-keyword remove '$proj'

# Check that everything is set up correctly
expand-keyword doctor

# Hook mode for Claude Code (reads JSON from stdin)
expand-keyword expand --hook
```

## Claude Code Hook Setup

Add to `~/.claude/settings.json` to enable automatic keyword expansion in all Claude Code prompts:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "expand-keyword expand --hook"
          }
        ]
      }
    ]
  }
}
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `EXPAND_KEYWORD_FILE` | Override the keywords file path |
| `XDG_CONFIG_HOME` | Override the config base directory (default: `~/.config`) |
| `VISUAL` / `EDITOR` | Editor used by the `edit` subcommand |

## See Also

- [Source Repository](https://github.com/zdennis/expand-keywords) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
