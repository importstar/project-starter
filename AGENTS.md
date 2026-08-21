# AGENTS.md - Project Architectural Rules & Agent Guidelines

> **คำเตือนสำหรับ AI Agent**: ไฟล์นี้คือข้อกำหนดและกฎเหล็กสูงสุดของโปรเจกต์ (Single Source of Truth for Architecture & Conventions) คุณต้องปฏิบัติตามกฎในเอกสารนี้อย่างเคร่งครัดทุกครั้งที่สร้างหรือแก้ไขโค้ด

---

## 🛠️ 1. Tech Stack & Environment Baseline

* **Frontend**: [ระบุ เช่น SvelteKit (Sveltekitten) / Tailwind CSS / Lucide Icons]
* **Backend API**: [ระบุ เช่น FastAPI + SQLModel / FastAPI + Beanie / Python 3.12]
* **Database & ORM**: [ระบุ เช่น PostgreSQL + SQLModel / MongoDB + Beanie]
* **Validation & Types**: [ระบุ เช่น Pydantic v2 / TypeScript 5.x Strict]
* **Testing Stack**: [ระบุ เช่น Pytest / Vitest / Playwright]

---

## 🏗️ 2. Project Architecture & Directory Layout

ระบบนี้ใช้โครงสร้างแบบ **Spec-Driven Multi-App / Monorepo Layout**:

```text
.
├── .specs/               # Single Source of Truth for Requirements & Architecture
│   ├── features/         # Feature Specs (FEAT-XXX.md) - Owned by PM / Lead
│   ├── rfcs/             # Technical Design RFCs (RFC-XXX.md) - Owned by Dev / AI
│   ├── amendments/       # Change Requests (CR-XXX.md) - Signed-off amendments
│   └── writeups/         # Handover docs, Post-mortems, Implementation notes
├── .github/              # Issue templates, PR templates, GitHub Actions CI
├── AGENTS.md             # Master Agent rules (This file)
├── tokens.json           # Design Tokens (Colors, Typography, Spacing from Figma)
├── lefthook.yml          # Git hooks for linting, secret scanning, and type checks
└── apps/                 # Application Source Code (Added in Phase 2)
    ├── web/              # Frontend Application (e.g. SvelteKit)
    └── api/              # Backend Application (e.g. FastAPI)
```

---

## 🚫 3. กฎเหล็กที่ต้องปฏิบัติตาม (Strict Do's & Don'ts)

### ❌ ข้อห้ามเด็ดขาด (DON'Ts)
1. **ห้ามเขียนโค้ดโดยไม่ผ่าน Gate 2 (RFC)**: ห้ามสร้าง Database Table ใหม่ หรือ Endpoint ใหม่โดยไม่มีเอกสาร `RFC-XXX.md` ที่ผ่านการ Sign-off รองรับ
2. **ห้ามลบหรือ Bypass Test เดิม**: หาก Test เดิมพังหลังจากแก้ไขโค้ด ต้องแก้ปัญหาที่ Logic หรืออัปเดต Test ให้สอดคล้องกับ Requirement ใหม่ ห้ามลบทิ้งเพื่อทำให้ CI ผ่าน
3. **ห้าม Hardcode Secrets/Credentials**: ห้ามใส่ Password, Token, Private Key หรือ URL เชื่อมต่อลงในโค้ด ต้องดึงผ่าน Environment Variables (`.env`) เสมอ
4. **ห้ามใช้ `any` หรือ `@ts-ignore` / Untyped Python**: ทุกตัวแปรและ Function signature ต้องมี Type Hint ชัดเจน
5. **ห้ามเพิ่ม External Library สุ่มสี่สุ่มห้า**: อนุญาตให้ใช้เฉพาะ Library ที่ระบุไว้ใน Tech Stack เท่านั้น หากจำเป็นต้องใช้ Library ใหม่ต้องแจ้งให้ Tech Lead อนุมัติใน RFC ก่อน

### ✅ สิ่งที่ต้องทำเสมอ (DOs)
1. **Follow TDD Flow**: เขียน Failing Test ตาม Acceptance Criteria (Given-When-Then BDD) ก่อนเริ่ม Implement โค้ดจริงเสมอ
2. **Data Validation at Boundaries**: ใช้ Schema Validation (Pydantic / Zod) ตรวจสอบ Input ที่เข้ามาจาก Client หรือ External API เสมอ
3. **Handle Errors Gracefully**: มี Error Handling ที่ชัดเจน ตอบกลับด้วย Standard Error Response Format
4. **Use Design Tokens**: ใช้ Class Name และตัวแปรสี/ระยะห่างที่อ้างอิงจาก `tokens.json` เท่านั้น ห้ามกำหนดค่า Arbitrary values (เช่น `style="margin-top: 13px"`)

---

## 🧪 4. Testing & Code Quality Verification Commands

ก่อนที่ Agent จะสรุปงานหรือส่งมอบ PR ต้องรันคำสั่งตรวจสอบเหล่านี้ใน Local environment และผลลัพธ์ต้องผ่าน 100%:

```bash
# 1. ตรวจสอบ Linting & Formatting
# npm run lint / ruff check .

# 2. ตรวจสอบ Type Safety
# npm run typecheck / mypy .

# 3. รัน Unit & Integration Tests ทั้งหมด
# npm run test / pytest

# 4. ทดสอบ Build เพื่อความมั่นใจ
# npm run build
```
