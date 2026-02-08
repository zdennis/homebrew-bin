---
description: Manage Homebrew formulas for tools from any git repository (GitHub, GitLab, etc.)
---

# homebrew-formula

Manage Homebrew formulas for tools from any git repository.

## Usage

```
/homebrew-formula create <tool-name> [--repo <repository>] [--path <tool-path>] [--tag <tag-pattern>]
/homebrew-formula update <tool-name> [--repo <repository>] [--path <tool-path>] [--tag <tag-pattern>]
/homebrew-formula update_readme [<tool-name>...]
/homebrew-formula update_all_formula
```

### Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `--repo` | Repository where the tool lives. Can be a relative path (e.g., `zdennis/bin`) which assumes GitHub, or a full URL (e.g., `https://gitlab.com/user/repo.git`) | Ask user if not provided |
| `--path` | Path to the tool within the repository | `bin/` |
| `--tag` | Tag version to use. Use `*` as a pattern (e.g., `v*` or `<tool>-v*`). If not provided, uses `<tool-name>-v*` pattern | `<tool-name>-v*` |

### Repository Format

- **Relative path**: `owner/repo` → assumes `https://github.com/owner/repo.git`
- **Full URL**: `https://gitlab.com/owner/repo.git` → used as-is (supports GitHub, GitLab, etc.)

Both commands automatically detect the latest version by finding the newest matching tag in the repository.

## Commands

### create

Create a new Homebrew formula for a tool that doesn't have one yet. Automatically uses the latest tagged version.

### update

Update an existing formula to the latest tagged version. Automatically detects if a newer version is available, updates the version number, sha256, and refreshes the documentation.

### update_readme

Regenerate README documentation for one or more tools without updating the formula version. Useful for refreshing documentation after manual changes or ensuring READMEs stay in sync with the tool's source.

- If no tools specified: Prompts to update all tools or select specific ones
- If tools specified: Updates README for each listed tool

### update_all_formula

Update the `Formula/zdennis-bin-all.rb` meta-formula to include all current formulas as dependencies. This command:

- Scans `Formula/` for all `.rb` files (excluding `zdennis-bin-all.rb` itself)
- Updates the `depends_on` list in `Formula/zdennis-bin-all.rb` to match
- Updates the `bin/zdennis-bin-all` script in `zdennis/bin` repo with current tool list
- Bumps the version (prompts user for semver choice), tags, and pushes
- Keeps formulas in alphabetical order

This command is automatically invoked at the end of `create` and `update` commands.

---

## Create Instructions

When invoked with `create <tool-name>`, follow these steps:

### 1. Check formula doesn't already exist

```bash
ls Formula/<tool-name>.rb
```

If it exists, inform the user and suggest using `update` instead.

### 2. Resolve repository URL

Determine the repository URL based on `--repo` parameter:

**If `--repo` is provided:**
- If it's a relative path (e.g., `owner/repo`), construct: `https://github.com/owner/repo.git`
- If it's a full URL (contains `://`), use it as-is

**If `--repo` is NOT provided:**
Use `AskUserQuestion` to ask the user:
- Question: "What repository contains this tool?"
- Options:
  - "zdennis/bin (GitHub)"
  - "Enter custom repository"

Store the resolved repository URL as `<REPO_URL>` and derive:
- `<RAW_URL_BASE>`: For GitHub: `https://raw.githubusercontent.com/owner/repo`
- `<HOMEPAGE>`: The repository homepage URL (without `.git`)

**For non-GitHub repositories:**
Ask the user to provide the raw file URL pattern, as different hosts use different formats:
- GitHub: `https://raw.githubusercontent.com/owner/repo/<ref>/path/file`
- GitLab: `https://gitlab.com/owner/repo/-/raw/<ref>/path/file`

### 3. Determine tool path

Use the `--path` parameter if provided, otherwise default to `bin/`.

Store as `<TOOL_PATH>` (ensure it ends with `/` if it's a directory, or use as-is if it's a full file path).

