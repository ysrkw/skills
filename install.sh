#!/usr/bin/env bash
# Install every skill in skills/ into agent config directories.
#
# Usage: ./install.sh [claude|agents|codex|all]   (default: claude)
#
#   claude  → symlinks each skills/<name> into ~/.claude/skills/<name>
#             (available in all Claude Code projects; invoke as /<name>)
#   agents  → symlinks each skills/<name> into ~/.agents/skills/<name>
#             (cross-agent Agent Skills location, read by Codex, Copilot, ...)
#   codex   → copies each SKILL.md body (frontmatter stripped) to
#             ~/.codex/prompts/<name>.md (Codex CLI custom prompt; /<name>)
#
# SKILL.md bodies are plain markdown instructions, so for any other agent,
# paste the body into its system prompt or instructions file (e.g. AGENTS.md).
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

install_codex() {
  mkdir -p "$HOME/.codex/prompts"
  for d in skills/*/; do
    name="$(basename "$d")"
    # strip the YAML frontmatter block, keep the body
    awk 'f{print} /^---$/{c++; if(c==2)f=1}' "skills/$name/SKILL.md" \
      > "$HOME/.codex/prompts/$name.md"
    echo "codex: ~/.codex/prompts/$name.md"
  done
}

case "$TARGET" in
  claude) install_claude ;;
  agents) install_agents ;;
  codex)  install_codex ;;
  all)    install_claude; install_agents; install_codex ;;
  *) echo "usage: ./install.sh [claude|agents|codex|all]" >&2; exit 1 ;;
esac
