# Structure

Each skill lives in `skills/<name>/SKILL.md` with YAML frontmatter (`name`,
`description`) and a plain-markdown body.

```
skills/<name>/SKILL.md   # one skill per directory; YAML frontmatter + body
.claude/skills           # symlink to skills/ (Claude Code picks them up here)
.agents/skills           # symlink to skills/ (Agent Skills convention: Codex, Copilot, ...)
tests/                   # behavioral test harness (real-model A/B runs)
install.sh               # install into ~/.claude/skills and/or ~/.agents/skills
```

`.claude/skills` and `.agents/skills` are symlinks to `skills/`, so every skill
here is directly usable in this repo by Claude Code and by Agent Skills-aware
tools (Codex, Copilot).
