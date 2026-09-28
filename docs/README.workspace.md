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
| `agent` | Drive a workspace agent: `agent run "prompt"` (umbrella) |
| `agentd` | Run the long-lived workspace agent daemon for a project |
| `agent-run` | Send a message to a running agent (command, inject, restart a pane) |
| `alfred` | Manage the Alfred workflow for workspace focus |
| `ask` | Record a question an unattended agent hit, with its default |
| `capture` | Print a tmux pane's scrollback buffer to stdout |
| `cleanup` | Detect and remove zombie sessions from state |
| `config` | Show project or global configuration |
| `current` | Print the workspace project name for the current directory |
| `dev` | Start, stop, or inspect this repo's dev environment (`devenv` lock) |
| `deactivate` | Deactivate Claude in a project's tmux pane (sends Ctrl-C) |
| `dir <project>` | Print the root directory of a workspace project |
| `doctor` | Check that all required dependencies are installed |
| `event-log` | Show or compact the event log (state changes and agent activity) |
| `finish` | Verify a worktree is clean and pushed, then remove it (optionally opens a PR) |
| `focus <project>` | Bring a project's iTerm window to the front (not for headless projects) |
| `handoff` | Check context usage and hand off to a fresh conversation |
| `init` | Install tmuxinator templates and create config directory |
| `kill <key/url/branch>` | Kill a worktree project and remove its worktree (auto-detects from cwd) |
| `launch <projects...>` | Launch tmuxinator projects in iTerm windows, or headless in plain tmux |
| `layout` | Save/restore tmux pane layouts (auto-saved before resize) |
| `list` | List currently active (launched) projects (`--all` for all available) |
| `lock` | Acquire, release, inspect, or clear a shared repo-wide lock |
| `lookup <query>` | Find a workspace project by worktree path, branch, or project name |
| `parent` | Print the parent workspace of the current (or given) workspace |
| `pipeline` | Inspect and drive a project's agent pipeline |
| `prune` | Remove worktree projects whose PR is closed or merged |
| `reactivate` | Reactivate Claude in a project's tmux pane |
| `relaunch` | Stop and relaunch all active workspace projects |
| `repair` | Rebuild state from live iTerm windows |
| `resize` | Resize tmux panes for a running project |
| `run` | Send a shell command to a pane in a running project's tmux session |
| `run-and-report` | Run a command as a subprocess, capture stdout/stderr/exit status |
| `report-run-status` | Internal: write run result for `--wait` (called by shell wrapper) |
| `session-event` | Forward one agent hook event to its daemon (installed by `init`) |
| `sessions` | Show coding-agent sessions and sub-agents in a workspace |
| `set-command <project> <cmd> --pane N` | Set the shell command for a pane in a project config |
| `start <key/url/branch>` | Create a worktree and launch it (from JIRA key, PR URL, or branch) |
| `status` | Show detailed state of tracked launcher sessions |
| `statusline` | Render Claude Code's status line (install as its statusLine command) |
| `stop` | Stop active workspace projects and their tmux sessions |
| `tile` | Tile all windows for a project across the screen |
| `wait-until-content` | Block until a pane shows content, then exec a command |
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
