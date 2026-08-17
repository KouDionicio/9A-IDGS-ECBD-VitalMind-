from __future__ import annotations

from pydantic import BaseModel, ConfigDict, Field


class WellbeingClusterFeatures(BaseModel):
    model_config = ConfigDict(
        extra="forbid",
    )

    age: float = Field(
        ge=18,
        le=100,
    )

    height_cm: float = Field(
        gt=120,
        le=220,
    )

    weight_kg: float = Field(
        gt=30,
        le=250,
    )

    bmi: float = Field(
        ge=10,
        le=70,
    )

    water_glasses_mean: float = Field(
        ge=0,
        le=30,
    )

    exercise_minutes_mean: float = Field(
        ge=0,
        le=600,
    )

    sleep_hours_mean: float = Field(
        ge=0,
        le=24,
    )

    healthy_meals_count_mean: float = Field(
        ge=0,
        le=5,
    )

    meditation_minutes_mean: float = Field(
        ge=0,
        le=300,
    )

    pain_mean: float = Field(
        ge=0,
        le=10,
    )

    temperature_c_mean: float = Field(
        ge=30,
        le=45,
    )

    systolic_mmhg_mean: float = Field(
        ge=60,
        le=250,
    )

    diastolic_mmhg_mean: float = Field(
        ge=30,
        le=160,
    )

    glucose_mg_dl_mean: float = Field(
        ge=30,
        le=600,
    )

    heart_rate_bpm_mean: float = Field(
        ge=30,
        le=250,
    )

    stress_level_mean: float = Field(
        ge=1,
        le=10,
    )

    energy_level_mean: float = Field(
        ge=1,
        le=10,
    )

    sleep_quality_mean: float = Field(
        ge=1,
        le=10,
    )

    mood_score_mean: float = Field(
        ge=1,
        le=5,
    )

    records_count: int = Field(
        ge=1,
    )


class WellbeingClusterRequest(BaseModel):
    model_config = ConfigDict(
        extra="forbid",
    )

    request_id: str = Field(
        min_length=1,
        max_length=100,
    )

    user_id: str = Field(
        min_length=1,
        max_length=100,
    )

    features: WellbeingClusterFeatures


class WellbeingClusterResult(BaseModel):
    cluster_id: int
    profile: str
    distance_to_centroid: float


class WellbeingClusterResponse(BaseModel):
    request_id: str
    user_id: str
    result: WellbeingClusterResult
    model_version: str
    disclaimer: str