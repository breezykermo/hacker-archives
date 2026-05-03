# Agent Instructions

This project uses **bd** (beads) for issue tracking. Run `bd onboard` to get started.

## Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --status in_progress  # Claim work
bd close <id>         # Complete work
bd sync               # Sync with git
```

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `jj git push` succeeds.

This repo uses **jj exclusively** — NEVER use raw `git` commands.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   jj git pull --rebase
   jj git push
   jj status  # MUST show clean working copy
   ```
5. **Clean up** - Abandon abandoned commits, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- This repo uses **jj exclusively** — NEVER use raw `git` commands (`git push`, `git pull`, `git add`, `git commit`, etc.)
- Work is NOT complete until `jj git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

# Workflows
## Issue Tracking (beads/bd — NEVER use markdown TODOs)

```bash
bd ready --json                              # find unblocked work
bd list --status=open
bd show <id>
bd create "Title" -t bug|feature|task -p 0-4 --json
bd update <id> --status in_progress --json
bd close <id1> <id2> --reason "Done" --json
bd dep add <issue> <depends-on>
```

**Priorities:** 0=critical, 1=high, 2=medium, 3=low, 4=backlog

**Local-only:** `.beads/` is gitignored, never commit it, never run `bd sync`.

---

## The bd/jj Workflow (ALWAYS use for bd tasks)

**Session prerequisite** — verify jj identity:
```bash
jj config list --user
# If missing:
jj config set --user user.name "Lachlan Kermode"
jj config set --user user.email "lachie@ohrg.org"
```

**Per-task sequence:**
1. `bd update <id> --status in_progress`
2. `jj log` — if empty unnamed commit below working commit, name it: `jj describe -m "..."`
3. `jj new` — fresh working commit
4. Do the work, run tests
5. `jj squash` then `jj describe -r @- -m "Present tense description"`
6. `jj log` — verify history shows correct author on each commit (not empty/unknown)
7. `bd close <id> --reason "Done"`

---

## bd/jj Churn (only when user says "bd/jj churn")

**Before first loop iteration** — verify jj identity (commits without author are broken):
```bash
jj config list --user
# Must show user.name and user.email. If missing:
jj config set --user user.name "Lachlan Kermode"
jj config set --user user.email "lachie@ohrg.org"
```

Loop until no open issues:
1. `bd ready --json` — pick highest priority (bugs/tasks/features, not epics/chores)
2. Implement with bd/jj workflow
3. `/clear` — clear context
4. Repeat

When done:
```bash
cargo fmt
cargo clippy --fix --all-targets --all-features --allow-dirty -- -D warnings
# jj squash if changes made
```

Report: list all closed issues.

---

## Plan Mode (activated by "plan mode", "let's plan", "design this", or any prompt ending with "BEADS")

**Rules:** No code, no file edits (except `.beads/`). Output is beads issues only.

**Workflow:**
1. Understand goal, ask clarifying questions
2. Decompose into discrete bd issues with type, priority, acceptance criteria
3. Present proposal to user, ask if they want to create the issues
4. If yes: run `bd create` commands (parallel where possible), set up deps with `bd dep add`
   - Each issue's `--description` must be procedural and unambiguous — written as if for an agent with no prior context. Include: background, relevant file paths and line numbers, exact steps to implement, and the expected outcome. The implementer must not need to investigate or infer anything.
5. List created IDs and stop — do NOT implement, do NOT ask if user wants to implement

**Exits** when user says "bd/jj churn", "start implementing", or "go".
