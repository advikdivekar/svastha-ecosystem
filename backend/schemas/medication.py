from pydantic import BaseModel
from typing import Optional

class MedicationCreate(BaseModel):
    name:         str
    generic_name: Optional[str] = None
    category:     str
    dosage_form:  Optional[str] = None
    strength:     Optional[str] = None
    description:  Optional[str] = None

class MedicationUpdate(BaseModel):
    name:         Optional[str] = None
    generic_name: Optional[str] = None
    category:     Optional[str] = None
    dosage_form:  Optional[str] = None
    strength:     Optional[str] = None
    description:  Optional[str] = None