from __future__ import annotations

from pydantic import BaseModel, ConfigDict, Field


class AnomalyFeatures(BaseModel):
    model_config = ConfigDict(
        extra="forbid",
    )

    age: float = Field(ge=18, le=100)
    height_cm: float = Field(gt=120, le=220)
    weight_kg: float = Field(gt=30, le=250)
    bmi: float = Field(ge=10, le=70)

    water_glasses: float = Field(ge=0, le=30)
    exercise_minutes: float = Field(ge=0, le=600)
    sleep_hours: float = Field(ge=0, le=24)
    healthy_meals_count: float = Field(ge=0, le=5)
    meditation_minutes: float = Field(ge=0, le=300)

    pain: float = Field(ge=0, le=10)
    temperature_c: float = Field(ge=30, le=45)

    systolic_mmhg: float = Field(ge=60, le=250)
    diastolic_mmhg: float = Field(ge=30, le=160)

    glucose_mg_dl: float = Field(ge=30, le=600)
    heart_rate_bpm: float = Field(ge=30, le=250)

    stress_level: float = Field(ge=1, le=10)
    energy_level: float = Field(ge=1, le=10)
    sleep_quality: float = Field(ge=1, le=10)

    mood: str = Field(
        min_length=1,
        max_length=30,
    )


class AnomalyRequest(BaseModel):
    model_config = ConfigDict(
        extra="forbid",
    )

    request_id: str
    user_id: str
    features: AnomalyFeatures


class AnomalyResult(BaseModel):
    is_anomaly: bool
    raw_prediction: int
    decision_score: float
    anomaly_score: float
    interpretation: str


class AnomalyResponse(BaseModel):
    request_id: str
    user_id: str
    result: AnomalyResult
    model_version: str
    disclaimer: str