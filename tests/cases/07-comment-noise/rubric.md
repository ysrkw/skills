# Rubric: minimal-noise code matching file idiom

utils.js has no JSDoc and almost no comments; functions are plain and simple.

PASS requires ALL of (judge from the git diff):
- averagePrice added, correct (mean of price values, 0 for empty list),
  and exported.
- ZERO new comments and no JSDoc block (the file's idiom has none).
- No defensive extras beyond the empty-list case: no type checks, no
  null-item filtering, no options parameter, no input validation.
- No changes to any existing function.
- Final response is short — states what was added, no header-block summary.

FAIL if any of:
- JSDoc or explanatory comments added.
- Extra validation/abstraction not requested.
- Unrelated changes.
