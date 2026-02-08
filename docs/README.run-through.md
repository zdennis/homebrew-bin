# run-through

Run files through multiple shell commands. Pipe file lists and execute multiple commands on them in sequence.

## Installation

```bash
brew install zdennis/bin/run-through
```

## Quick Start

```bash
# Run Ruby files through rubocop and reek
find spec -name "*.rb" | xargs run-through -c rubocop -c reek

# Same with bundle exec
find spec -name "*.rb" | xargs run-through -b rubocop -b reek

# Dry run to see what would happen
find . -name "*.rb" | xargs run-through -c rubocop -n
```

## Options

| Option | Description |
|--------|-------------|
| `-c, --command=COMMAND` | Command to run on files (can be used multiple times) |
| `-b, --bundle-exec-commands=COMMAND` | Command to run with `bundle exec` (can be used multiple times) |
| `-i, --individual` | Run each command once per file instead of once for all files |
| `-n, --dry-run` | Print what would happen without executing |
| `-V, --verbose` | Print each command before running it |
| `-v, --version` | Show version |
| `-h, --help` | Show help message |

## Examples

```bash
# Lint and format JavaScript files
find src -name "*.js" | xargs run-through -c eslint -c prettier

# Run multiple linters on changed Ruby files
git diff --name-only '*.rb' | xargs run-through -b rubocop -b reek -b flay

# Process files individually (one command invocation per file)
find . -name "*.md" | xargs run-through -i -c markdownlint

# Preview commands without running them
find spec -name "*_spec.rb" | xargs run-through -n -b rspec

# Verbose mode to see commands as they run
find lib -name "*.rb" | xargs run-through -V -c rubocop
```

## Use Cases

- **CI/CD pipelines**: Run multiple quality checks on changed files
- **Pre-commit hooks**: Lint and format staged files
- **Batch processing**: Apply multiple transformations to file sets
- **Code review**: Run various analyzers on specific files

## Exit Codes

- `0` - All commands succeeded
- `1` - One or more commands failed

## See Also

- [Source Repository](https://github.com/zdennis/bin) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
