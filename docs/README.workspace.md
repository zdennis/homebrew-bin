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
| `agent` | Umbrella for driving a workspace agent: `agent run "prompt"` |
| `agentd` | Run the long-lived workspace agent daemon for a project, or replace it (`agentd restart`) |
| `agent-run` | Send a message to a running agent, or type into a pane (command, inject, restart, send) |
| `alfred` | Manage the Alfred workflow for workspace focus |
| `ask` | Record a question an unattended agent hit, with its default; list/answer them |
| `binding` | Bind a pane to a workflow run, PR review or play, so it survives `/clear` and compaction |
| `capabilities` | Print what this CLI supports, as feature revisions (for scripts and the UI) |
| `capture` | Print a tmux pane's scrollback buffer to stdout |
| `cleanup` | Detect and remove zombie sessions from state |
| `config` | Show, validate, set, get, or unset project or global configuration |
| `current` | Print the workspace project name for the current directory |
| `daemon` | Show, restart or read the log of a workspace's agent daemon |
| `dev` | Start, stop, or inspect the repo's single dev environment (`devenv` lock) |
| `deactivate` | Deactivate Claude in a project's tmux pane (sends Ctrl-C) |
| `dir <project>` | Print the root directory of a workspace project |
| `doctor` | Check that all required dependencies are installed |
| `event-log` | Show or compact the append-only event log of state changes and agent activity |
| `finish` | Verify a worktree is clean and pushed, then remove it (optionally opens a PR) |
| `focus <project>` | Bring a project's iTerm window to the front |
| `handoff` | Check context usage and hand off to a fresh conversation |
| `init` | Install tmuxinator templates and create workspace config directory |
| `instructions` | Print the instructions built from library packs (`binding`, `orchestrator`, `commits`, `review`) |
| `kill <key/url/branch>` | Kill a worktree project and remove its worktree |
| `launch <projects...>` | Launch tmuxinator projects in iTerm2 windows, or headless in plain tmux |
| `layout` | Save/restore tmux pane layouts (auto-saved before resize) |
| `library` (`lib`) | Store named plays, prompts, agents and skills, globally or per project, beside the built-in packs |
| `list` | List active projects (`--all` for all available) |
| `list-projects` | Alias for `list --all` |
| `lock` | Acquire, release, inspect, or clear a shared repo-wide lock |
| `lookup <query>` | Find a workspace project by worktree path, branch, or project name |
| `parent` | Print the parent workspace of the current (or given) workspace |
| `pipeline` | Deprecated (use `workflow`): inspect and drive a project's agent pipeline |
| `projects` | Group workspaces by repository: main checkout plus worktrees (`list`, `list --git`, `show`, `members`, `stop`, `kill`) |
| `prune` | Remove worktree projects whose PR is closed or merged |
| `reactivate` | Reactivate Claude in a project's tmux pane |
| `relaunch` | Stop and relaunch all active workspace projects |
| `repair` | Rebuild state from live iTerm windows |
| `restore` | Bring back agent panes after a reboot: recreate them and resume their sessions (`claude --resume`; `--dry-run` shows the plan) |
| `resize` | Resize tmux panes for a running project |
| `review` | Show a workspace's finished work for review, or list workspaces that are ready |
| `run` | Send a shell command to a pane in a project's tmux session |
| `run-and-report` | Run a command as a subprocess, capture stdout/stderr/exit status |
| `report-run-status` | Internal: write run result for `--wait` (called by shell wrapper) |
| `session-event` | Forward one coding-agent hook event to a workspace's agent daemon |
| `sessions` | Show coding-agent sessions and sub-agents running in a project's panes |
| `set-command <project> <cmd> --pane N` | Set the shell command for a pane in a project config |
| `snapshot` | Print everything a UI polls (projects, panes, git, questions, locks, dev) as one JSON document |
| `start <key/url/branch>` | Create a git worktree and launch it (from JIRA key, PR/issue URL, or branch) |
| `status` | Show detailed state of tracked launcher sessions |
| `statusline` | Render Claude Code's status line (install as its statusLine command) |
| `step` | For the agent on a workflow step: report on it (`done`) or see what it is (`status`) |
| `stop` | Stop active workspace projects and their tmux sessions |
| `tile` | Tile windows across the screen (`--all` for all projects) |
| `tmux` | Show a workspace's tmuxinator file as windows and panes |
| `ui` | Open a `workspace-ui://` link: a task, a review or the inbox |
| `version` | Print the workspace version |
| `wait-until-content` | Block until a pane shows content, then exec a command |
| `whereis` | Print the workspace installation directory |
| `workflow` | Run a workflow (ordered steps, e.g. `rpiv`) in a workspace's agent pane: `show`, `run`, `status`, `resume`, `cancel`, `approve`, `reject` |

## Options

| Option | Description |
|--------|-------------|
| `--version, -v` | Print version and exit |
| `-h, --help` | Show help message |
| `--debug` | Print detailed debug output to stderr |
| `--no-input` | Never wait for an answer: a prompt fails with code `confirmation_required` (same as `WORKSPACE_NO_INPUT=1`) |

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
