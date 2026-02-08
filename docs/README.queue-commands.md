# queue-commands

Run commands from a file sequentially, pausing on errors for manual intervention.

## Installation

```bash
brew install zdennis/bin/queue-commands
```

## Quick Start

```bash
# Run commands from a file
queue-commands -f commands.txt

# Pause before each command for confirmation
queue-commands -f commands.txt --wait

# Continue on error without pausing
queue-commands -f commands.txt --continue
```

## Options

| Option | Description |
|--------|-------------|
| `-f, --file=FILE` | File to read commands from (required) |
| `-w, --wait` | Pause for confirmation before running each command |
| `-c, --continue` | Continue on error without pausing |
| `-v, --verbose` | Print additional information about command execution |
| `-h, --help` | Show help message |
| `--version` | Show version number |

## Command File Format

- One command per line
- Lines starting with `#` are treated as comments and skipped
- Empty lines are ignored

Example `commands.txt`:
```bash
# Build steps
npm install
npm run build
npm test

# Deploy
./deploy.sh
```

## Examples

```bash
# Run a build script with verbose output
queue-commands -f build-steps.txt --verbose

# Interactive mode: confirm each command before running
queue-commands -f deploy-commands.txt --wait

# CI mode: run all commands, don't pause on errors
queue-commands -f ci-commands.txt --continue

# Verbose mode shows progress like "[1/5] Running: npm install"
queue-commands -f commands.txt -v
```

## Behavior

- **Default**: When a command fails (non-zero exit), the script pauses and prompts you to fix the issue before continuing
- **With `--wait`**: Prompts for confirmation before each command
- **With `--continue`**: Runs all commands without pausing on errors
- **With `--verbose`**: Shows command count progress and summary at end

## See Also

- [homebrew-bin](../README.md) - Full list of available tools