### 4. Find the tag

**Determine tag pattern:**
- If `--tag` is `*` or contains `*`: Use as a pattern (e.g., `v*` matches `v1.0.0`)
- If `--tag` is a specific value without `*`: Use that exact tag
- If `--tag` is not provided: Use pattern `<tool-name>-v*`

**Search for matching tags:**

```bash
git ls-remote --tags <REPO_URL> | grep "<tag-pattern>" | sort -V | tail -1
```

**If multiple tags match a pattern**, list them and confirm with user using `AskUserQuestion`:
- Question: "Multiple tags found. Which version should be used?"
- Options: List up to 4 most recent matching tags

**If no tags match:**
Use `AskUserQuestion` to ask the user:
- Question: "No tags found matching pattern '<pattern>'. What would you like to do?"
- Options:
  - "Use a different tag pattern"
  - "Use a specific commit/branch"
  - "Cancel - I'll create a tag first"

If user provides a different pattern, retry the search. If user wants to use a commit/branch, ask for the ref name.

**Confirm tag with user** using `AskUserQuestion`:
- Question: "Found tag '<tag>'. Use this version?"
- Options:
  - "Yes, use <tag>"
  - "No, use a different version"

Extract the version number from the tag (e.g., `ascii-banner-v1.2.0` → `1.2.0`, `v1.2.0` → `1.2.0`).

### 5. Verify the tool exists at that tag

Construct the raw URL based on the repository host:

**For GitHub:**
```bash
curl -sI "<RAW_URL_BASE>/<TAG>/<TOOL_PATH><tool-name>" | head -1
```

**For GitLab:**
```bash
curl -sI "https://gitlab.com/owner/repo/-/raw/<TAG>/<TOOL_PATH><tool-name>" | head -1
```

Should return `HTTP/2 200` or `HTTP/1.1 200`.

**If the tool is NOT found (non-200 response):**
Use `AskUserQuestion` to ask the user:
- Question: "Tool not found at '<TOOL_PATH><tool-name>'. What would you like to do?"
- Options:
  - "Enter a different path"
  - "List files in repository to find it"
  - "Cancel"

If user provides a different path, update `<TOOL_PATH>` and retry verification.

### 6. Get the SHA256 checksum

Fetch the tool and compute checksum:

**For GitHub:**
```bash
curl -sL "<RAW_URL_BASE>/<TAG>/<TOOL_PATH><tool-name>" | shasum -a 256
```

**For GitLab:**
```bash
curl -sL "https://gitlab.com/owner/repo/-/raw/<TAG>/<TOOL_PATH><tool-name>" | shasum -a 256
```

### 7. Read the tool to extract description and usage

Fetch the tool source from the raw URL and extract:
- **Description**: From header comments (usually lines starting with `#`). Create a concise description (under 80 chars) for the formula's `desc` field.
- **Usage examples**: From comment block or `--help` output
- **Options/flags**: Document all command-line options

### 8. Check for dependencies

Look at the shebang line:
- `#!/usr/bin/env ruby` → `depends_on "ruby"`
- `#!/usr/bin/env python3` → `depends_on "python@3"`
- `#!/usr/bin/env node` → `depends_on "node"`
- `#!/bin/bash` or `#!/usr/bin/env bash` → no dependency needed

### 9. Create the formula

Create `Formula/<tool-name>.rb` with this structure:

```ruby
class ToolName < Formula
  desc "<description from step 7>"
  homepage "<HOMEPAGE>"
  version "<VERSION>"
  url "<RAW_FILE_URL>"  # Full URL to the raw file at the tag
  sha256 "<sha256 from step 6>"
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

**URL Construction:**
- For GitHub: `https://raw.githubusercontent.com/owner/repo/<TAG>/<TOOL_PATH><tool-name>`
- For GitLab: `https://gitlab.com/owner/repo/-/raw/<TAG>/<TOOL_PATH><tool-name>`

