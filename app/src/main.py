from fastapi import FastAPI
import os

app = FastAPI()

VERSION = os.getenv("APP_VERSION", "1.0.0")
ENVIRONMENT = os.getenv("ENVIRONMENT", "blue")

@app.get("/")
def read_root():
    return {
        "message": "DevOps Security Pipeline Demo",
        "version": VERSION,
        "environment": ENVIRONMENT
    }

@app.get("/health")
def health_check():
    return {"status": "healthy", "environment": ENVIRONMENT}
