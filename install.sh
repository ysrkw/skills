#!/usr/bin/env bash
# Install every skill in skills/ into agent config directories.
#
# Usage: ./install.sh [claude|agents|all]   (default: claude)
#
#   claude  → symlinks each skills/<name> into ~/.claude/skills/<name>
#             (available in all Claude Code projects; invoke as /<name>)
#   agents  → symlinks each skills/<name> into ~/.agents/skills/<name>
#             (Agent Skills user-level location; Codex and other
#              Agent Skills-aware tools read it natively — "codex" is
#              accepted as an alias)
#
# SKILL.md bodies are plain markdown instructions, so for any agent without
# Agent Skills support, paste the body into its system prompt or
# instructions file (e.g. AGENTS.md).
set -euo pipefail
cd "$(dirname "$0")"

TARGET="${1:-claude}"

install_claude() {
  mkdir -p "$HOME/.claude/skills"
  for d in skills/*/; do
    name="$(basename "$d")"
    ln -sfn "$PWD/skills/$name" "$HOME/.claude/skills/$name"
    echo "claude: ~/.claude/skills/$name -> $PWD/skills/$name"
  done
}

install_agents() {
  mkdir -p "$HOME/.agents/skills"
  for d in skills/*/; do
    name="$(basename "$d")"
    ln -sfn "$PWD/skills/$name" "$HOME/.agents/skills/$name"
    echo "agents: ~/.agents/skills/$name -> $PWD/skills/$name"
  done
}

case "$TARGET" in
  claude)       install_claude ;;
  agents|codex) install_agents ;;
  all)          install_claude; install_agents ;;
  *) echo "usage: ./install.sh [claude|agents|all]" >&2; exit 1 ;;
esac
