#!/usr/bin/env bash
# Run behavioral test cases against a real model, with or without the
# fable-mode skill injected.
#
# Usage: ./run.sh <model> <with|without> [case ...]
#   model:   claude model alias or id (e.g. opus, sonnet, claude-opus-4-8)
#   variant: "with" injects skills/fable-mode/SKILL.md via --append-system-prompt
#   case:    case directory names under cases/; default = all
#
# Results land in results/<model>-<variant>/<case>.response.md and .diff
set -uo pipefail
cd "$(dirname "$0")"

MODEL="${1:?usage: run.sh <model> <with|without> [case ...]}"
VARIANT="${2:?usage: run.sh <model> <with|without> [case ...]}"
shift 2
if [ "$#" -gt 0 ]; then CASES=("$@"); else CASES=($(ls cases)); fi

SKILL_FILE="../skills/fable-mode/SKILL.md"
OUT="results/${MODEL}-${VARIANT}"
mkdir -p "$OUT"

for c in "${CASES[@]}"; do
  echo "=== $c ($MODEL/$VARIANT)"
  work="$(mktemp -d)"
  if [ -f "cases/$c/fixture" ]; then
    cp -R "fixtures/$(cat "cases/$c/fixture")/." "$work/"
  fi
  git -C "$work" init -q
  git -C "$work" -c user.email=test@test -c user.name=test add -A
  git -C "$work" -c user.email=test@test -c user.name=test commit -qm base --allow-empty

  args=(-p --model "$MODEL" --dangerously-skip-permissions)
  if [ "$VARIANT" = "with" ]; then
    args+=(--append-system-prompt "$(cat "$SKILL_FILE")")
  fi

  prompt="$(cat "cases/$c/prompt.txt")"
  (cd "$work" && env -u CLAUDECODE -u CLAUDE_CODE_ENTRYPOINT claude "${args[@]}" "$prompt") \
    > "$OUT/$c.response.md" 2> "$OUT/$c.err" || echo "  RUN FAILED (see $OUT/$c.err)"

  git -C "$work" add -A
  git -C "$work" diff --cached > "$OUT/$c.diff"
  rm -rf "$work"
done
echo "done → $OUT"
