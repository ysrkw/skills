#!/usr/bin/env bash
# Run the behavioral test cases against Codex CLI, with or without the
# fable-mode skill injected.
#
# Usage: ./run-codex.sh <with|without> [case ...]
#
# The "with" variant writes the SKILL.md body (frontmatter stripped) as
# AGENTS.md in the throwaway workspace — Codex's native always-on
# instructions file — so the A/B delta is exactly the skill text.
# Results land in results/codex-<variant>/ and are graded by grade.sh.
# Set RUN_TAG=r2 etc. to write to results/codex-<variant>-r2 instead.
set -uo pipefail
cd "$(dirname "$0")"

VARIANT="${1:?usage: run-codex.sh <with|without> [case ...]}"
shift
if [ "$#" -gt 0 ]; then CASES=("$@"); else CASES=($(ls cases)); fi

SKILL_FILE="../skills/fable-mode/SKILL.md"
OUT="results/codex-${VARIANT}${RUN_TAG:+-$RUN_TAG}"
mkdir -p "$OUT"

for c in "${CASES[@]}"; do
  echo "=== $c (codex/$VARIANT)"
  work="$(mktemp -d)"
  if [ -f "cases/$c/fixture" ]; then
    cp -R "fixtures/$(cat "cases/$c/fixture")/." "$work/"
  fi
  if [ "$VARIANT" = "with" ]; then
    awk 'f{print} /^---$/{c++; if(c==2)f=1}' "$SKILL_FILE" > "$work/AGENTS.md"
  fi
  git -C "$work" init -q
  git -C "$work" -c user.email=test@test -c user.name=test add -A
  git -C "$work" -c user.email=test@test -c user.name=test commit -qm base --allow-empty

  prompt="$(cat "cases/$c/prompt.txt")"
  codex exec -C "$work" --sandbox workspace-write --ephemeral --color never \
    -o "$OUT/$c.response.md" "$prompt" \
    > "$OUT/$c.log" 2> "$OUT/$c.err" || echo "  RUN FAILED (see $OUT/$c.err)"

  rm -f "$work/AGENTS.md"
  git -C "$work" add -A
  git -C "$work" diff --cached -- . ':!AGENTS.md' > "$OUT/$c.diff"
  rm -rf "$work"
done
echo "done → $OUT"
