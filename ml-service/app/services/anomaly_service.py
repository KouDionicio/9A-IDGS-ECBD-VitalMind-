from __future__ import annotations

import pandas as pd

from app.core.config import (
    ANOMALY_MODEL_VERSION,
    DISCLAIMER,
)
from app.schemas.anomaly import (
    AnomalyRequest,
    AnomalyResponse,
    AnomalyResult,
)
from app.services.model_loader import (
    model_artifacts,
)


ANOMALY_FEATURES = [
    "age",
    "height_cm",
    "weight_kg",
    "bmi",
    "water_glasses",
    "exercise_minutes",
    "sleep_hours",
    "healthy_meals_count",
    "meditation_minutes",
    "pain",
    "temperature_c",
    "systolic_mmhg",
    "diastolic_mmhg",
    "glucose_mg_dl",
    "heart_rate_bpm",
    "stress_level",
    "energy_level",
    "sleep_quality",
    "mood",
]


def predict_anomaly(
    request: AnomalyRequest,
) -> AnomalyResponse:

    detector =        model_artifacts.anomaly_detector

    if detector is None:
        raise RuntimeError(
            "El detector de anomalías "
            "no está disponible."
        )

    values =        request.features.model_dump()

    dataframe =        pd.DataFrame(
            [values],
            columns=ANOMALY_FEATURES,
        )

    raw_prediction =        int(
            detector.predict(
                dataframe
            )[0]
        )

    decision_score =        float(
            detector.decision_function(
                dataframe
            )[0]
        )

    # Isolation Forest:
    #  1 = normal
    # -1 = anomalía
    is_anomaly =        raw_prediction == -1

    # En tus reportes de entrenamiento,
    # anomaly_score = -decision_score
    anomaly_score =        -decision_score

    interpretation =        (
            "Registro atípico detectado; "
            "requiere revisión contextual."
            if is_anomaly
            else
            "Registro dentro del patrón estadístico esperado."
        )

    return AnomalyResponse(
        request_id=
            request.request_id,

        user_id=
            request.user_id,

        result=
            AnomalyResult(
                is_anomaly=
                    is_anomaly,

                raw_prediction=
                    raw_prediction,

                decision_score=
                    round(
                        decision_score,
                        6,
                    ),

                anomaly_score=
                    round(
                        anomaly_score,
                        6,
                    ),

                interpretation=
                    interpretation,
            ),

        model_version=
            ANOMALY_MODEL_VERSION,

        disclaimer=
            DISCLAIMER,
    )