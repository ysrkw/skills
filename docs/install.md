# Install

```sh
git clone git@github.com:ysrkw/skills.git
cd skills
./install.sh claude   # symlink into ~/.claude/skills (all Claude Code projects)
./install.sh agents   # symlink into ~/.agents/skills (Codex etc.; "codex" is an alias)
./install.sh all
```

In Claude Code, invoke a skill as `/<name>` (e.g. `/fable-mode`) at the start
of a session. Codex reads Agent Skills natively — from `~/.agents/skills`
(user-level) and from `.agents/skills` inside a repo — and activates them
implicitly by description or explicitly via `$<name>`. For agents without
Agent Skills support, paste the SKILL.md body into the system prompt or
AGENTS.md.
