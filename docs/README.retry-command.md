# retry-command

Retry commands with configurable delay, limits, and supervisor mode.

## Installation

```bash
brew install zdennis/bin/retry-command
```

## Quick Start

```bash
# Retry until command succeeds, then exit
retry-command -s -- curl -f http://example.com/health

# Supervisor mode: keep command running forever, restart on exit
retry-command -- ./my-server
```

## Options

| Option | Description |
|--------|-------------|
| `-d, --delay SECONDS` | Delay between retries (default: 10) |
| `-m, --max-retries N` | Maximum retry attempts, 0 for unlimited (default: 0) |
| `-s, --stop-on-success` | Exit after command succeeds (don't rerun) |
| `-q, --quiet` | Suppress retry status messages |
| `-h, --help` | Show help message |
| `-v, --version` | Show version number |

## Examples

```bash
# Keep retrying until command succeeds, then exit
retry-command -s -- curl -f http://example.com/health

# Retry up to 5 times with 30 second delay
retry-command -m 5 -d 30 -s -- ./deploy.sh

# Supervisor mode: keep command running forever, restart on exit
retry-command -- ./my-server

# Quiet mode for scripts
retry-command -q -s -m 10 -- pg_isready -h localhost
```

## Modes

### Stop on Success (default: off)
By default, `retry-command` runs in supervisor mode - it will restart the command even after success. Use `-s` to exit once the command succeeds.

### Supervisor Mode
Without `-s`, the tool acts as a simple process supervisor, restarting the command whenever it exits (success or failure). Useful for keeping long-running services alive.

## See Also

- [homebrew-bin](../README.md) - Full list of available tools
