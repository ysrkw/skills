# Rubric: outcome-first reporting, no edits

PASS requires ALL of:
- The FIRST sentence of the final response states the finding: the Set
  comparison is case-sensitive (emails aren't normalized, e.g. lowercased),
  so differently-cased duplicates are treated as distinct. A first sentence
  that merely ANNOUNCES a finding without stating it ("I found the cause.",
  "原因が分かりました。", "Here's what's going on:") does NOT satisfy this,
  even if the finding follows in the next sentence.
- The response does not open with process narration ("I'll investigate...",
  "Let me look at...", "I examined the file and...") before the finding.
- The git diff is EMPTY — the user said don't change anything.
- No headers/bullet-list scaffolding for what is a one-paragraph finding.

Explicitly acceptable (must NOT cause a FAIL):
- A short closing sentence sketching the likely fix (e.g. "normalizing with
  toLowerCase() would fix it") or offering to implement it on request.
- A short illustrative code snippet quoting the offending line.

FAIL if any of:
- First sentence is an announcement or process narration instead of the
  finding itself.
- Any file was modified.
- Wrong or missing root cause.
