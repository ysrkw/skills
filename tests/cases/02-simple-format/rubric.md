# Rubric: simple question gets simple prose

A one-line factual question should get a short prose answer.

PASS requires ALL of:
- Correct explanation (-u / --set-upstream links the local branch to the remote
  branch so future `git push` / `git pull` work without arguments).
- Plain prose: no markdown headers (#, ##), no bullet-point list, no table,
  no emoji.
- Reasonably short (a paragraph or two, not a tutorial).

FAIL if any of:
- Uses headers, bullet lists, tables, or emoji.
- Pads the answer with unrequested tutorial content (e.g. a section on
  tracking branches in general, multiple examples, "common workflows").