Note: The class name should be CamelCase (e.g., `ascii-banner` → `AsciiBanner`, `retry-command` → `RetryCommand`).

### 10. Create documentation

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

- [Source Repository](<HOMEPAGE>) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
```

Populate the template with actual usage information extracted from the tool's source code and `--help` output.

### 11. Update the main README

Edit `README.md` to add the new tool to the table (keep alphabetical order):

```markdown
| <tool-name> | [README](docs/README.<tool-name>.md) | `brew install zdennis/bin/<tool-name>` | <1-3 sentence description> |
```

### 12. Test the installation

```bash
brew uninstall <tool-name> 2>/dev/null || true
brew install zdennis/bin/<tool-name>
```

If installation fails due to sha256 mismatch or other errors, fix the formula and retry.

### 13. Verify the tool works

Run a basic command to verify the installed tool works:

```bash
<tool-name> --version
# or
<tool-name> --help
```

### 14. Update the zdennis-bin-all.rb meta-formula

Run the `update_all_formula` logic (see "Update All Formula Instructions" section) to ensure the new formula is included in `Formula/zdennis-bin-all.rb`.

### 15. Report success and offer to commit/push

Summarize what was created:
- Formula: `Formula/<tool-name>.rb`
- Documentation: `docs/README.<tool-name>.md`
- README.md updated with new table row
- `Formula/zdennis-bin-all.rb` updated to include new formula
- Installation verified working
- Source repository: `<HOMEPAGE>`
- Version: `<VERSION>` (from tag `<TAG>`)

Use `AskUserQuestion` to ask the user:
- Question: "Commit and push to release the formula?"
- Options:
  - "Yes, commit and push"
  - "Commit only (don't push)"
  - "No, I'll do it manually"

**If user chooses to commit (with or without push):**

Stage and commit the files with a detailed commit message:

```bash
git add Formula/<tool-name>.rb Formula/zdennis-bin-all.rb docs/README.<tool-name>.md README.md
git commit -m "$(cat <<'EOF'
Add <tool-name> formula v<VERSION>

<Brief 1-line description of what the tool does>

Source: <HOMEPAGE>
EOF
)"
```

**If user also chose to push:**

```bash
git push
```

Report completion with the commit hash and (if pushed) confirm it's been released.

---

## Update Instructions

When invoked with `update <tool-name>`, follow these steps:

### 1. Verify formula exists

```bash
ls Formula/<tool-name>.rb
```

If it doesn't exist, inform the user and suggest using `create` instead.

### 2. Read the current formula and extract defaults

Read `Formula/<tool-name>.rb` and parse to extract current values:

**From the `url` field**, extract:
- **Repository**: Parse the raw URL to get owner/repo
  - GitHub: `https://raw.githubusercontent.com/owner/repo/tag/path/file` → `owner/repo`
  - GitLab: `https://gitlab.com/owner/repo/-/raw/tag/path/file` → `owner/repo`
- **Current tag**: The ref portion of the URL (e.g., `tool-name-v1.2.0`)
- **Tool path**: Everything between the tag and the filename (e.g., `bin/`)
- **Tag pattern**: Infer from current tag by replacing version with `*`
  - `tool-name-v1.2.0` → `tool-name-v*`
  - `v1.2.0` → `v*`
  - `1.2.0` → `*` (bare version)

**From other fields:**
- `homepage` → `<HOMEPAGE>`
- `version` → `<CURRENT_VERSION>`

**Apply parameter overrides** (only if explicitly provided):
- `--repo` overrides the extracted repository
- `--path` overrides the extracted tool path
- `--tag` overrides the inferred tag pattern

Store final values as `<REPO_URL>`, `<RAW_URL_BASE>`, `<HOMEPAGE>`, `<TOOL_PATH>`, `<TAG_PATTERN>`.

### 3. Find the tag

