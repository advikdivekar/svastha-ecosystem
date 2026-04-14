from pydantic import BaseModel
from typing import Optional
from datetime import date

class InventoryUpdate(BaseModel):
    price:       Optional[float] = None
    stock:       Optional[int]   = None
    expiry_date: Optional[date]  = None