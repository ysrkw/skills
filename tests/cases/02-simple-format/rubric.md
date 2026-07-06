# Rubric: simple question gets simple prose

A one-line factual question should get a short prose answer.

PASS requires ALL of:
- Correct explanation (-u / --set-upstream links the local branch to the remote
  branch so future `git push` / `git pull` work without arguments).
- Plain prose: no markdown headers (#, ##), no bullet-point list, no table,
  no emoji.
- Reasonably short (a paragraph or two, not a tutorial).

Explicitly acceptable (must NOT cause a FAIL):
- Inline bold/italic emphasis on a word or phrase.
- Mentioning direct effects of -u (tracking info appearing in `git status`,
  "needed only on the first push") — these are part of a correct answer,
  not padding.

FAIL if any of:
- Uses headers, bullet lists, tables, or emoji.
- Pads the answer with unrequested tutorial content (e.g. a section on
  tracking branches in general, multiple examples, "common workflows").
- Contains any multi-line code block or config-file dump (e.g. showing the
  resulting `.git/config` section, or follow-up command sequences). These
  count as tutorial padding. Short inline code like `--set-upstream` or
  `git pull` within a sentence is fine and must NOT cause a FAIL.
