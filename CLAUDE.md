# Repository guide

This repository is a personal collection of agent skills: model-facing
instruction files (`skills/<name>/SKILL.md`) that adjust how coding agents
behave.

This file guides coding agents (Claude Code, Codex, and other Agent
Skills-aware tools) working in this repository. It is also exposed as
`AGENTS.md` via a symlink, so keep it tool-agnostic.

The detail lives in `docs/`. Load only the doc relevant to your current task
instead of reading them all up front:

- [docs/structure.md](docs/structure.md) covers the skill layout: the
  directory tree, the shape of `SKILL.md`, and the `.claude/skills` /
  `.agents/skills` symlinks.
- [docs/install.md](docs/install.md) explains how to install the skills and
  invoke them from Claude Code or Codex.
- [docs/conventions.md](docs/conventions.md) is the authoring guide: body
  language, tool-agnostic syntax, and the `description` frontmatter contract.
- [docs/skills.md](docs/skills.md) catalogs the skills in this repo and what
  each one does.
- [docs/testing.md](docs/testing.md) describes the behavioral A/B test
  harness: `run.sh`, `run-codex.sh`, `grade.sh`, repeat runs, and keeping
  cases in sync when you edit a skill.

README.md intentionally duplicates the install steps from
[docs/install.md](docs/install.md) so newcomers see them without a click;
this is not drift to clean up. When changing the install flow, update both.
