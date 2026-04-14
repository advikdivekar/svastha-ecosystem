from pydantic import BaseModel
from typing import Optional
from datetime import date
from enum import Enum

class StatusEnum(str, Enum):
    scheduled  = "Scheduled"
    completed  = "Completed"
    cancelled  = "Cancelled"

class AppointmentCreate(BaseModel):
    patient_id:       str
    doctor_id:        str
    hospital_id:      str
    appointment_date: date
    notes:            Optional[str] = None

class AppointmentUpdate(BaseModel):
    appointment_date: Optional[date]       = None
    status:           Optional[StatusEnum] = None
    notes:            Optional[str]        = None