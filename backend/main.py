from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from db.database import test_connection
from api import patients, diseases, medications, marketplace, recommendations, appointments

app = FastAPI(
    title="Medical Recommendation & Pharmacy Marketplace",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
def startup():
    test_connection()

@app.get("/")
def root():
    return {"status": "ok", "project": "Medical Recommendation System"}

@app.get("/health")
def health():
    ok = test_connection()
    return {"db": "connected" if ok else "error"}

app.include_router(patients.router,        prefix="/patients",        tags=["Patients"])
app.include_router(diseases.router,        prefix="/diseases",        tags=["Diseases"])
app.include_router(medications.router,     prefix="/medications",     tags=["Medications"])
app.include_router(marketplace.router,     prefix="/marketplace",     tags=["Marketplace"])
app.include_router(recommendations.router, prefix="/recommendations", tags=["Recommendations"])
app.include_router(appointments.router,    prefix="/appointments",    tags=["Appointments"])