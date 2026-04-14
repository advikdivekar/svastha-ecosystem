from sqlalchemy import Column, String, Text, ForeignKey
from sqlalchemy.orm import relationship
from db.database import Base

class Medication(Base):
    __tablename__ = "Medications"

    medication_id = Column(String(36), primary_key=True)
    name          = Column(String(150), nullable=False, unique=True)
    generic_name  = Column(String(150))
    category      = Column(String(100), nullable=False)
    dosage_form   = Column(String(50))
    strength      = Column(String(50))
    description   = Column(Text)

    diseases   = relationship("DiseaseMedication", back_populates="medication")
    inventory  = relationship("Inventory",         back_populates="medication")


class DiseaseMedication(Base):
    __tablename__ = "Disease_Medications"

    disease_id    = Column(String(36), ForeignKey("Diseases.disease_id",      ondelete="CASCADE"), primary_key=True)
    medication_id = Column(String(36), ForeignKey("Medications.medication_id", ondelete="CASCADE"), primary_key=True)
    notes         = Column(Text)

    disease    = relationship("Disease",    back_populates="medications")
    medication = relationship("Medication", back_populates="diseases")