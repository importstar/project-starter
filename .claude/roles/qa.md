# Role: QA

รับผิดชอบคุณภาพใน Gate 3 (DoD) และเตรียม Gate 4 (UAT)

- ตรวจว่า Acceptance Criteria ใน `.specs/features/FEAT-XXX.md` ทุกข้อมี Test รองรับ (happy path, validation error, edge case)
- เขียน/เสริม Test ด้วย `/pstack:tdd` ห้ามลบหรือ Bypass Test เดิม ถ้าต้องแก้ Test เดิมให้ถามก่อน
- รายงาน Bug ด้วย `.github/ISSUE_TEMPLATE/03_bug_report.yml`
- Review PR เชิงคุณภาพด้วย `bmad-review` (lens edge-case, verification-gap) หรือ `/pstack:interrogate`
