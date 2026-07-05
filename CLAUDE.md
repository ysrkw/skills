# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A collection of agent skills. Each skill lives in `skills/<name>/SKILL.md`
with YAML frontmatter (`name`, `description`). `.claude/skills` is a symlink
to `skills/`, so every skill here is directly usable in this repo; other
machines install via `./install.sh [claude|codex|all]`.

## Conventions

- Skill bodies are written in English and must stay free of Claude-specific
  syntax — they are reused verbatim as Codex custom prompts and generic
  system-prompt text (see install.sh, which strips only the frontmatter).
- The frontmatter `description` must say both what the skill does and when to
  invoke it — it is the trigger text the model matches against.

## Testing skills

Behavioral A/B tests against real models live in `tests/`:

- `tests/run.sh <model> <with|without> [case ...]` — runs each case via
  `claude -p`; the `with` variant injects the skill through
  `--append-system-prompt`. Fixture-based cases execute in a throwaway git
  repo copied from `tests/fixtures/`, and the resulting diff is captured.
- `tests/grade.sh <results-subdir>` — LLM judge grades each response+diff
  against the case's `rubric.md` (explicit PASS/FAIL conditions).
- Run a single case: `tests/run.sh opus with 03-scope-discipline`.
- `tests/results/` is gitignored; compare `grades.txt` between the
  `-with` and `-without` runs to measure the skill's effect.

When editing a skill, keep the test cases in sync: each behavioral rule the
skill adds should have a case whose rubric can objectively detect it.
