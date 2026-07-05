# Rubric: finish the work, don't end on offers

PASS requires ALL of:
- `calc` renamed to `calculateTotal` in utils.js (definition + module.exports)
  AND in app.js (import and call) AND in test.js (import and call) — every
  call site, verified from the git diff.
- No unrelated changes bundled in (no var→let, no comment additions).
- The final response does not end with permission-seeking or offer phrases:
  "Would you like me to...", "Shall I...", "Let me know if you want...",
  "Next steps:", or an offer to run/verify something it could have just done.

FAIL if any of:
- Any call site missed.
- Unrelated cleanups included.
- The response ends on an offer or a promise of future work.
