---
description: Manage Homebrew formulas for tools from the zdennis/bin repository
---

# homebrew-formula

Manage Homebrew formulas for tools from the zdennis/bin repository.

## Usage

```
/homebrew-formula create <tool-name>
/homebrew-formula update <tool-name>
```

Both commands automatically detect the latest version by finding the newest `<tool-name>-v*` tag in the zdennis/bin repository. No need to specify a version number.

## Commands

### create

Create a new Homebrew formula for a tool that doesn't have one yet. Automatically uses the latest tagged version.

### update

Update an existing formula to the latest tagged version. Automatically detects if a newer version is available, updates the version number, sha256, and refreshes the documentation.

---

## Create Instructions

When invoked with `create <tool-name>`, follow these steps:

### 1. Check formula doesn't already exist

```bash
ls Formula/<tool-name>.rb
```

If it exists, inform the user and suggest using `update` instead.

### 2. Find the latest tag

Look for tags matching `<tool-name>-v*` in the zdennis/bin repository:

```bash
git ls-remote --tags https://github.com/zdennis/bin.git | grep "<tool-name>-v" | sort -V | tail -1
```

Extract the version number from the tag (e.g., `ascii-banner-v1.2.0` → `1.2.0`).

If no tag exists, stop and inform the user they need to create a tag first:
```bash
cd ~/.bin-zdennis && git tag <tool-name>-v<VERSION> && git push --tags
```

### 3. Verify the tool exists at that tag

```bash
curl -sI "https://raw.githubusercontent.com/zdennis/bin/<tool-name>-v<VERSION>/bin/<tool-name>" | head -1
```

Should return `HTTP/2 200`. If not, stop and report the error.

### 4. Get the SHA256 checksum

```bash
curl -sL "https://raw.githubusercontent.com/zdennis/bin/<tool-name>-v<VERSION>/bin/<tool-name>" | shasum -a 256
```

### 5. Read the tool to extract description and usage

Fetch the tool source and extract:
- **Description**: From header comments (usually lines starting with `#`). Create a concise description (under 80 chars) for the formula's `desc` field.
- **Usage examples**: From comment block or `--help` output
- **Options/flags**: Document all command-line options

### 6. Check for dependencies

Look at the shebang line:
- `#!/usr/bin/env ruby` → `depends_on "ruby"`
- `#!/usr/bin/env python3` → `depends_on "python@3"`
- `#!/usr/bin/env node` → `depends_on "node"`
- `#!/bin/bash` or `#!/usr/bin/env bash` → no dependency needed

### 7. Create the formula

Create `Formula/<tool-name>.rb` with this structure:

```ruby
class ToolName < Formula
  desc "<description from step 5>"
  homepage "https://github.com/zdennis/bin"
  version "<VERSION>"
  url "https://raw.githubusercontent.com/zdennis/bin/<tool-name>-v#{version}/bin/<tool-name>"
  sha256 "<sha256 from step 4>"
  license "MIT"

  depends_on "<dependency>"  # if needed

  def install
    bin.install "<tool-name>"
  end

  test do
    # Simple test - adjust based on tool's --help or --version output
    assert_match "<expected output>", shell_output("#{bin}/<tool-name> --help", 0)
  end
end
```

Note: The class name should be CamelCase (e.g., `ascii-banner` → `AsciiBanner`, `retry-command` → `RetryCommand`).

### 8. Create documentation

Create `docs/README.<tool-name>.md` following this template:

```markdown
# <tool-name>

<One-line description of what the tool does.>

## Installation

\`\`\`bash
brew install zdennis/bin/<tool-name>
\`\`\`

## Quick Start

\`\`\`bash
# Basic usage
<tool-name> <example args>

# Another common use case
<tool-name> <other example>
\`\`\`

## Options

| Option | Description |
|--------|-------------|
| `-h, --help` | Show help message |
| `<other options>` | `<descriptions>` |

## Examples

\`\`\`bash
# Example 1: <description>
<tool-name> <args>

# Example 2: <description>
<tool-name> <args>
\`\`\`

## See Also

- [homebrew-bin](../README.md) - Full list of available tools
```

