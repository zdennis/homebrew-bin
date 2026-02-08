# code+x

Create executable files and open them in VS Code. Combines `touchp`, `chmod +x`, and `code` in one command.

## Installation

```bash
brew install zdennis/bin/code+x
```

## Quick Start

```bash
# Create a new executable script and open it in VS Code
code+x my-script.sh

# Create multiple executable files
code+x script1.sh script2.sh

# Create in a new directory (parent directories are created automatically)
code+x ~/bin/my-new-tool
```

## Options

| Option | Description |
|--------|-------------|
| `-v, --version` | Show version |

## How It Works

`code+x` runs three commands in sequence:

1. `touchp <files>` - Creates the file(s) and any parent directories
2. `chmod a+x <files>` - Makes the file(s) executable
3. `code <files>` - Opens the file(s) in VS Code

## Examples

```bash
# Create a new bash script
code+x deploy.sh

# Create a Python script in a new directory
code+x scripts/utils/backup.py

# Create multiple scripts at once
code+x bin/build bin/test bin/deploy
```

## See Also

- [touchp](README.touchp.md) - Touch files with automatic parent directory creation
- [Source Repository](https://github.com/zdennis/bin) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
