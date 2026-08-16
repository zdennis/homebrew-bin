# work-coordinator

Route messages to AI agents running in tmux panes.

## Installation

```bash
brew install zdennis/bin/work-coordinator
```

## Overview

When you run AI coding agents in tmux panes, each one eventually stops and waits on you. work-coordinator removes the overhead of finding the right pane and typing into it. Work items are registered with an external reference (a Jira ticket, an issue number), and any message prefixed with that reference is routed to the pane where the agent is waiting.

Messages arrive through two channels. **Local socket mode** listens on a Unix domain socket, so `work-coordinator send 'GE-123 go ahead'` from any terminal lands in the right pane. **Messages.app mode** polls `~/Library/Messages/chat.db` on macOS, so an agent can text you a question and you can answer from your iPhone.

State lives in SQLite. A work item tracks a UUID, title, kind, external reference, repository, and tmux target.

## Quick Start

```bash
# 1. Create a tmux session for the agent
tmux new-session -d -s my-project -n claude

# 2. Register a work item
work-coordinator register \
  --title "Fix login timeout" \
  --kind  bug \
  --ref   GE-123 \
  --repo  my-app \
  --tmux  my-project:claude.0

# 3. Start the coordinator daemon
work-coordinator run --mode local

# 4. Route a message from another terminal
work-coordinator send "GE-123 yes, update the fixture and rerun the suite"

# Check current work items
work-coordinator status
```

## Commands

| Command | Description |
|---------|-------------|
| `init` | Create the default config file (`~/.config/work-coordinator/config.yml`) |
| `alias` | List, add, or remove workspace project aliases |
| `config` | Read or write a configuration property |
| `project` | Manage projects (add, list, set-default) |
| `register` | Register a new work item |
| `start <uuid>` | Transition a work item to active state |
| `status` | List all work items with their current state and phase |
| `send "REF body"` | Send a message to the running coordinator via socket |
| `run` | Start the coordinator daemon (local socket or Messages mode) |
| `notify <uuid> "body"` | Send a human notification for a work item |
| `report` | Send a status report to the running coordinator's status socket |

## Options

| Option | Description |
|--------|-------------|
| `-v, --version` | Print version |
| `-h, --help` | Show help message |

## Run Modes

| Mode | Behavior |
|------|----------|
| `all` | Every known mode; equivalent to `local,messages` (default) |
| `local` | Opens a Unix socket at `WC_SOCKET` and listens for `work-coordinator send` |
| `messages` | Polls `~/Library/Messages/chat.db` for inbound iMessages |

```bash
# Run only local socket mode
work-coordinator run --mode local

# Run only Messages.app mode
work-coordinator run --mode messages
```

## Examples

```bash
# Register with a GitHub issue reference
work-coordinator register --title "Add OAuth support" --kind feature --ref "#42" --repo my-app --tmux work:1.0

# Capture the UUID for subsequent commands
ID=$(work-coordinator register --title "Refactor auth" --kind chore | awk '/^id:/{print $2}')
work-coordinator start $ID

# Send a message using an external reference
work-coordinator send "GE-123 please add tests for the new handler"

# Check status of all work items
work-coordinator status
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `WC_DATABASE` | `db/work_coordinator.sqlite3` | Path to the SQLite database file |
| `WC_SOCKET` | `/tmp/work-coordinator.sock` | Path to the Unix socket |
| `WC_SQL_LOG` | (unset) | Set to any value to enable SQL query logging |

## See Also

- [Source Repository](https://github.com/zdennis/work-coordinator) - Original source code
- [homebrew-bin](../README.md) - Full list of available tools
