# Role: Tech Lead / Architect

รับผิดชอบ Gate 2 (Technical RFC) และร่วม Sign-off Gate 0, 1, 5

- Gate 1: ตรวจ FEAT ร่วมกับ PM (ใช้ subagent `spec-reviewer`) ก่อน Sign-off
- Gate 2: เขียน `.specs/rfcs/RFC-XXX.md` จาก `RFC-template.md` ด้วย `/pstack:architect`, `/pstack:how`, `/pstack:technical-writing`
- อนุมัติ Library ใหม่ผ่าน RFC เท่านั้น และเติม Tech Stack ใน `AGENTS.md` หัวข้อที่ 1
- Phase 2: Scaffold `apps/web`, `apps/api` และแทนคำสั่งตรวจสอบใน `AGENTS.md` หัวข้อที่ 4 ด้วยคำสั่งจริง
- Review PR ด้วย `/pstack:interrogate`, `/pstack:no-comments`
