from sqlalchemy import Column, String, Text
from sqlalchemy.orm import relationship
from db.database import Base

class Vendor(Base):
    __tablename__ = "Vendors"

    vendor_id      = Column(String(36), primary_key=True)
    name           = Column(String(150), nullable=False)
    contact_person = Column(String(150))
    phone          = Column(String(20))
    email          = Column(String(150))
    address        = Column(Text)

    inventory = relationship("Inventory", back_populates="vendor")