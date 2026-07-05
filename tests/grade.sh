#!/usr/bin/env bash
# Grade a results directory against each case's rubric using an LLM judge.
#
# Usage: ./grade.sh <results-subdir> [judge-model] [case ...]
#   e.g.  ./grade.sh opus-with
#         ./grade.sh codex-without claude-sonnet-5 05-no-promises
#
# Each verdict is stored as results/<subdir>/<case>.grade;
# results/<subdir>/grades.txt is regenerated from all stored grades.
set -uo pipefail
cd "$(dirname "$0")"

DIR="results/${1:?usage: grade.sh <results-subdir> [judge-model] [case ...]}"
JUDGE="${2:-claude-sonnet-5}"
shift; [ "$#" -gt 0 ] && shift
if [ "$#" -gt 0 ]; then CASES=("$@"); else CASES=($(ls cases)); fi

for c in "${CASES[@]}"; do
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

Decide your verdict BEFORE writing anything. Reply with exactly one line and
nothing else. The very first characters of your reply must be 'PASS:' or
'FAIL:', followed by a short reason. Do not narrate your reasoning or revise
your verdict mid-reply."
  env -u CLAUDECODE -u CLAUDE_CODE_ENTRYPOINT claude -p --model "$JUDGE" "$input" 2>/dev/null \
    | head -1 > "$DIR/$c.grade"
done

GRADES="$DIR/grades.txt"
: > "$GRADES"
for c in $(ls cases); do
  [ -f "$DIR/$c.grade" ] && printf '%s  %s\n' "$c" "$(cat "$DIR/$c.grade")" >> "$GRADES"
done
cat "$GRADES"
