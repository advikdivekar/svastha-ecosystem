from sqlalchemy import Column, String, Text, Date, Enum, ForeignKey
from sqlalchemy.orm import relationship
from db.database import Base

class Disease(Base):
    __tablename__ = "Diseases"

    disease_id  = Column(String(36), primary_key=True)
    name        = Column(String(150), nullable=False, unique=True)
    category    = Column(String(100), nullable=False)
    description = Column(Text)

    patients    = relationship("PatientDisease",    back_populates="disease")
    medications = relationship("DiseaseMedication", back_populates="disease")


class PatientDisease(Base):
    __tablename__ = "Patient_Diseases"

    patient_id   = Column(String(36), ForeignKey("Patients.patient_id",  ondelete="CASCADE"), primary_key=True)
    disease_id   = Column(String(36), ForeignKey("Diseases.disease_id",  ondelete="CASCADE"), primary_key=True)
    diagnosed_on = Column(Date)
    severity     = Column(Enum("Mild", "Moderate", "Severe"), nullable=False, default="Mild")

    patient  = relationship("Patient", back_populates="diseases")
    disease  = relationship("Disease", back_populates="patients")


class Symptom(Base):
    __tablename__ = "Symptoms"

    symptom_id  = Column(String(36), primary_key=True)
    name        = Column(String(150), nullable=False, unique=True)
    description = Column(Text)

    patients = relationship("PatientSymptom", back_populates="symptom")


class PatientSymptom(Base):
    __tablename__ = "Patient_Symptoms"

    patient_id  = Column(String(36), ForeignKey("Patients.patient_id", ondelete="CASCADE"), primary_key=True)
    symptom_id  = Column(String(36), ForeignKey("Symptoms.symptom_id", ondelete="CASCADE"), primary_key=True)
    reported_on = Column(Date)

    patient = relationship("Patient", back_populates="symptoms")
    symptom = relationship("Symptom", back_populates="patients")