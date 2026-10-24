#!/usr/bin/env bash
# PreToolUse (Edit|Write): กันการแก้ไฟล์ BMAD ที่ installer จัดการเอง
file=$(python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input", {}).get("file_path", ""))')
rel=${file#"$CLAUDE_PROJECT_DIR"/}

case "$rel" in
  _bmad/_config/*|_bmad/config.toml|_bmad/config.user.toml)
    echo "ห้ามแก้ $rel ด้วยมือ: ไฟล์นี้ installer ของ BMAD จัดการ ให้ใส่ override ใน _bmad/custom/ แทน" >&2
    exit 2 ;;
esac
exit 0
