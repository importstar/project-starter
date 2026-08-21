## 📌 Description & Context
<!-- อธิบายสรุปการเปลี่ยนแปลงใน PR นี้ และปัญหาที่แก้ไข -->

* **Related Feature Spec**: `.specs/features/FEAT-XXX.md`
* **Related RFC**: `.specs/rfcs/RFC-XXX.md`
* **Related Issue / Amendment**: #

---

## 🚦 Gatekeeper Checklist

### 🚪 Gate 2: Technical Design & Architecture
- [ ] สถาปัตยกรรมและโครงสร้างโค้ดตรงตาม `RFC-XXX.md` ที่ผ่านการ Sign-off
- [ ] ไม่มี Unauthorized external library เพิ่มเข้ามา
- [ ] Database Migration มีทั้ง Up & Down script (ถ้ามี)

### 🚪 Gate 3: Definition of Done (DoD)
- [ ] โค้ดผ่านการตรวจสอบ Linter & Formatter (`npm run lint` / `ruff check`)
- [ ] โค้ดผ่านการ Type-check 100% ปราศจาก `any` หรือ `@ts-ignore`
- [ ] มี Unit Tests ครอบคลุมทั้ง Happy Path และ Edge Cases ตาม BDD Spec
- [ ] Unit & Integration Tests ทั้งหมดรันผ่าน (`npm run test` / `pytest`)
- [ ] ไม่มีการ Hardcode Credentials หรือ Secrets ใดๆ
- [ ] สไตล์ UI และระยะห่างอ้างอิงจาก `tokens.json` ถูกต้อง

---

## 🧪 How Has This Been Tested?
<!-- อธิบายวิธีการทดสอบผลลัพธ์ในเครื่อง Local หรือ Preview environment -->
- [ ] Unit Test Suite
- [ ] Integration Test
- [ ] Manual E2E Verification
