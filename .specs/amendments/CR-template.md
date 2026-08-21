# Change Request Form: [CR-XXX] [ชื่อรายการขอเปลี่ยนแปลง]

* **CR Number**: `CR-XXX`
* **Related Feature**: [`FEAT-XXX.md`](file:///home/jakee/Projects/IMPS-Pipeline/.specs/features/FEAT-XXX.md)
* **Date Requested**: [YYYY-MM-DD]
* **Requested By**: [ชื่อตัวแทนลูกค้า / ฝั่งธุรกิจ]
* **Impact Analyzed By**: [ชื่อ PM / Spec Agent]
* **Status**: `REQUESTED` | `IMPACT_ANALYZED` | `APPROVED_BY_CLIENT` | `REJECTED` | `IMPLEMENTED`

---

## 1. 📝 Change Description (รายละเอียดสิ่งที่ขอปรับเปลี่ยน)

### สเปกเดิมที่ตกลงไว้ (Original Baseline):
> [ระบุสิ่งที่เคยตกลงกันไว้ใน FEAT-XXX เช่น: ระบบรองรับการชำระเงินผ่าน PromptPay QR Code เท่านั้น]

### สิ่งที่ลูกค้าต้องการเปลี่ยนแปลง/เพิ่มเติม (Requested Modification):
> [ระบุความต้องการใหม่ เช่น: ต้องการเพิ่มช่องทางชำระเงินด้วยบัตรเครดิต (Visa/Mastercard) ผ่าน Omise Gateway]

### เหตุผลทางธุรกิจของลูกค้า (Business Justification):
> [เช่น: เพื่อรองรับลูกค้าชาวต่างชาติที่ไม่สามารถใช้ PromptPay ได้]

---

## 2. 🔍 Impact Analysis (การวิเคราะห์ผลกระทบโดยทีมงาน & Spec Agent)

### 2.1 Technical Impact (ผลกระทบเชิงเทคนิค)
* **Database Schema**: ต้องเพิ่มตาราง `card_transactions` และฟิลด์ `charge_id`
* **External APIs**: ต้องเชื่อมต่อ Omise SDK และทำ Webhook Listener ใหม่
* **Security & Compliance**: ต้องปฏิบัติตามมาตรฐาน PCI-DSS (Tokenization ห้ามเก็บเลขบัตรลงเซิร์ฟเวอร์เรา)

### 2.2 Timeline & Man-hours Impact (ผลกระทบต่อเวลาและงบประมาณ)
* **Estimated Additional Effort**: `[XX]` Man-hours
  * Spec & RFC Design: `[X]` Hours
  * Development & TDD: `[X]` Hours
  * QA & Integration Test: `[X]` Hours
* **Timeline Impact**: ขยายวันส่งมอบ Milestone ออกไป `[X]` วันทำการ (หรือนำไปทำในงวดถัดไป)
* **Additional Cost**: `[XX,XXX]` THB (ยังไม่รวมค่าธรรมเนียม Transaction Fee ของ Gateway)

---

## 3. 🚦 Sign-off & Client Approval

โดยการลงนามด้านล่างนี้ ทั้งสองฝ่ายตกลงที่จะปรับแก้ขอบเขตงานตามเงื่อนไข ค่าใช้จ่าย และระยะเวลาที่ระบุไว้ในเอกสารนี้:

* **ตัวแทนฝั่งลูกค้า (Client Sign-off)**:
  * ลายมือชื่อ: _____________________________
  * วันที่: _____________________________
  * ความเห็น: [ อนุมัติ / ไม่อนุมัติ ]

* **ตัวแทนฝั่ง Software House (PM Sign-off)**:
  * ลายมือชื่อ: _____________________________
  * วันที่: _____________________________
