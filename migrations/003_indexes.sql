-- =============================================================
-- Medical Recommendation & Pharmacy Marketplace System
-- Purpose: Query performance optimization
-- =============================================================

USE medical_db;

-- ─── PATIENTS ───────────────────────────────────────────────
-- Frequently filtered by name and age in search queries
CREATE INDEX idx_patients_name    ON Patients(name);
CREATE INDEX idx_patients_age     ON Patients(age);
CREATE INDEX idx_patients_gender  ON Patients(gender);

-- ─── APPOINTMENTS ───────────────────────────────────────────
-- Joined often with Patients and Doctors; filtered by date/status
CREATE INDEX idx_appt_patient     ON Appointments(patient_id);
CREATE INDEX idx_appt_doctor      ON Appointments(doctor_id);
CREATE INDEX idx_appt_date        ON Appointments(appointment_date);
CREATE INDEX idx_appt_status      ON Appointments(status);

-- ─── PATIENT_DISEASES ───────────────────────────────────────
-- Core join table — both sides need indexes
CREATE INDEX idx_pd_disease       ON Patient_Diseases(disease_id);
-- patient_id is part of PK, already indexed

-- ─── PATIENT_SYMPTOMS ───────────────────────────────────────
CREATE INDEX idx_ps_symptom       ON Patient_Symptoms(symptom_id);
-- patient_id is part of PK, already indexed

-- ─── HEART_DATA ─────────────────────────────────────────────
-- Queried by patient and filtered by target (disease present)
CREATE INDEX idx_hd_patient       ON Heart_Data(patient_id);
CREATE INDEX idx_hd_target        ON Heart_Data(target);

-- ─── CARDIO_DATA ────────────────────────────────────────────
CREATE INDEX idx_cd_patient       ON Cardio_Data(patient_id);
CREATE INDEX idx_cd_cardio        ON Cardio_Data(cardio);

-- ─── KIDNEY_DATA ────────────────────────────────────────────
CREATE INDEX idx_kd_patient       ON Kidney_Data(patient_id);
CREATE INDEX idx_kd_class         ON Kidney_Data(classification);

-- ─── RISK_SCORES ────────────────────────────────────────────
-- Filtered by overall_score in high-risk patient queries
CREATE INDEX idx_rs_overall       ON Risk_Scores(overall_score);
-- patient_id already has UNIQUE index from schema

-- ─── MEDICATIONS ────────────────────────────────────────────
CREATE INDEX idx_med_category     ON Medications(category);

-- ─── INVENTORY ──────────────────────────────────────────────
-- Queried by vendor and filtered by stock level
CREATE INDEX idx_inv_medication   ON Inventory(medication_id);
CREATE INDEX idx_inv_vendor       ON Inventory(vendor_id);
CREATE INDEX idx_inv_stock        ON Inventory(stock);

-- ─── ORDERS ─────────────────────────────────────────────────
CREATE INDEX idx_ord_patient      ON Orders(patient_id);
CREATE INDEX idx_ord_status       ON Orders(status);
CREATE INDEX idx_ord_date         ON Orders(order_date);

-- ─── ORDER_ITEMS ────────────────────────────────────────────
CREATE INDEX idx_oi_order         ON Order_Items(order_id);
CREATE INDEX idx_oi_inventory     ON Order_Items(inventory_id);

-- ─── DISEASE_MEDICATIONS ────────────────────────────────────
CREATE INDEX idx_dm_medication    ON Disease_Medications(medication_id);
-- disease_id is part of PK, already indexed

-- ─── DOCTORS ────────────────────────────────────────────────
CREATE INDEX idx_doc_hospital     ON Doctors(hospital_id);
CREATE INDEX idx_doc_spec         ON Doctors(specialization);

-- =============================================================
-- Verify all indexes on medical_db
-- =============================================================
SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE
FROM
    INFORMATION_SCHEMA.STATISTICS
WHERE
    TABLE_SCHEMA = 'medical_db'
    AND INDEX_NAME != 'PRIMARY'
ORDER BY
    TABLE_NAME, INDEX_NAME;