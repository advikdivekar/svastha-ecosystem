from fastapi import APIRouter, Depends
from sqlalchemy import text
from sqlalchemy.orm import Session
from db.database import get_db
from db import queries

router = APIRouter()


@router.get("/")
def list_diseases(db: Session = Depends(get_db)):
    result = queries.get_disease_medication_map(db)
    return {"diseases": [dict(r) for r in result]}


@router.get("/patient-count")
def disease_patient_count(db: Session = Depends(get_db)):
    result = queries.get_patient_count_per_disease(db)
    return {"diseases": [dict(r) for r in result]}


# ── GET ALL SYMPTOMS (for dropdown) ─────────────────────────
@router.get("/symptoms")
def list_symptoms(db: Session = Depends(get_db)):
    result = db.execute(text("SELECT symptom_id, name FROM Symptoms ORDER BY name"))
    return {"symptoms": [dict(r) for r in result.mappings().all()]}