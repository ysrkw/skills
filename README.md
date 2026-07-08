# skills

A personal collection of agent skills: model-facing instruction files that
adjust how coding agents (Claude Code, Codex CLI, and others) behave.

## Install

```sh
git clone git@github.com:ysrkw/skills.git
cd skills
./install.sh claude   # symlink into ~/.claude/skills (all Claude Code projects)
./install.sh agents   # symlink into ~/.agents/skills (Codex etc.; "codex" is an alias)
./install.sh all
```

In Claude Code, invoke a skill as `/<name>` (for example `/fable-mode`) at the
start of a session. Codex reads Agent Skills natively and activates them by
description, or explicitly via `$<name>`. Full details, including what to do
with agents that lack Agent Skills support, are in
[docs/install.md](docs/install.md).

## Docs

- [docs/structure.md](docs/structure.md): repo layout and symlinks
- [docs/install.md](docs/install.md): installing and invoking skills
- [docs/conventions.md](docs/conventions.md): how to author a skill
- [docs/skills.md](docs/skills.md): the catalog of skills in this repo
- [docs/testing.md](docs/testing.md): the behavioral A/B test harness