Populate the template with actual usage information extracted from the tool's source code and `--help` output.

### 9. Update the main README

Edit `README.md` to add the new tool to the table (keep alphabetical order):

```markdown
| <tool-name> | [README](docs/README.<tool-name>.md) | `brew install zdennis/bin/<tool-name>` | <1-3 sentence description> |
```

### 10. Test the installation

```bash
brew uninstall <tool-name> 2>/dev/null || true
brew install zdennis/bin/<tool-name>
```

If installation fails due to sha256 mismatch or other errors, fix the formula and retry.

### 11. Verify the tool works

Run a basic command to verify the installed tool works:

```bash
<tool-name> --version
# or
<tool-name> --help
```

### 12. Report success

Summarize what was created:
- Formula: `Formula/<tool-name>.rb`
- Documentation: `docs/README.<tool-name>.md`
- README.md updated with new table row
- Installation verified working

Remind the user to commit and push:
```bash
git add Formula/<tool-name>.rb docs/README.<tool-name>.md README.md
git commit -m "Add <tool-name> formula"
git push
```

---

## Update Instructions

When invoked with `update <tool-name>`, follow these steps:

### 1. Verify formula exists

```bash
ls Formula/<tool-name>.rb
```

If it doesn't exist, inform the user and suggest using `create` instead.

### 2. Read the current formula

Read `Formula/<tool-name>.rb` to get the current version.

### 3. Find the latest tag

```bash
git ls-remote --tags https://github.com/zdennis/bin.git | grep "<tool-name>-v" | sort -V | tail -1
```

Extract the version number from the tag.

### 4. Check if update is needed

Compare the latest tag version with the current formula version.

**If versions match:** Inform the user they're already on the latest version. Ask if they want to force update anyway (useful if the tag was re-pushed with changes). Use the AskUserQuestion tool:

- "Already on latest version (v<VERSION>). Force update?"
- Options: "Yes, force update" / "No, skip"

If user chooses not to force update, stop here and report that no changes were made.

If user chooses to force update, or if versions differ, continue to the next step.

### 5. Verify the tool exists at the tag

```bash
curl -sI "https://raw.githubusercontent.com/zdennis/bin/<tool-name>-v<VERSION>/bin/<tool-name>" | head -1
```

### 6. Get the SHA256 checksum

```bash
curl -sL "https://raw.githubusercontent.com/zdennis/bin/<tool-name>-v<VERSION>/bin/<tool-name>" | shasum -a 256
```

### 7. Update the formula

Edit `Formula/<tool-name>.rb`:
- Update `version "<VERSION>"` (if changed)
- Update `sha256 "<new_sha256>"`

### 8. Update documentation

Fetch the tool source and update the documentation to ensure it's in sync:

1. Read the tool source to extract current options, features, and usage
2. Update `docs/README.<tool-name>.md` with current information
3. Update the description in README.md if needed

This ensures documentation always reflects the latest version.

### 9. Test the installation

```bash
brew uninstall <tool-name> 2>/dev/null || true
brew install zdennis/bin/<tool-name>
```

### 10. Verify the tool works

```bash
<tool-name> --version
```

Confirm it shows the expected version.

### 11. Report success

Summarize what was updated:

**If version changed:**
- Formula updated: `<old_version>` → `<new_version>`
- SHA256 updated
- Documentation refreshed
- Installation verified working

**If force update (same version):**
- SHA256 refreshed
- Documentation refreshed
- Installation verified working

Remind the user to commit and push:
```bash
git add Formula/<tool-name>.rb docs/README.<tool-name>.md README.md
git commit -m "Update <tool-name> to v<VERSION>"
git push
```
