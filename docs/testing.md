# Testing skills

Behavioral A/B tests against real models live in `tests/`. Each skill's cases
run against a real model twice, once with the skill injected and once without,
and an LLM judge grades the transcripts.

## Runners

- `tests/run.sh <model> <with|without> [case ...]` runs each case via
  `claude -p`; the `with` variant injects the skill through
  `--append-system-prompt`. Fixture-based cases execute in a throwaway git
  repo copied from `tests/fixtures/`, and the resulting diff is captured.
- `tests/run-codex.sh <with|without> [case ...]` runs the same cases via the
  Codex CLI; the `with` variant injects the skill body as AGENTS.md in the
  workspace.

Results go to `tests/results/<runner>-<variant>/` (gitignored, not committed).

```sh
tests/run.sh opus without        # Claude baseline (also: sonnet, claude-opus-4-8, ...)
tests/run.sh opus with           # skill injected via --append-system-prompt
tests/run-codex.sh without       # Codex CLI baseline
tests/run-codex.sh with          # skill body injected as AGENTS.md in the workspace
tests/run.sh opus with 03-scope-discipline          # single case
RUN_TAG=r2 tests/run.sh opus with 08-outcome-first  # repeat run → results/...-r2
```

## Grading

`tests/grade.sh <results-subdir> [judge-model] [case ...]` grades each
response and diff with an LLM judge against the case's `rubric.md`, which
lists explicit PASS/FAIL conditions. The judge model defaults to
`claude-sonnet-5`.

```sh
tests/grade.sh opus-with
tests/grade.sh codex-without claude-sonnet-5 05-no-promises  # re-grade one case
```

Each case under `tests/cases/` is a `prompt.txt` plus a `rubric.md`. Cases
that edit code run in a throwaway git repo copied from `tests/fixtures/` and
are judged on the resulting diff as well as the final response. Verdicts are
stored per case as `<case>.grade` and assembled into `grades.txt`. Compare
`grades.txt` between the `-with` and `-without` runs to measure the skill's
effect.

## Judge adjudication

The judge is itself an LLM and wobbles on borderline cases, such as padding
in prose answers or closing sentences that resemble offers. When two judge
runs disagree, read the response and diff yourself, overwrite the
`<case>.grade` file with a `PASS:`/`FAIL:` line marked
`(manual adjudication)`, then regenerate `grades.txt` by re-running grade.sh
on an already-graded case or rebuilding it from the `.grade` files.

## Keeping cases in sync

When editing a skill, keep the test cases in sync: each behavioral rule the
skill adds should have a case whose rubric can objectively detect it.
