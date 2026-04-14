from sqlalchemy import Column, String, Integer, Numeric, SmallInteger, ForeignKey
from sqlalchemy.orm import relationship
from db.database import Base

class HeartData(Base):
    __tablename__ = "Heart_Data"

    record_id  = Column(String(36), primary_key=True)
    patient_id = Column(String(36), ForeignKey("Patients.patient_id", ondelete="CASCADE"), nullable=False)
    age        = Column(Integer)
    sex        = Column(Integer)
    cp         = Column(Integer)
    trestbps   = Column(SmallInteger)
    chol       = Column(SmallInteger)
    fbs        = Column(Integer)
    restecg    = Column(Integer)
    thalach    = Column(SmallInteger)
    exang      = Column(Integer)
    oldpeak    = Column(Numeric(4, 1))
    slope      = Column(Integer)
    ca         = Column(Integer)
    thal       = Column(Integer)
    target     = Column(Integer)

    patient = relationship("Patient", back_populates="heart_data")


class CardioData(Base):
    __tablename__ = "Cardio_Data"

    record_id   = Column(String(36), primary_key=True)
    patient_id  = Column(String(36), ForeignKey("Patients.patient_id", ondelete="CASCADE"), nullable=False)
    age_days    = Column(Integer)
    gender      = Column(Integer)
    height      = Column(SmallInteger)
    weight      = Column(Numeric(5, 1))
    ap_hi       = Column(SmallInteger)
    ap_lo       = Column(SmallInteger)
    cholesterol = Column(Integer)
    gluc        = Column(Integer)
    smoke       = Column(Integer)
    alco        = Column(Integer)
    active      = Column(Integer)
    cardio      = Column(Integer)

    patient = relationship("Patient", back_populates="cardio_data")


class KidneyData(Base):
    __tablename__ = "Kidney_Data"

    record_id      = Column(String(36), primary_key=True)
    patient_id     = Column(String(36), ForeignKey("Patients.patient_id", ondelete="CASCADE"), nullable=False)
    age            = Column(Numeric(4, 1))
    bp             = Column(Numeric(5, 1))
    sg             = Column(Numeric(5, 3))
    al             = Column(Numeric(4, 1))
    su             = Column(Numeric(4, 1))
    rbc            = Column(String(20))
    pc             = Column(String(20))
    pcc            = Column(String(20))
    ba             = Column(String(20))
    bgr            = Column(Numeric(6, 1))
    bu             = Column(Numeric(6, 1))
    sc             = Column(Numeric(5, 2))
    sod            = Column(Numeric(6, 1))
    pot            = Column(Numeric(5, 1))
    hemo           = Column(Numeric(4, 1))
    pcv            = Column(String(10))
    wc             = Column(String(10))
    rc             = Column(String(10))
    htn            = Column(String(5))
    dm             = Column(String(5))
    cad            = Column(String(5))
    appet          = Column(String(10))
    pe             = Column(String(5))
    ane            = Column(String(5))
    classification = Column(String(10))

    patient = relationship("Patient", back_populates="kidney_data")