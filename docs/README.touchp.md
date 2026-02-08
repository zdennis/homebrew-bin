# touchp

Touch a file and create parent directories in its path. A combination of `mkdir -p` and `touch`.

## Installation

```bash
brew install zdennis/bin/touchp
```

## Quick Start

```bash
# Create file and all parent directories
touchp foo/bar/baz/config.yml

# Create multiple files with their directory structures
touchp src/components/Button.tsx src/components/Card.tsx
```

## Options

| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message |
| `-v, --version` | Show version |

## Examples

```bash
# Create a deeply nested config file
touchp config/environments/production/database.yml

# Create test file structure
touchp spec/models/user_spec.rb

# Create multiple files at once
touchp app/models/user.rb app/models/post.rb app/models/comment.rb
```

## Why touchp?

Standard `touch` fails if parent directories don't exist:

```bash
$ touch foo/bar/baz/file.txt
touch: foo/bar/baz/file.txt: No such file or directory
```

With `touchp`, it just works:

```bash
$ touchp foo/bar/baz/file.txt
# Creates foo/, foo/bar/, foo/bar/baz/, and file.txt
```

## See Also

- [Source Repository](https://github.com/zdennis/bin) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
