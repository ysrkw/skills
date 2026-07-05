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
judge.

Run the cases (results go to `tests/results/<runner>-<variant>/`, not
committed):

```sh
tests/run.sh opus without        # Claude baseline (also: sonnet, claude-opus-4-8, ...)
tests/run.sh opus with           # skill injected via --append-system-prompt
tests/run-codex.sh without       # Codex CLI baseline
tests/run-codex.sh with          # skill body injected as AGENTS.md in the workspace
tests/run.sh opus with 03-scope-discipline          # single case
RUN_TAG=r2 tests/run.sh opus with 08-outcome-first  # repeat run → results/...-r2
```

Grade a results directory (judge model defaults to claude-sonnet-5):

```sh
tests/grade.sh opus-with
tests/grade.sh codex-without claude-sonnet-5 05-no-promises  # re-grade one case
```

Each case under `tests/cases/` is a `prompt.txt` plus a `rubric.md` with
explicit PASS/FAIL conditions; cases that edit code run in a throwaway git
repo copied from `tests/fixtures/` and are judged on the resulting diff as
well as the final response. Verdicts are stored per case as `<case>.grade`
and assembled into `grades.txt`.

The judge is itself an LLM and wobbles on borderline cases (padding in
prose answers, closing sentences that resemble offers). When two judge runs
disagree, read the response/diff yourself and overwrite the `<case>.grade`
file with a `PASS:`/`FAIL:` line marked `(manual adjudication)`, then
regenerate `grades.txt` by re-running grade.sh on an already-graded case or
rebuilding it from the `.grade` files.
