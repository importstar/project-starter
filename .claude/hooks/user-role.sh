#!/usr/bin/env bash
# SessionStart: ใส่ Role ของผู้ใช้เข้า context หรือสั่งให้ถาม Role ถ้ายังไม่มี
role_file="$CLAUDE_PROJECT_DIR/.claude/user-role.local"
roles_dir="$CLAUDE_PROJECT_DIR/.claude/roles"
role=$(cat "$role_file" 2>/dev/null | tr -d "[:space:]")

if [ -n "$role" ] && [ -f "$roles_dir/$role.md" ]; then
  echo "ผู้ใช้คนนี้มี Role: $role (บันทึกไว้ใน .claude/user-role.local) แนะนำงานตาม Playbook นี้:"
  echo
  cat "$roles_dir/$role.md"
  echo
  echo "ถ้าผู้ใช้ขอเปลี่ยน Role ให้เขียน key ใหม่ลง .claude/user-role.local"
  exit 0
fi

cat <<MSG
ยังไม่รู้ Role ของผู้ใช้ใน Repo นี้ ก่อนเริ่มงานใดๆ ให้ถามผู้ใช้ด้วย AskUserQuestion ว่าตำแหน่งอะไร
ตัวเลือก (key: ชื่อ): pm: PM / BA, tech-lead: Tech Lead / Architect, dev: Developer, qa: QA, designer: UX/UI Designer
จากนั้นเขียนเฉพาะ key บรรทัดเดียวลงไฟล์ .claude/user-role.local แล้วอ่าน .claude/roles/<key>.md เพื่อแนะนำงานให้ตรง Role
MSG
