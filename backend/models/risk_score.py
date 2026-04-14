from sqlalchemy import Column, String, Numeric, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from db.database import Base

class RiskScore(Base):
    __tablename__ = "Risk_Scores"

    score_id      = Column(String(36), primary_key=True)
    patient_id    = Column(String(36), ForeignKey("Patients.patient_id", ondelete="CASCADE"), nullable=False, unique=True)
    heart_score   = Column(Numeric(5, 2))
    cardio_score  = Column(Numeric(5, 2))
    kidney_score  = Column(Numeric(5, 2))
    overall_score = Column(Numeric(5, 2))
    calculated_at = Column(DateTime, server_default=func.now())

    patient = relationship("Patient", back_populates="risk_score")