from pydantic import BaseModel
from typing import Optional, List
from enum import Enum

class OrderStatusEnum(str, Enum):
    pending   = "Pending"
    confirmed = "Confirmed"
    shipped   = "Shipped"
    delivered = "Delivered"
    cancelled = "Cancelled"

class OrderItemIn(BaseModel):
    inventory_id: str
    quantity:     int

class OrderCreate(BaseModel):
    patient_id: str
    items:      List[OrderItemIn]

class OrderStatusUpdate(BaseModel):
    status: OrderStatusEnum