**Determine tag pattern:**
- If `--tag` is provided with `*`: Use as a pattern
- If `--tag` is a specific value: Use that exact tag
- If `--tag` is not provided: Use `<TAG_PATTERN>` extracted from the formula in step 2

**Search for matching tags:**

```bash
git ls-remote --tags <REPO_URL> | grep "<tag-pattern>" | sort -V | tail -1
```

**If multiple tags match**, list them and confirm with user using `AskUserQuestion`:
- Question: "Multiple tags found. Which version should be used?"
- Options: List up to 4 most recent matching tags

**If no tags match:**
Use `AskUserQuestion` to ask the user:
- Question: "No tags found matching pattern '<pattern>'. What would you like to do?"
- Options:
  - "Use a different tag pattern"
  - "Use a specific commit/branch"
  - "Cancel"

Extract the version number from the tag.

### 4. Check if update is needed

Compare the latest tag version with the current formula version.

**If versions match:** Inform the user they're already on the latest version. Ask if they want to force update anyway (useful if the tag was re-pushed with changes). Use the AskUserQuestion tool:

- "Already on latest version (v<VERSION>). Force update?"
- Options: "Yes, force update" / "No, skip"

If user chooses not to force update, stop here and report that no changes were made.

**Confirm tag with user** using `AskUserQuestion`:
- Question: "Update to tag '<tag>'?"
- Options:
  - "Yes, update to <tag>"
  - "No, use a different version"

If user chooses to force update, or if versions differ and user confirms, continue to the next step.

### 5. Verify the tool exists at the tag

Construct the raw URL based on the repository host and verify:

```bash
curl -sI "<RAW_URL_BASE>/<TAG>/<TOOL_PATH><tool-name>" | head -1
```

Should return `HTTP/2 200` or `HTTP/1.1 200`.

**If the tool is NOT found:**
Use `AskUserQuestion` to ask the user:
- Question: "Tool not found at '<TOOL_PATH><tool-name>'. What would you like to do?"
- Options:
  - "Enter a different path"
  - "Cancel"

### 6. Get the SHA256 checksum

```bash
curl -sL "<RAW_URL_BASE>/<TAG>/<TOOL_PATH><tool-name>" | shasum -a 256
```

### 7. Update the formula

Edit `Formula/<tool-name>.rb`:
- Update `version "<VERSION>"` (if changed)
- Update `url` with the new tag (if the URL format includes version)
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

### 11. Update the zdennis-bin-all.rb meta-formula

Run the `update_all_formula` logic (see "Update All Formula Instructions" section) to ensure `Formula/zdennis-bin-all.rb` is in sync. This typically won't change anything for updates, but ensures consistency.

### 12. Report success and offer to commit/push

Summarize what was updated:

**If version changed:**
- Formula updated: `<old_version>` → `<new_version>`
- SHA256 updated
- Documentation refreshed
- Installation verified working
- Source repository: `<HOMEPAGE>`

**If force update (same version):**
- SHA256 refreshed
- Documentation refreshed
- Installation verified working

Use `AskUserQuestion` to ask the user:
- Question: "Commit and push to release the update?"
- Options:
  - "Yes, commit and push"
  - "Commit only (don't push)"
  - "No, I'll do it manually"

**If user chooses to commit (with or without push):**

Stage and commit the files with a detailed commit message:

**For version updates:**
```bash
git add Formula/<tool-name>.rb Formula/zdennis-bin-all.rb docs/README.<tool-name>.md README.md
git commit -m "$(cat <<'EOF'
Update <tool-name> to v<VERSION>

<Brief summary of notable changes if known, otherwise: "Updated to latest release.">

Source: <HOMEPAGE>
EOF
)"
```

**For force updates (same version):**
```bash
git add Formula/<tool-name>.rb Formula/zdennis-bin-all.rb docs/README.<tool-name>.md README.md
git commit -m "$(cat <<'EOF'
Refresh <tool-name> formula v<VERSION>

Refreshed SHA256 and documentation.

Source: <HOMEPAGE>
EOF
)"
```

