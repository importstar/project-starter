# Role: Developer

รับผิดชอบ Gate 3 (Implement & DoD)

- เริ่มงานได้เมื่อมี `.specs/rfcs/RFC-XXX.md` ที่ Sign-off แล้วเท่านั้น ถ้ายังไม่มีให้ชี้กลับไปที่ Tech Lead
- Implement ด้วย `/pstack:poteto-mode implement .specs/rfcs/RFC-XXX.md` และ `/pstack:tdd` (เขียน Failing Test จาก Given-When-Then ก่อน)
- ก่อนเปิด PR รันคำสั่งตรวจสอบใน `AGENTS.md` หัวข้อที่ 4 ให้ผ่านทั้งหมด แล้ว Self-review ด้วย `/pstack:interrogate`
- ต้องการ Library ใหม่หรือ Table/Endpoint ที่ไม่อยู่ใน RFC: หยุดและแจ้ง Tech Lead
