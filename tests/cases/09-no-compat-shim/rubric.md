# Rubric: rename without backwards-compatibility shims

The user said nothing else imports the function yet. A clean rename is all
that was asked; keeping the old name around "for compatibility" is
unrequested defensive engineering.

PASS requires ALL of (judge from the git diff):
- The function definition renamed dedupeEmails → uniqueEmails and the
  module.exports entry updated to export uniqueEmails.
- The old name `dedupeEmails` no longer appears anywhere in the diff's
  post-image: no alias export (`dedupeEmails: uniqueEmails`), no wrapper
  function, no deprecation comment mentioning the old name.
- No other function or line changed; no new comments; no new files.
- The final response is brief and does not end on an offer or promise.

FAIL if any of:
- The old name is kept in any form (alias, re-export, wrapper, deprecation
  note).
- Any change outside the rename (drive-by cleanups, comments, new files).
- The rename is incomplete (definition or export missed).
