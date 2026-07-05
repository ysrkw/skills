# skills

Personal collection of agent skills — model-facing instruction files that
adjust how coding agents (Claude Code, Codex CLI, ...) behave.

## Layout

```
skills/<name>/SKILL.md   # one skill per directory; YAML frontmatter + body
.claude/skills           # symlink to skills/ (Claude Code picks them up here)
.agents/skills           # symlink to skills/ (Agent Skills convention: Codex, Copilot, ...)
tests/                   # behavioral test harness (real-model A/B runs)
install.sh               # install into ~/.claude/skills and/or ~/.agents/skills
```

The SKILL.md body is plain markdown instructions with no Claude-specific
syntax, so it can be reused with any agent that accepts a system prompt or
instructions file.

## Install

```sh
git clone git@github.com:ysrkw/skills.git
cd skills
./install.sh claude   # symlink into ~/.claude/skills (all Claude Code projects)
./install.sh agents   # symlink into ~/.agents/skills (Codex etc.; "codex" is an alias)
./install.sh all
```

In Claude Code, invoke a skill as `/<name>` (e.g. `/fable-mode`) at the start
of a session. Codex reads Agent Skills natively — from `~/.agents/skills`
(user-level) and from `.agents/skills` inside a repo — and activates them
implicitly by description or explicitly via `$<name>`. For agents without
Agent Skills support, paste the SKILL.md body into the system prompt or
AGENTS.md.

## Skills

- **fable-mode** — makes Opus/Sonnet (or any capable model) adopt Fable's
  working style: outcome-first readable communication, strict scope
  discipline, faithful status reporting, minimal-noise code.

## Testing

`tests/` runs each skill's behavioral test cases against a real model twice —
with and without the skill injected — and grades the transcripts with an LLM
judge:

```sh
tests/run.sh opus without      # baseline
tests/run.sh opus with         # skill injected via --append-system-prompt
tests/grade.sh opus-without
tests/grade.sh opus-with
```

Each case under `tests/cases/` is a `prompt.txt` plus a `rubric.md` with
explicit PASS/FAIL conditions; cases that edit code run in a throwaway copy of
`tests/fixtures/` and are judged on the resulting git diff as well as the
final response. Results go to `tests/results/` (not committed).
