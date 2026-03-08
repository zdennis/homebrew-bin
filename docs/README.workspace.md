# workspace

Manage tmuxinator-based development workspaces in iTerm2. Launch, focus, kill, and relaunch projects with automatic window positioning across multiple displays.

## Installation

```bash
brew install zdennis/bin/workspace
```

After installing, run setup:

```bash
workspace init      # install tmuxinator templates
workspace doctor    # verify all dependencies
```

## Quick Start

```bash
# Launch projects in arranged iTerm windows
workspace launch my-notes work-notes billing

# Start a worktree-based workflow from a JIRA key or PR URL
workspace start PROJ-123
workspace start https://github.com/owner/repo/pull/471

# Focus a project's window
workspace focus my-notes

# Kill all active projects
workspace kill
```

## Commands

| Command | Description |
|---------|-------------|
| `add <path>` | Add a tmuxinator config for a project directory |
| `alfred` | Manage the Alfred workflow for workspace focus |
| `config` | Show project or global configuration |
| `current` | Print the workspace project name for the current directory |
| `doctor` | Check that all required dependencies are installed |
| `focus <project>` | Bring a project's window to the front and shake it |
| `init` | Install tmuxinator templates and create config directory |
| `kill [projects...]` | Kill workspace projects and their tmux sessions |
| `launch <projects...>` | Launch tmuxinator projects in iTerm windows |
| `layout` | Save/restore tmux pane layouts (auto-saved before resize) |
| `list` | List currently active (launched) projects (`--all` for all available) |
| `relaunch` | Kill and relaunch all active workspace projects |
| `resize` | Resize tmux panes for a running project |
| `start <key/url/branch>` | Create a git worktree and launch it as a workspace project |
| `status` | Show detailed state of tracked launcher sessions |
| `stop` | Kill a worktree project and remove its worktree (auto-detects from cwd) |
| `tile` | Tile all windows for a project across the screen |
| `whereis` | Print the workspace installation directory |

## Options

| Option | Description |
|--------|-------------|
| `--version, -v` | Print version and exit |
| `-h, --help` | Show help message |
| `--debug` | Print detailed debug output to stderr |

### launch options

| Option | Description |
|--------|-------------|
| `--reattach` | Reattach to existing tmux sessions, preserving state |
| `--prompt PROMPT` | Send an initial prompt to Claude in each project |

### init options

| Option | Description |
|--------|-------------|
| `--dry-run` | Show what would be done without making changes |
| `-f, --force` | Overwrite existing templates even if they differ |

## Examples

```bash
# Launch multiple projects with window arrangement
workspace launch my-notes work-notes billing

# Launch with a Claude prompt
workspace launch my-project --prompt "Review the latest changes"

# Start from various sources
workspace start PROJ-123                                    # JIRA issue key
workspace start https://mycompany.atlassian.net/.../123     # JIRA URL
workspace start https://github.com/owner/repo/pull/471      # GitHub PR URL
workspace start user/PROJ-123                                # Branch name

# Stop a worktree project (auto-detects from cwd)
workspace stop

# Add current directory as a project
workspace add .

# Kill a specific project
workspace kill my-notes

# Tile windows for a project
workspace tile my-project

# Resize tmux panes
workspace resize my-project

# Check active projects
workspace list
workspace list --all
workspace status

# Show current project
workspace current
```

## See Also

- [Source Repository](https://github.com/zdennis/workspace) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
