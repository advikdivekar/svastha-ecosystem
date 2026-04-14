from pydantic import BaseModel, EmailStr
from typing import Optional
from enum import Enum

class GenderEnum(str, Enum):
    male   = "Male"
    female = "Female"
    other  = "Other"

class PatientCreate(BaseModel):
    name:        str
    age:         int
    gender:      GenderEnum
    blood_group: Optional[str] = None
    phone:       Optional[str] = None
    email:       Optional[str] = None
    address:     Optional[str] = None

class PatientUpdate(BaseModel):
    name:        Optional[str]   = None
    age:         Optional[int]   = None
    gender:      Optional[GenderEnum] = None
    blood_group: Optional[str]   = None
    phone:       Optional[str]   = None
    email:       Optional[str]   = None
    address:     Optional[str]   = None