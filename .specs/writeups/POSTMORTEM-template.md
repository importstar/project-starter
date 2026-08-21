# Post-Mortem Report: [PM-YYYYMMDD-XX] [ชื่อเหตุการณ์ / Incident Title]

* **Report ID**: `PM-YYYYMMDD-XX`
* **Incident Date**: [YYYY-MM-DD]
* **Severity**: `CRITICAL` | `MAJOR` | `MINOR`
* **Impact Duration**: `[XX] นาที / ชั่วโมง` (Downtime: `[HH:MM] - [HH:MM]`)
* **Affected Users / Traffic**: `[XXX] ราย` (`[XX]%` ของคำสั่งซื้อทั้งหมด)
* **Status**: `INVESTIGATING` | `MITIGATED` | `ACTION_ITEMS_PENDING` | `COMPLETED`
* **Lead Investigator**: [ชื่อ Tech Lead / Incident Commander]
* **Incident Responders**: [รายชื่อทีม Dev, DevOps, QA, PM ที่ร่วมแก้ไข]
* **Related Feature**: [`FEAT-XXX.md`](file:///home/jakee/Projects/IMPS-Pipeline/.specs/features/FEAT-XXX.md)
* **Related RFC**: [`RFC-XXX.md`](file:///home/jakee/Projects/IMPS-Pipeline/.specs/rfcs/RFC-XXX.md)
* **Related Hotfix / Release**: `hotfix/vX.X.X` (Patch Release `v1.0.1`)

---

## 1. 📌 Executive Summary & Business Impact (สรุปย่อสำหรับผู้บริหาร)

* **User Impact Summary**:
  > [อธิบายสรุปสั้นๆ 3-5 บรรทัด: เกิดอะไรขึ้น, สาเหตุหลักคืออะไร, ส่งผลกระทบต่อผู้ใช้หรือธุรกิจอย่างไร, และแก้ไขป้องกันอย่างไรให้ระบบกลับมาปลอดภัย]

* **Impact Assessment Matrix**:

| มิติการประเมิน (Dimension) | รายละเอียด (Details) |
| :--- | :--- |
| **ระดับความรุนแรง (Severity)** | `CRITICAL` (ระบบหลักล่ม / กระทบธุรกรรม) / `MAJOR` / `MINOR` |
| **ระยะเวลาที่ระบบขัดข้อง (Downtime)** | `[XX]` นาที (ตั้งแต่ [HH:MM] ถึง [HH:MM] น.) |
| **ผู้ใช้งานที่ได้รับผลกระทบ (User Impact)** | `[XXX]` บัญชี หรือ `[XX]%` ของคำสั่งซื้อทั้งหมด |
| **ความเสียหายด้านข้อมูล (Data Loss)** | [ไม่มีข้อมูลสูญหาย / มีธุรกรรมค้างชำระ XX รายการ - กู้คืนครบถ้วน] |
| **SLA Breach** | [มี / ไม่มี - ชดเชยตามข้อตกลง SLA หรือไม่] |

---

## 2. ⏱️ Chronological Timeline (ลำดับเวลาของเหตุการณ์)

บันทึกลำดับเวลาตามจริง (Timezone: UTC+7 / Asia/Bangkok):

* **`[HH:MM]` (T0 - Incident Start)**: [ระบบเริ่มเกิดความผิดปกติ เช่น Traffic เพิ่มสูงขึ้น และ Response time ช้าลงเกิน 5 วินาที]
* **`[HH:MM]` (T1 - Detection & Alert)**: [ระบบ Monitoring (Sentry/Datadog) แจ้งเตือน Error Rate > 5% หรือลูกค้าโทรแจ้ง]
* **`[HH:MM]` (T2 - Incident Response / Triage)**: [Tech Lead และ DevOps เข้า War room ประเมินสถานการณ์และเริ่มสืบค้น Logs]
* **`[HH:MM]` (T3 - Temporary Mitigation / Rollback)**: [สั่ง Rollback เวอร์ชันเดิม หรือเพิ่ม Pod / Scale Database ชั่วคราวเพื่อหยุดผลกระทบ]
* **`[HH:MM]` (T4 - Full Resolution / Hotfix Deployed)**: [Deploy Patch Release `vX.X.X` ขึ้น Production และ Smoke Test ผ่าน 100%]

---

## 3. 🔍 Root Cause Analysis (การวิเคราะห์รากเหง้าปัญหา - Blameless 5 Whys)

> [!NOTE]
> **Blameless Culture Policy**: การวิเคราะห์นี้มุ่งเน้นหาจุดบกพร่องของระบบ (Systemic & Process Failure) ไม่ใช่การเพ่งโทษบุคคล

* **ทำไมที่ 1 (Why 1)**: ทำไมระบบถึงตอบสนองช้าและเกิด Timeout?
  * *คำตอบ*: [เพราะ Database Connection Pool เต็ม ทำให้ Request อื่นๆ ถูกบล็อก]
* **ทำไมที่ 2 (Why 2)**: ทำไม Connection Pool ถึงเต็ม?
  * *คำตอบ*: [เพราะ Endpoint `/api/v1/webhook` มีการทำ Synchronous External Call ไปยัง Third-party API ที่ตอบสนองช้า]
* **ทำไมที่ 3 (Why 3)**: ทำไมถึงมีการทำ Synchronous Call ค้างไว้ใน Webhook?
  * *คำตอบ*: [เพราะใน `RFC-XXX.md` ไม่ได้ออกแบบ Background Worker Queue สำหรับประมวลผล Webhook แบบ Asynchronous]
* **ทำไมที่ 4 (Why 4)**: ทำไมใน RFC ถึงตกหล่นการออกแบบ Queue?
  * *คำตอบ*: [เพราะใน `FEAT-XXX.md` ไม่ได้ระบุ Non-Functional Requirement (NFR) เรื่อง Concurrency Peak Load]
* **ทำไมที่ 5 (Why 5 - Root Cause)**: ทำไม Spec ถึงไม่มีการตรวจ NFR นี้ตั้งแต่แรก?
  * *คำตอบ*: [เพราะ Gate 1 (DoR Checklist) และ Prompt ของ Spec Agent ยังไม่มีข้อบังคับให้ Interrogate เรื่อง Peak Concurrency ในทุกฟีเจอร์ชำระเงิน]

---

## 4. ⚖️ What Went Well & What Went Wrong (สิ่งที่ทำได้ดีและจุดที่ต้องปรับปรุง)

### ✅ สิ่งที่ทำได้ดี (What Went Well):
* [ระบบ Alert แจ้งเตือนทันทีภายใน 2 นาทีหลัง Error Rate พุ่ง]
* [กระบวนการ Rollback ทำได้รวดเร็วตาม SLA 15 นาที ไร้ข้อมูลสูญหาย]

### ❌ สิ่งที่ต้องปรับปรุง (What Went Wrong):
* [Automated Tests ใน Gate 3 ไม่มีการจำลอง High-latency Third-party Call]
* [ไม่มี Circuit Breaker ตัดการทำงานเมื่อ Gateway ภายนอกตอบช้า]

### 🍀 จุดที่โชคดี (Where We Got Lucky):
* [เกิดเหตุการณ์ในช่วงบ่ายวันธรรมดาที่ทีม Lead และ DevOps ประจำการอยู่ครบ]

---

## 5. 🛡️ Corrective & Preventative Action Items (แผนงานแก้ไขและป้องกัน)

| ลำดับ | รายการงานป้องกัน (Action Item) | ประเภท (Type) | ผู้รับผิดชอบ (Owner) | Jira / GitHub Issue | กำหนดเสร็จ (Due Date) |
| :---: | :--- | :---: | :---: | :---: | :---: |
| 1 | ปรับ Webhook ให้ทำงานผ่าน Redis Queue (Asynchronous) | **Fix** | `@developer` | `#142` | `YYYY-MM-DD` |
| 2 | เพิ่ม Integration Test จำลองกรณี Third-party API ช้า (Timeout Mock) | **Test** | `@qa-lead` | `#143` | `YYYY-MM-DD` |
| 3 | เพิ่ม Circuit Breaker และ Rate Limiting ใน Gateway | **Infra** | `@devops` | `#144` | `YYYY-MM-DD` |
| 4 | อัปเดต `AGENTS.md` เพิ่มกฎห้ามทำ Synchronous External Call ใน Webhooks | **Rule** | `@tech-lead` | `#145` | `YYYY-MM-DD` |

---

## 6. 🤖 Agent Knowledge Feeding & Rule Updates (การป้อนบทเรียนสู่ระบบและ AI)

เพื่อป้องกันไม่ให้ AI Coding Agent หรือ Developer ทำผิดซ้ำในอนาคต:

### 6.1 กฎใหม่ที่เพิ่มลงใน `AGENTS.md`:
```markdown
### Webhook & External API Architecture Rules:
- ห้ามทำ Synchronous Call ไปยัง Third-party APIs ภายใน Webhook Request Handler โดยเด็ดขาด
- ต้องบันทึก Webhook Payload ลง Queue (Redis / BullMQ) และตอบกลับ `200 OK` ทันทีภายใน 500ms
- ต้องออกแบบ Idempotency Key สำหรับรองรับ Retry ทุกครั้ง
```

### 6.2 การอ้างอิง Post-Mortem นี้ในอนาคต (Prompt Injection Context):
* เมื่อมีการพัฒนาฟีเจอร์ชำระเงินหรือ Webhook ใหม่ ให้ป้อน Context:  
  `@.specs/postmortems/PM-YYYYMMDD-XX.md` เข้าไปใน RFC Agent และ Coding Agent เสมอ

---

## 🚦 Post-Mortem Review & Sign-off Checklist

- [ ] Timeline ถูกถอดอย่างแม่นยำตาม Server Logs และ Alert Timestamps
- [ ] วิเคราะห์สาเหตุเชิงระบบด้วย 5 Whys ครบถ้วน (Blameless Culture)
- [ ] ทุก Action Items มี Assignee, GitHub/Jira Issue link และ Due Date ชัดเจน
- [ ] อัปเดตข้อห้าม/กฎใหม่ลงใน `AGENTS.md` เรียบร้อยแล้ว
- [ ] เพิ่ม Automated Regression Test เพื่อป้องกันบั๊กซ้ำใน CI
- [ ] **Tech Lead / Lead Investigator**: ____________________ (Date: __________)
- [ ] **Head of Engineering / CTO**: ____________________ (Date: __________)
- [ ] **Client Representative (ถ้ามี)**: ____________________ (Date: __________)
