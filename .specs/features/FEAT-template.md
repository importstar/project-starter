# Feature Specification: [FEAT-XXX] [ชื่อฟีเจอร์ภาษาไทย/อังกฤษ]

* **Feature ID**: `FEAT-XXX`
* **Status**: `DRAFT` | `READY_FOR_REVIEW` | `APPROVED (Gate 1 Passed)` | `IN_DEVELOPMENT` | `COMPLETED`
* **Target Milestone**: `Milestone X (vX.X)`
* **Author / Spec Owner**: [ชื่อ PM / Lead]
* **Sign-off By (Gate 1)**: [ชื่อ PM] & [ชื่อ Tech Lead]
* **Created Date**: [YYYY-MM-DD]
* **Related RFC**: [`RFC-XXX.md`](../rfcs/RFC-XXX.md)

---

## 1. 🎯 Executive Summary & Business Value

* **User Story**:
  > As a [ประเภทของผู้ใช้งาน เช่น สมาชิกทั่วไป / Admin ร้านค้า]  
  > I want to [สิ่งที่ต้องการทำในระบบ]  
  > So that [คุณค่าทางธุรกิจหรือประโยชน์ที่ได้รับ]

* **Business Context & Problem Statement**:
  [อธิบายปัญหาเดิม และทำไมฟีเจอร์นี้จึงจำเป็น]

---

## 2. 👥 User Roles & Access Control (RBAC)

| Role | สิทธิ์ในฟีเจอร์นี้ (Permissions) | หมายเหตุ |
| :--- | :--- | :--- |
| **Guest (Unauthenticated)** | ไม่อนุญาตให้เข้าถึง / Redirect ไปหน้า Login | |
| **Member** | สามารถสร้างและดูรายการของตัวเองได้เท่านั้น | |
| **Admin / Manager** | สามารถดู, อนุมัติ และ Export รายการทั้งหมดได้ | |

---

## 3. 🎨 User Flow & UI/UX References

* **Figma / Wireframe Link**: `[แปะลิงก์ Figma ที่นี่]`
* **Key Screen Progression**:
  1. หน้าแสดงรายการสินค้า / ตะกร้า
  2. หน้าต่างยืนยันการทำรายการ (Modal)
  3. หน้ารับแจ้งผลลัพธ์สำเร็จ (Success Page)

---

## 4. 📋 Acceptance Criteria (Given-When-Then BDD)

> **สำคัญมาก**: Acceptance Criteria ในส่วนนี้คือเกณฑ์ตัดสิน **Definition of Done (Gate 3)** และ **Client UAT (Gate 4)** รวมถึงใช้แยกความต่างระหว่าง **Bug vs Change Request**

### Scenario 1: [ชื่อกรณีทดสอบ เช่น การทำรายการสำเร็จแบบปกติ (Happy Path)]
* **Given** [เงื่อนไขเริ่มต้น/สถานะของระบบ เช่น ผู้ใช้ Login อยู่และมียอดในตะกร้า 500 บาท]
* **When** [การกระทำของผู้ใช้ เช่น กดปุ่ม 'ชำระเงิน' และสแกน QR สำเร็จ]
* **Then** [ผลลัพธ์ที่ระบบต้องทำ เช่น บันทึกสถานะเป็น PAID และส่งอีเมลยืนยัน]
* **And** [ผลลัพธ์ต่อเนื่อง เช่น หักสต็อกสินค้า 1 ชิ้น]

### Scenario 2: [ชื่อกรณีทดสอบ เช่น การทำรายการล้มเหลว / ยอดเงินไม่พอ (Error Path)]
* **Given** [ผู้ใช้เลือกชำระเงินด้วยบัตรเครดิตที่วงเงินไม่พอ]
* **When** [กดส่งรายการชำระเงิน]
* **Then** [ระบบต้องแสดงข้อความ Error สีแดงว่า 'การชำระเงินล้มเหลว: วงเงินไม่เพียงพอ']
* **And** [สถานะออเดอร์คงเดิมที่ 'UNPAID' และไม่หักสต็อกสินค้า]

### Scenario 3: [Edge Case / Timeout / Concurrency]
* **Given** [ผู้ใช้เปิดหน้าชำระเงินค้างไว้เกิน 15 นาที]
* **When** [สแกนชำระเงินหลังจาก QR Code หมดอายุ]
* **Then** [ระบบต้องไม่อนุมัติรายการ และแจ้งให้ผู้ใช้สร้าง QR ใหม่]

---

## 5. 🚫 Out-of-Scope (สิ่งที่ไม่ทำในฟีเจอร์นี้)

1. ไม่รองรับการชำระเงินด้วยสกุลเงินต่างประเทศ (รองรับเฉพาะ THB)
2. ไม่รองรับการผ่อนชำระ (Installment) ในระยะนี้
3. ไม่รวมการเชื่อมต่อกับระบบ ERP ภายนอก

---

## 🚦 Gate 1: Definition of Ready (DoR) Sign-off Checklist

- [ ] User Story และ Business Value มีความชัดเจน
- [ ] แนบ Link ดีไซน์ / Wireframe ครบถ้วน
- [ ] Acceptance Criteria ครอบคลุมทั้ง Happy Path, Validation Errors และ Edge Cases
- [ ] กำหนด Roles & Permissions ครบถ้วน
- [ ] ระบุ Out-of-Scope ชัดเจน
- [ ] **PM Signature**: ____________________ (Date: __________)
- [ ] **Tech Lead Signature**: ____________________ (Date: __________)