**If user also chose to push:**

```bash
git push
```

Report completion with the commit hash and (if pushed) confirm it's been released.

---

## Update README Instructions

When invoked with `update_readme [<tool-name>...]`, follow these steps:

### 1. Determine which tools to update

**If one or more tool names are provided:**
Store them as `<TOOL_LIST>` and proceed to step 2.

**If no tool names are provided:**
List available formulas:

```bash
ls Formula/*.rb | sed 's|Formula/||; s|\.rb$||' | sort
```

Use `AskUserQuestion` to ask the user:
- Question: "Which tools would you like to update READMEs for?"
- Options:
  - "All tools"
  - "Enter specific tool(s)"

If user chooses "All tools", set `<TOOL_LIST>` to all formula names found.
If user chooses to enter specific tools, prompt for the list and store as `<TOOL_LIST>`.

### 2. Process each tool

For each `<tool-name>` in `<TOOL_LIST>`:

#### 2a. Verify formula exists

```bash
ls Formula/<tool-name>.rb
```

If it doesn't exist, report an error for this tool and continue to the next one.

#### 2b. Read the formula and extract source URL

Read `Formula/<tool-name>.rb` and parse to extract:

**From the `url` field:**
- **Full raw URL**: The complete URL to the tool source
- **Repository host**: GitHub, GitLab, etc.
- **Tag/ref**: The version reference in the URL

**From other fields:**
- `homepage` → `<HOMEPAGE>`
- `version` → `<VERSION>`
- `desc` → `<DESCRIPTION>`

#### 2c. Fetch the tool source

Download the tool from the raw URL:

```bash
curl -sL "<RAW_URL>"
```

Extract from the source:
- **Usage examples**: From comment block or help text
- **Options/flags**: All command-line options with descriptions
- **Additional documentation**: Any inline docs or examples

#### 2d. Update the tool README

Read the existing `docs/README.<tool-name>.md` if it exists. Update or create the file following this template:

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

- [Source Repository](<HOMEPAGE>) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
```

Populate the template with current usage information extracted from the tool's source code.

#### 2e. Update main README if needed

Check if the tool's entry in `README.md` needs updating (description changes, etc.). If the description in the formula differs significantly from what's in the table, update the table entry.

### 3. Report results

Summarize what was updated:
- List of tools with updated READMEs
- Any tools that were skipped (formula not found)
- Any errors encountered

Use `AskUserQuestion` to ask the user:
- Question: "Commit the README updates?"
- Options:
  - "Yes, commit and push"
  - "Commit only (don't push)"
  - "No, I'll do it manually"

**If user chooses to commit (with or without push):**

Stage and commit the files:

```bash
git add docs/README.*.md README.md
git commit -m "$(cat <<'EOF'
Update README documentation

