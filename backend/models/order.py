from sqlalchemy import Column, String, Numeric, Integer, Enum, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from db.database import Base

class Order(Base):
    __tablename__ = "Orders"

    order_id     = Column(String(36), primary_key=True)
    patient_id   = Column(String(36), ForeignKey("Patients.patient_id"), nullable=False)
    order_date   = Column(DateTime, server_default=func.now())
    status       = Column(Enum("Pending", "Confirmed", "Shipped", "Delivered", "Cancelled"), nullable=False, default="Pending")
    total_amount = Column(Numeric(10, 2), nullable=False, default=0.00)

    patient = relationship("Patient",   back_populates="orders")
    items   = relationship("OrderItem", back_populates="order")


class OrderItem(Base):
    __tablename__ = "Order_Items"

    item_id      = Column(String(36), primary_key=True)
    order_id     = Column(String(36), ForeignKey("Orders.order_id",       ondelete="CASCADE"), nullable=False)
    inventory_id = Column(String(36), ForeignKey("Inventory.inventory_id"), nullable=False)
    quantity     = Column(Integer, nullable=False, default=1)
    unit_price   = Column(Numeric(10, 2), nullable=False)

    order     = relationship("Order",     back_populates="items")
    inventory = relationship("Inventory", back_populates="order_items")