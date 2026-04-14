from sqlalchemy import Column, String, Numeric, Integer, Date, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from db.database import Base

class Inventory(Base):
    __tablename__ = "Inventory"

    inventory_id  = Column(String(36), primary_key=True)
    medication_id = Column(String(36), ForeignKey("Medications.medication_id"), nullable=False)
    vendor_id     = Column(String(36), ForeignKey("Vendors.vendor_id"),         nullable=False)
    price         = Column(Numeric(10, 2), nullable=False)
    stock         = Column(Integer, nullable=False, default=0)
    expiry_date   = Column(Date)
    updated_at    = Column(DateTime, server_default=func.now(), onupdate=func.now())

    medication  = relationship("Medication", back_populates="inventory")
    vendor      = relationship("Vendor",     back_populates="inventory")
    order_items = relationship("OrderItem",  back_populates="inventory")