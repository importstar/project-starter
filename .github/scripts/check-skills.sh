#!/usr/bin/env bash
# BMAD ใช้เฉพาะ Gate 0–1 — skill bmad-* นอกรายการนี้ห้ามอยู่ใน repo (ดู AGENTS.md หมวด 5)
set -euo pipefail

ALLOWED=(
  bmad-advanced-elicitation bmad-agent-analyst bmad-agent-pm bmad-agent-ux-designer
  bmad-brainstorming bmad-create-epics-and-stories bmad-customize bmad-deep-recon
  bmad-forge-idea bmad-help bmad-party-mode bmad-prd bmad-prfaq bmad-product-brief
  bmad-review bmad-spec bmad-ux
)

fail=0
for dir in .agents/skills/bmad-* _bmad/*/v6-shims; do
  [ -e "$dir" ] || continue
  name=$(basename "$dir")
  if [[ "$name" == v6-shims || ! " ${ALLOWED[*]} " =~ " $name " ]]; then
    echo "::error::$dir ไม่ได้รับอนุญาต (BMAD ใช้เฉพาะ Gate 0–1) — ลบออก หรือแก้ allowlist ใน $0"
    fail=1
  fi
done

if [ -e .claude/skills ] && [ ! -L .claude/skills ]; then
  echo "::error::.claude/skills ต้องเป็น symlink ไปที่ ../.agents/skills"
  fail=1
fi

exit $fail