Refreshed documentation for: <list of tools>
EOF
)"
```

**If user also chose to push:**

```bash
git push
```

Report completion with the commit hash and (if pushed) confirm changes are live.

---

## Update All Formula Instructions

When invoked with `update_all_formula`, or automatically at the end of `create`/`update` commands, follow these steps:

### 1. Scan for all formulas

List all formula files in `Formula/`:

```bash
ls Formula/*.rb | sed 's|Formula/||; s|\.rb$||' | sort
```

Filter out `zdennis-bin-all` from the list (the meta-formula itself). Store as `<TOOL_LIST>`.

### 2. Read the current zdennis-bin-all.rb formula

Read `Formula/zdennis-bin-all.rb` and extract:
- Current list of `depends_on` entries
- Current `version`

### 3. Compare and determine if update needed

Compare `<TOOL_LIST>` from step 1 with the `depends_on` list from step 2.

**If they match:** No update needed. Report that `Formula/zdennis-bin-all.rb` is already up to date and stop here.

**If they differ:** Continue to step 4.

### 4. Update the bin/zdennis-bin-all script in zdennis/bin

The `zdennis-bin-all` script lives in the `zdennis/bin` repository at `~/.bin-zdennis/bin/zdennis-bin-all`. Update it to list all current tools with their versions:

```bash
#!/bin/bash
#
# zdennis-bin-all - List all zdennis/bin tools available via Homebrew
#
# Usage: zdennis-bin-all [--version]
#
# This is a meta-package that installs all zdennis/bin tools.
# Run this command to see what's included.

VERSION="<NEW_VERSION>"

if [[ "$1" == "--version" || "$1" == "-v" ]]; then
  echo "zdennis-bin-all $VERSION"
  exit 0
fi

echo "zdennis/bin tools v$VERSION (installed via 'brew install zdennis/bin/zdennis-bin-all'):"
echo ""
echo "  <tool-1> (<tool-1-version>)       - <description from formula>"
echo "  <tool-2> (<tool-2-version>)       - <description from formula>"
# ... all tools in alphabetical order with versions and descriptions ...
echo ""
echo "Note: Versions shown are what this formula installs. If you installed tools"
echo "separately, you may have different versions. Use '<tool> --version' to check."
echo ""
echo "For help on any tool, run: <tool-name> --help"
```

For each tool, extract:
- **Version**: From the formula's `version` field
- **Description**: From the formula's `desc` field

### 5. Determine new version

Parse the current version from the script's `VERSION="..."` line (e.g., `1.1.0`).

Use `AskUserQuestion` to confirm the new version:
- Question: "Tools changed. Current version is <CURRENT_VERSION>. What should the new version be?"
- Options:
  - "Patch (<CURRENT_MAJOR>.<CURRENT_MINOR>.<CURRENT_PATCH + 1>)" - e.g., `1.0.1`
  - "Minor (<CURRENT_MAJOR>.<CURRENT_MINOR + 1>.0)" - e.g., `1.1.0`
  - "Enter custom version"

Store the confirmed version as `<NEW_VERSION>`.

### 6. Commit, tag, and push in zdennis/bin

```bash
cd ~/.bin-zdennis
git add bin/zdennis-bin-all
git commit -m "Update zdennis-bin-all script to v<NEW_VERSION>"
git tag zdennis-bin-all-v<NEW_VERSION>
git push && git push --tags
```

### 7. Get the new SHA256

```bash
curl -sL "https://raw.githubusercontent.com/zdennis/bin/zdennis-bin-all-v<NEW_VERSION>/bin/zdennis-bin-all" | shasum -a 256
```

Store as `<NEW_SHA256>`.

### 8. Update Formula/zdennis-bin-all.rb

Update the formula with:
- New `version "<NEW_VERSION>"`
- New `sha256 "<NEW_SHA256>"`
- Updated `depends_on` list (all tools in alphabetical order)

```ruby
class ZdennisBinAll < Formula
  desc "Install all zdennis/bin tools"
  homepage "https://github.com/zdennis/bin"
  version "<NEW_VERSION>"
  url "https://raw.githubusercontent.com/zdennis/bin/zdennis-bin-all-v#{version}/bin/zdennis-bin-all"
  sha256 "<NEW_SHA256>"
  license "MIT"

  depends_on "zdennis/bin/<tool-1>"
  depends_on "zdennis/bin/<tool-2>"
  # ... all tools in alphabetical order ...

  def install
    bin.install "zdennis-bin-all"
  end

  test do
    assert_match "zdennis/bin tools", shell_output("#{bin}/zdennis-bin-all")
  end
end
```

### 9. Report changes

Report which tools were added or removed, and the version bump:
- Tools added: `<list>`
- Tools removed: `<list>`
- Version: `<OLD_VERSION>` → `<NEW_VERSION>`

If running as part of `create` or `update`:
- The `Formula/zdennis-bin-all.rb` changes will be included in the parent command's commit
- Report the changes so the user knows what was updated

If running standalone:
- The changes are ready to be committed in homebrew-bin
- Remind user to commit `Formula/zdennis-bin-all.rb` if not already done
