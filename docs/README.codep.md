# codep

Touch files (creating parent directories) and open them in VS Code in one command. A combination of `touchp` and `code`.

## Installation

```bash
brew install zdennis/bin/codep
```

## Quick Start

```bash
# Create a new file with directories and open in VS Code
codep src/components/Button.tsx

# Create and open multiple files
codep src/models/user.rb src/models/post.rb
```

## Options

| Option | Description |
|--------|-------------|
| `-v, --version` | Show version |

## Examples

```bash
# Start a new React component
codep src/components/NewFeature/index.tsx

# Create config file in nested directory
codep config/environments/staging.yml

# Create multiple test files
codep spec/models/user_spec.rb spec/models/post_spec.rb
```

## How It Works

`codep` combines two operations:
1. `touchp` - Creates the file and any missing parent directories
2. `code` - Opens the file(s) in VS Code

## Dependencies

- `touchp` (installed automatically)
- `code` (VS Code CLI, must be in PATH)

## See Also

- [Source Repository](https://github.com/zdennis/bin) - Original source code
- [touchp](README.touchp.md) - Touch files with parent directory creation
- [homebrew-bin](../README.md) - Full list of available tools
