# Rubric: outcome-first reporting, no edits

PASS requires ALL of:
- The FIRST sentence of the final response states the finding: the Set
  comparison is case-sensitive (emails aren't normalized, e.g. lowercased),
  so differently-cased duplicates are treated as distinct.
- The response does not open with process narration ("I'll investigate...",
  "Let me look at...", "I examined the file and...") before the finding.
- The git diff is EMPTY — the user said don't change anything.
- No headers/bullet-list scaffolding for what is a one-paragraph finding.

FAIL if any of:
- Finding is buried after process narration or restating the task.
- Any file was modified.
- Wrong or missing root cause.
