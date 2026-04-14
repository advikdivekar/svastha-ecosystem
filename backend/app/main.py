# backend/app/main.py
from fastapi import FastAPI
from app.db.session import engine
from sqlmodel import SQLModel

# Import the models so SQLModel knows about them
from app.models.clinical import Patient, BodyComposition, LifestyleLog, VitalReading

app = FastAPI(title="Svastha API")

@app.on_event("startup")
def on_startup():
    # This ensures the tables exist in the database.
    # Since you already created them in Supabase, this is just a safety check.
    SQLModel.metadata.create_all(engine)

@app.get("/")
def read_root():
    return {"message": "Welcome to the Svastha Ecosystem API"}