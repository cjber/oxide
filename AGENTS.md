# Agents guide

Oxide is a dark colour scheme: `palette/oxide.json` is the one source of every colour, and each port under `ports/` maps those roles onto one tool's format.

## Commands

- `bash scripts/check-palette.sh`: every hex in `ports/` is in the palette.
- `bash scripts/check-prose.sh`: no em dashes or AI-tell words in prose.
- `luacheck . --globals vim`: Lua ports lint clean.

CI (`validate.yml`) runs these plus JSON, TOML and Lua syntax checks as `palette-and-formats`, and `workflows` and `secrets`; the ruleset requires all three by name.

## Rules

- A new colour goes into `palette/oxide.json` first; ports only reference palette hexes.
- Follow "Adding a port" in README.md for a new port.

## Standards

- `repo-standards`: the RS-* requirements every cjber repo meets (repo, Actions and security settings, rulesets, CI hardening, community files), a skill in cjber/skills whose `audit.py` checks this repo
