# alias-directory

Manage directory aliases for quick `cd` navigation. Create shortcuts to jump to frequently used directories.

## Installation

```bash
brew install zdennis/bin/alias-directory
```

## Setup

Add this to your shell profile (`~/.bashrc`, `~/.zshrc`, etc.):

```bash
[ -f ~/.alias-directoryrc ] && source ~/.alias-directoryrc
```

Then reload your shell or run `source ~/.bashrc` (or `~/.zshrc`).

## Quick Start

```bash
# Create an alias for the current directory
alias-directory create myproject

# Create an alias for a specific path
alias-directory create work ~/Code/work-project

# List all aliases
alias-directory list

# Use the alias (after reloading shell)
myproject  # cd's to the aliased directory
```

## Commands

| Command | Description |
|---------|-------------|
| `create <name> [path]` | Create alias for path (defaults to current directory) |
| `list` | List all directory aliases alphabetically |
| `config` | Show configuration file location |
| `-h, --help` | Show help message |
| `-v, --version` | Show version |

## Examples

```bash
# Alias your projects
alias-directory create dotfiles ~/.dotfiles
alias-directory create notes ~/Documents/Notes

# After reloading shell, just type the alias name
dotfiles  # instantly cd to ~/.dotfiles
notes     # instantly cd to ~/Documents/Notes

# See all your aliases
alias-directory list
# Output:
# dotfiles -> /Users/you/.dotfiles
# notes -> /Users/you/Documents/Notes
```

## How It Works

Aliases are stored in `~/.alias-directoryrc` as shell alias commands. When you source this file in your shell profile, the aliases become available as commands that `cd` to the target directory.

## See Also

- [Source Repository](https://github.com/zdennis/bin) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
