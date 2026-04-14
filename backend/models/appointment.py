from sqlalchemy import Column, String, Date, Enum, Text, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from db.database import Base

class Hospital(Base):
    __tablename__ = "Hospitals"

    hospital_id = Column(String(36), primary_key=True)
    name        = Column(String(150), nullable=False)
    city        = Column(String(100), nullable=False)
    state       = Column(String(100), nullable=False)
    phone       = Column(String(20))
    created_at  = Column(DateTime, server_default=func.now())

    doctors      = relationship("Doctor",      back_populates="hospital")
    appointments = relationship("Appointment", back_populates="hospital")


class Doctor(Base):
    __tablename__ = "Doctors"

    doctor_id       = Column(String(36), primary_key=True)
    hospital_id     = Column(String(36), ForeignKey("Hospitals.hospital_id"), nullable=False)
    name            = Column(String(150), nullable=False)
    specialization  = Column(String(100), nullable=False)
    phone           = Column(String(20))
    email           = Column(String(150))
    created_at      = Column(DateTime, server_default=func.now())

    hospital     = relationship("Hospital",    back_populates="doctors")
    appointments = relationship("Appointment", back_populates="doctor")


class Appointment(Base):
    __tablename__ = "Appointments"

    appointment_id   = Column(String(36), primary_key=True)
    patient_id       = Column(String(36), ForeignKey("Patients.patient_id",  ondelete="CASCADE"), nullable=False)
    doctor_id        = Column(String(36), ForeignKey("Doctors.doctor_id"),   nullable=False)
    hospital_id      = Column(String(36), ForeignKey("Hospitals.hospital_id"), nullable=False)
    appointment_date = Column(Date, nullable=False)
    status           = Column(Enum("Scheduled", "Completed", "Cancelled"), nullable=False, default="Scheduled")
    notes            = Column(Text)
    created_at       = Column(DateTime, server_default=func.now())

    patient  = relationship("Patient",  back_populates="appointments")
    doctor   = relationship("Doctor",   back_populates="appointments")
    hospital = relationship("Hospital", back_populates="appointments")