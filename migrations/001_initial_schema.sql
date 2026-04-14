-- =============================================================
-- Medical Recommendation & Pharmacy Marketplace System
-- Database: MariaDB  |  PKs: UUID  |  Engine: InnoDB
-- =============================================================

CREATE DATABASE IF NOT EXISTS medical_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE medical_db;

-- =============================================================
-- CORE TABLES
-- =============================================================

CREATE TABLE Hospitals (
    hospital_id     CHAR(36)      NOT NULL DEFAULT (UUID()),
    name            VARCHAR(150)  NOT NULL,
    city            VARCHAR(100)  NOT NULL,
    state           VARCHAR(100)  NOT NULL,
    phone           VARCHAR(20),
    created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_hospitals PRIMARY KEY (hospital_id)
) ENGINE=InnoDB;


CREATE TABLE Doctors (
    doctor_id       CHAR(36)      NOT NULL DEFAULT (UUID()),
    hospital_id     CHAR(36)      NOT NULL,
    name            VARCHAR(150)  NOT NULL,
    specialization  VARCHAR(100)  NOT NULL,
    phone           VARCHAR(20),
    email           VARCHAR(150),
    created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_doctors      PRIMARY KEY (doctor_id),
    CONSTRAINT fk_doc_hospital FOREIGN KEY (hospital_id)
        REFERENCES Hospitals(hospital_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Patients (
    patient_id      CHAR(36)      NOT NULL DEFAULT (UUID()),
    name            VARCHAR(150)  NOT NULL,
    age             TINYINT UNSIGNED NOT NULL,
    gender          ENUM('Male','Female','Other') NOT NULL,
    blood_group     VARCHAR(5),
    phone           VARCHAR(20),
    email           VARCHAR(150),
    address         TEXT,
    created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_patients PRIMARY KEY (patient_id)
) ENGINE=InnoDB;


CREATE TABLE Appointments (
    appointment_id  CHAR(36)      NOT NULL DEFAULT (UUID()),
    patient_id      CHAR(36)      NOT NULL,
    doctor_id       CHAR(36)      NOT NULL,
    hospital_id     CHAR(36)      NOT NULL,
    appointment_date DATE         NOT NULL,
    status          ENUM('Scheduled','Completed','Cancelled') NOT NULL DEFAULT 'Scheduled',
    notes           TEXT,
    created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_appointments      PRIMARY KEY (appointment_id),
    CONSTRAINT fk_appt_patient      FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_appt_doctor       FOREIGN KEY (doctor_id)
        REFERENCES Doctors(doctor_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_appt_hospital     FOREIGN KEY (hospital_id)
        REFERENCES Hospitals(hospital_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =============================================================
-- MEDICAL DATA TABLES
-- =============================================================

CREATE TABLE Diseases (
    disease_id      CHAR(36)      NOT NULL DEFAULT (UUID()),
    name            VARCHAR(150)  NOT NULL,
    category        VARCHAR(100)  NOT NULL,
    description     TEXT,
    CONSTRAINT pk_diseases PRIMARY KEY (disease_id),
    CONSTRAINT uq_disease_name UNIQUE (name)
) ENGINE=InnoDB;


CREATE TABLE Patient_Diseases (
    patient_id      CHAR(36)      NOT NULL,
    disease_id      CHAR(36)      NOT NULL,
    diagnosed_on    DATE,
    severity        ENUM('Mild','Moderate','Severe') NOT NULL DEFAULT 'Mild',
    CONSTRAINT pk_patient_diseases  PRIMARY KEY (patient_id, disease_id),
    CONSTRAINT fk_pd_patient        FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pd_disease        FOREIGN KEY (disease_id)
        REFERENCES Diseases(disease_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Symptoms (
    symptom_id      CHAR(36)      NOT NULL DEFAULT (UUID()),
    name            VARCHAR(150)  NOT NULL,
    description     TEXT,
    CONSTRAINT pk_symptoms      PRIMARY KEY (symptom_id),
    CONSTRAINT uq_symptom_name  UNIQUE (name)
) ENGINE=InnoDB;


CREATE TABLE Patient_Symptoms (
    patient_id      CHAR(36)      NOT NULL,
    symptom_id      CHAR(36)      NOT NULL,
    reported_on     DATE,
    CONSTRAINT pk_patient_symptoms  PRIMARY KEY (patient_id, symptom_id),
    CONSTRAINT fk_ps_patient        FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_ps_symptom        FOREIGN KEY (symptom_id)
        REFERENCES Symptoms(symptom_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =============================================================
-- DATASET TABLES  (linked to patient_id)
-- Columns match the uploaded CSV files exactly
-- =============================================================

CREATE TABLE Heart_Data (
    record_id       CHAR(36)      NOT NULL DEFAULT (UUID()),
    patient_id      CHAR(36)      NOT NULL,
    age             TINYINT UNSIGNED,
    sex             TINYINT(1)    COMMENT '1=Male 0=Female',
    cp              TINYINT       COMMENT 'Chest pain type 0-3',
    trestbps        SMALLINT      COMMENT 'Resting blood pressure (mmHg)',
    chol            SMALLINT      COMMENT 'Serum cholesterol (mg/dl)',
    fbs             TINYINT(1)    COMMENT 'Fasting blood sugar > 120 mg/dl',
    restecg         TINYINT       COMMENT 'Resting ECG results 0-2',
    thalach         SMALLINT      COMMENT 'Max heart rate achieved',
    exang           TINYINT(1)    COMMENT 'Exercise induced angina',
    oldpeak         DECIMAL(4,1)  COMMENT 'ST depression induced by exercise',
    slope           TINYINT       COMMENT 'Slope of peak exercise ST segment',
    ca              TINYINT       COMMENT 'Number of major vessels (0-3)',
    thal            TINYINT       COMMENT '1=normal 2=fixed defect 3=reversable',
    target          TINYINT(1)    COMMENT '1=disease present 0=absent',
    CONSTRAINT pk_heart_data    PRIMARY KEY (record_id),
    CONSTRAINT fk_hd_patient    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Cardio_Data (
    record_id       CHAR(36)      NOT NULL DEFAULT (UUID()),
    patient_id      CHAR(36)      NOT NULL,
    age_days        INT           COMMENT 'Age in days',
    gender          TINYINT(1)    COMMENT '1=Female 2=Male',
    height          SMALLINT      COMMENT 'Height in cm',
    weight          DECIMAL(5,1)  COMMENT 'Weight in kg',
    ap_hi           SMALLINT      COMMENT 'Systolic blood pressure',
    ap_lo           SMALLINT      COMMENT 'Diastolic blood pressure',
    cholesterol     TINYINT       COMMENT '1=normal 2=above normal 3=well above',
    gluc            TINYINT       COMMENT '1=normal 2=above normal 3=well above',
    smoke           TINYINT(1),
    alco            TINYINT(1),
    active          TINYINT(1)    COMMENT 'Physical activity',
    cardio          TINYINT(1)    COMMENT '1=cardiovascular disease present',
    CONSTRAINT pk_cardio_data   PRIMARY KEY (record_id),
    CONSTRAINT fk_cd_patient    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Kidney_Data (
    record_id       CHAR(36)      NOT NULL DEFAULT (UUID()),
    patient_id      CHAR(36)      NOT NULL,
    age             DECIMAL(4,1),
    bp              DECIMAL(5,1)  COMMENT 'Blood pressure',
    sg              DECIMAL(5,3)  COMMENT 'Specific gravity',
    al              DECIMAL(4,1)  COMMENT 'Albumin',
    su              DECIMAL(4,1)  COMMENT 'Sugar',
    rbc             VARCHAR(20)   COMMENT 'Red blood cells: normal/abnormal',
    pc              VARCHAR(20)   COMMENT 'Pus cell: normal/abnormal',
    pcc             VARCHAR(20)   COMMENT 'Pus cell clumps: present/notpresent',
    ba              VARCHAR(20)   COMMENT 'Bacteria: present/notpresent',
    bgr             DECIMAL(6,1)  COMMENT 'Blood glucose random (mgs/dl)',
    bu              DECIMAL(6,1)  COMMENT 'Blood urea (mgs/dl)',
    sc              DECIMAL(5,2)  COMMENT 'Serum creatinine (mgs/dl)',
    sod             DECIMAL(6,1)  COMMENT 'Sodium (mEq/L)',
    pot             DECIMAL(5,1)  COMMENT 'Potassium (mEq/L)',
    hemo            DECIMAL(4,1)  COMMENT 'Hemoglobin (gms)',
    pcv             VARCHAR(10)   COMMENT 'Packed cell volume',
    wc              VARCHAR(10)   COMMENT 'White blood cell count',
    rc              VARCHAR(10)   COMMENT 'Red blood cell count',
    htn             VARCHAR(5)    COMMENT 'Hypertension: yes/no',
    dm              VARCHAR(5)    COMMENT 'Diabetes mellitus: yes/no',
    cad             VARCHAR(5)    COMMENT 'Coronary artery disease: yes/no',
    appet           VARCHAR(10)   COMMENT 'Appetite: good/poor',
    pe              VARCHAR(5)    COMMENT 'Pedal edema: yes/no',
    ane             VARCHAR(5)    COMMENT 'Anemia: yes/no',
    classification  VARCHAR(10)   COMMENT 'ckd / notckd',
    CONSTRAINT pk_kidney_data   PRIMARY KEY (record_id),
    CONSTRAINT fk_kd_patient    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =============================================================
-- ANALYTICS
-- =============================================================

CREATE TABLE Risk_Scores (
    score_id        CHAR(36)      NOT NULL DEFAULT (UUID()),
    patient_id      CHAR(36)      NOT NULL,
    heart_score     DECIMAL(5,2)  COMMENT 'Heart disease risk 0-100',
    cardio_score    DECIMAL(5,2)  COMMENT 'Cardiovascular risk 0-100',
    kidney_score    DECIMAL(5,2)  COMMENT 'Kidney disease risk 0-100',
    overall_score   DECIMAL(5,2)  COMMENT 'Aggregated risk score 0-100',
    calculated_at   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_risk_scores   PRIMARY KEY (score_id),
    CONSTRAINT uq_rs_patient    UNIQUE (patient_id),
    CONSTRAINT fk_rs_patient    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =============================================================
-- MARKETPLACE TABLES
-- =============================================================

CREATE TABLE Medications (
    medication_id   CHAR(36)      NOT NULL DEFAULT (UUID()),
    name            VARCHAR(150)  NOT NULL,
    generic_name    VARCHAR(150),
    category        VARCHAR(100)  NOT NULL,
    dosage_form     VARCHAR(50)   COMMENT 'Tablet / Capsule / Syrup etc.',
    strength        VARCHAR(50)   COMMENT 'e.g. 500mg',
    description     TEXT,
    CONSTRAINT pk_medications       PRIMARY KEY (medication_id),
    CONSTRAINT uq_medication_name   UNIQUE (name)
) ENGINE=InnoDB;


CREATE TABLE Disease_Medications (
    disease_id      CHAR(36)      NOT NULL,
    medication_id   CHAR(36)      NOT NULL,
    notes           TEXT,
    CONSTRAINT pk_disease_medications   PRIMARY KEY (disease_id, medication_id),
    CONSTRAINT fk_dm_disease            FOREIGN KEY (disease_id)
        REFERENCES Diseases(disease_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_dm_medication         FOREIGN KEY (medication_id)
        REFERENCES Medications(medication_id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Vendors (
    vendor_id       CHAR(36)      NOT NULL DEFAULT (UUID()),
    name            VARCHAR(150)  NOT NULL,
    contact_person  VARCHAR(150),
    phone           VARCHAR(20),
    email           VARCHAR(150),
    address         TEXT,
    CONSTRAINT pk_vendors PRIMARY KEY (vendor_id)
) ENGINE=InnoDB;


CREATE TABLE Inventory (
    inventory_id    CHAR(36)      NOT NULL DEFAULT (UUID()),
    medication_id   CHAR(36)      NOT NULL,
    vendor_id       CHAR(36)      NOT NULL,
    price           DECIMAL(10,2) NOT NULL,
    stock           INT UNSIGNED  NOT NULL DEFAULT 0,
    expiry_date     DATE,
    updated_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP
                                  ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT pk_inventory     PRIMARY KEY (inventory_id),
    CONSTRAINT fk_inv_medication FOREIGN KEY (medication_id)
        REFERENCES Medications(medication_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_inv_vendor    FOREIGN KEY (vendor_id)
        REFERENCES Vendors(vendor_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Orders (
    order_id        CHAR(36)      NOT NULL DEFAULT (UUID()),
    patient_id      CHAR(36)      NOT NULL,
    order_date      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status          ENUM('Pending','Confirmed','Shipped','Delivered','Cancelled')
                                  NOT NULL DEFAULT 'Pending',
    total_amount    DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT pk_orders        PRIMARY KEY (order_id),
    CONSTRAINT fk_ord_patient   FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Order_Items (
    item_id         CHAR(36)      NOT NULL DEFAULT (UUID()),
    order_id        CHAR(36)      NOT NULL,
    inventory_id    CHAR(36)      NOT NULL,
    quantity        INT UNSIGNED  NOT NULL DEFAULT 1,
    unit_price      DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_order_items   PRIMARY KEY (item_id),
    CONSTRAINT fk_oi_order      FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_oi_inventory  FOREIGN KEY (inventory_id)
        REFERENCES Inventory(inventory_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =============================================================
-- END OF SCHEMA  (18 tables total)
-- =============================================================