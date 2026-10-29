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

# Stop every active project
workspace stop --all
```

## Commands

| Command | Description |
|---------|-------------|
| `add <path>` | Add a tmuxinator config for a project directory |
| `agent` | Drive a workspace agent: `agent run "prompt"`, `agent status request\|post` |
| `agent-run` | Send a message to a running agent, or type into a pane (command, inject, restart, send); `send --when-idle` queues it until the agent's turn ends, `--clear-first` clears the conversation before typing, and `queue list`/`queue cancel` manage queued prompts |
| `agentd` | Run the long-lived workspace agent daemon for a project, or replace it (`agentd restart`) |
| `alfred` | Manage the Alfred workflow for workspace focus |
| `ask` | Record a question an unattended agent hit, with its default; list/answer them (this workspace's, or `ask [WS]`) |
| `binding` | Bind a pane to a workflow run, PR review or play, so it survives `/clear` and compaction |
| `capabilities` | Print what this CLI supports, as feature revisions (for scripts and the UI) |
| `capture` | Print a tmux pane's scrollback buffer to stdout |
| `cleanup` | Detect and remove zombie sessions from state (`--dry-run` reports only) |
| `config` | Show, validate, set, get, unset, edit or describe project or global configuration; `get` notes when another config layer holds the value |
| `current` | Print the workspace project name for the current directory |
| `daemon` | List, show, restart (one or all) or read the log of agent daemons |
| `deactivate` | Deactivate Claude in a project's tmux pane (sends Ctrl-C) |
| `dev` | Start, stop, or inspect the repo's single dev environment (`devenv` lock) |
| `dir [project]` | Print the root directory of a workspace project (default: the current one) |
| `doctor` | Check that all required dependencies are installed |
| `event-log` | Show or compact the append-only event log of state changes and agent activity |
| `events` | Read or follow the event log and every agent's hook events as one stream |
| `finish` | Verify a worktree is clean and pushed, then remove it (default: the current one; optionally opens a PR); reports pushed unless the branch is on the default branch |
| `focus <project>` | Bring a project's iTerm window to the front (`--center` centers it on its screen, `--cycle` steps through windows) |
| `goal` | Say where a workspace's goal is (stage, workflow step, agent turn, tool call) and what it waits for (`show`), or one line per goal (`list`) |
| `handoff` | Check context usage and hand off to a fresh conversation |
| `hooks` | Remove workspace's hooks from a coding agent's settings (`hooks uninstall`) |
| `inbox` | Keep a durable list of things that need a person: `add`, `list`, `show`, `edit`, `done`, `dismiss`, `reopen` |
| `init` | Install tmuxinator templates and create workspace config directory |
| `instructions` | Print the instructions built from library packs (`binding`, `orchestrator`, `commits`, `review`, `notes`, `handoff`, `dev`, `implementation-plan`, `research`, `spine`, `promote`) |
| `journey` | Another name for `spine` |
| `kill [key/url/branch]` | Kill a worktree project, remove its worktree and the branch `start` made (default: the current one; `--delete-remote` also deletes the merged remote branch) |
| `launch <projects...>` | Launch tmuxinator projects in iTerm2 windows, or headless in plain tmux; updates a stopped workspace's agent pane to the configured command first (with a backup) |
| `layout` | Save/restore tmux pane layouts (auto-saved before resize) |
| `library` (`lib`) | Store named plays, prompts, recipes, agents and skills, globally or per project, beside the built-in packs |
| `list` | List active projects (`--all` for all available) |
| `list-projects` | Alias for `list --all` |
| `lock` | Acquire, release, inspect, or clear a shared repo-wide lock |
| `lookup <query>` | Find a workspace project by worktree path, branch, or project name |
| `notes` | Print where a workspace's notes are kept (`notes dir`) |
| `parent` | Print the parent workspace of the current (or given) workspace |
| `pipeline` | Deprecated (use `workflow`): inspect and drive a project's agent pipeline |
| `plan` | Show and run a workspace's plan (`IMPLEMENTATION_PLAN.md`): `status`, `path`, `show`, `init`, `start`, `pause`, `delete` |
| `pr` | Open a pull request for a workspace's branch without finishing it (`pr create`) |
| `projects` | Group workspaces by repository: main checkout plus worktrees (`list`, `list --git`, `show`, `members`, `stop`, `kill`) |
| `promote [branch]` | Move a main checkout's uncommitted changes and branch commits into a new worktree workspace, leaving the main checkout clean |
| `prune` | Remove worktree projects whose PR is closed or merged |
| `push` | Push a workspace's branch to origin, forcing with a lease only after a rebase; errors say whether a retry can help |
| `reactivate` | Reactivate Claude in a project's tmux pane |
| `rebase` | Rebase a workspace's branch onto the default branch (`--onto local\|update\|remote\|upstream`) |
| `relaunch` | Stop and relaunch all active workspace projects |
| `remove` | Forget a stopped project: delete its generated config and state (default: the current one; your files stay) |
| `repair` | Rebuild state from live iTerm windows |
| `report-run-status` | Internal: write run result for `--wait` (called by shell wrapper) |
| `resize` | Resize tmux panes for a running project |
| `restore` | Bring back agent panes after a reboot: recreate them and resume their sessions (default: the current one; `--all`; `--dry-run` shows the plan) |
| `review` | Show a workspace's finished work for review, or list workspaces that are ready |
| `run` | Send a shell command to a pane in a project's tmux session |
| `run-and-report` | Run a command as a subprocess, capture stdout/stderr/exit status |
| `session-event` | Forward one coding-agent hook event to a workspace's agent daemon |
| `sessions` | Show coding-agent sessions and sub-agents running in a project's panes |
| `set-command <project> <cmd> --pane N` | Set the shell command for a pane in a project config |
| `snapshot` | Print everything a UI polls (projects, panes, git, questions, locks, dev) as one JSON document |
| `spine` | Read and set a workspace's stages (stage files in its notes directory): show, init, set status, tick a checklist, record a check verdict, start an agent on a stage |
| `start <key/url/branch>` | Create a git worktree and launch it (from JIRA key, PR/issue URL or `#n`, or branch) |
| `status` | Show detailed state of tracked launcher sessions |
| `statusline` | Render Claude Code's status line (install as its statusLine command) |
| `step` | For the agent on a workflow step: report on it (`done`) or see what it is (`status`) |
| `stop` | Stop a workspace and its tmux session (default: the current one; `--all` for every active one) |
| `ticket` | Look up a ticket the way `start` reads it (`show`), or list yours (`list`) |
| `tile` | Tile windows across the screen (`--all` for all projects) |
| `tmux` | Show a workspace's tmuxinator file as windows and panes |
| `ui` | Open a `workspace-ui://` link: a task, a review, notes or the inbox |
| `version` | Print the workspace version |
| `wait-until-content` | Block until a pane shows content, then exec a command |
| `whereis` | Print the workspace installation directory |
| `workflow` | Run a workflow (ordered steps, e.g. `rpiv`) in a workspace's agent pane: `show`, `run`, `start` (make a workspace from a ticket or a prompt and run in it), `status`, `resume`, `cancel`, `approve`, `reject`; manage your own definitions (`validate`, `add`, `update`, `remove`); read a run's history (`events`, `files`) |

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

# Stop the workspace you're in, or every active one
workspace stop
workspace stop --all

# Add current directory as a project
workspace add .

# Kill a worktree project and delete the branch start made
workspace kill myproject.worktree-PROJ-123
workspace kill --delete-remote    # also delete its merged remote branch

# See where a goal is and what it waits for
workspace goal show
workspace goal list

# Rebase onto the default branch and push
workspace rebase --onto remote
workspace push

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
