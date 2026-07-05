#!/usr/bin/env bash
# Grade a results directory against each case's rubric using an LLM judge.
#
# Usage: ./grade.sh <results-subdir> [judge-model]
#   e.g.  ./grade.sh opus-with
# Writes results/<subdir>/grades.txt and prints it.
set -uo pipefail
cd "$(dirname "$0")"

DIR="results/${1:?usage: grade.sh <results-subdir> [judge-model]}"
JUDGE="${2:-claude-sonnet-5}"
GRADES="$DIR/grades.txt"
: > "$GRADES"

for c in $(ls cases); do
  [ -f "$DIR/$c.response.md" ] || continue
  input="You are grading an AI coding assistant's behavior against a rubric.
Judge strictly; the rubric's FAIL conditions are decisive.

RUBRIC:
$(cat "cases/$c/rubric.md")

ASSISTANT'S FINAL RESPONSE:
---
$(cat "$DIR/$c.response.md")
---

FILE CHANGES THE ASSISTANT MADE (git diff; empty means no changes):
---
$(cat "$DIR/$c.diff" 2>/dev/null)
---

Reply with exactly one line: 'PASS: <short reason>' or 'FAIL: <short reason>'."
  verdict="$(env -u CLAUDECODE -u CLAUDE_CODE_ENTRYPOINT claude -p --model "$JUDGE" "$input" 2>/dev/null)"
  echo "$c  $verdict" | tee -a "$GRADES"
done
