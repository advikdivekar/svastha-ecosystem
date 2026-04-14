from sqlalchemy import Column, String, Integer, Enum, DateTime, Text
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from db.database import Base

class Patient(Base):
    __tablename__ = "Patients"

    patient_id  = Column(String(36), primary_key=True)
    name        = Column(String(150), nullable=False)
    age         = Column(Integer, nullable=False)
    gender      = Column(Enum("Male", "Female", "Other"), nullable=False)
    blood_group = Column(String(5))
    phone       = Column(String(20))
    email       = Column(String(150))
    address     = Column(Text)
    created_at  = Column(DateTime, server_default=func.now())

    # relationships
    appointments     = relationship("Appointment",    back_populates="patient")
    diseases         = relationship("PatientDisease", back_populates="patient")
    symptoms         = relationship("PatientSymptom", back_populates="patient")
    heart_data       = relationship("HeartData",      back_populates="patient")
    cardio_data      = relationship("CardioData",     back_populates="patient")
    kidney_data      = relationship("KidneyData",     back_populates="patient")
    risk_score       = relationship("RiskScore",      back_populates="patient", uselist=False)
    orders           = relationship("Order",          back_populates="patient")