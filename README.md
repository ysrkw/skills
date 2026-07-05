# skills

Personal collection of agent skills — model-facing instruction files that
adjust how coding agents (Claude Code, Codex CLI, ...) behave.

## Layout

```
skills/<name>/SKILL.md   # one skill per directory; YAML frontmatter + body
.claude/skills           # symlink to skills/ so this repo uses them directly
tests/                   # behavioral test harness (real-model A/B runs)
install.sh               # install into ~/.claude/skills or ~/.codex/prompts
```

The SKILL.md body is plain markdown instructions with no Claude-specific
syntax, so it can be reused with any agent that accepts a system prompt or
instructions file.

## Install

```sh
git clone git@github.com:ysrkw/skills.git
cd skills
./install.sh claude   # symlink into ~/.claude/skills (all projects)
./install.sh codex    # copy bodies into ~/.codex/prompts as custom prompts
./install.sh all
```

In Claude Code, invoke a skill as `/<name>` (e.g. `/fable-mode`) at the start
of a session. In Codex CLI, use the custom prompt of the same name. For other
agents, paste the SKILL.md body into the system prompt or AGENTS.md.

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
