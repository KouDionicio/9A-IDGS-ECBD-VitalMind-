from __future__ import annotations

import numpy as np
import pandas as pd

from app.core.config import (
    DISCLAIMER,
    WELLBEING_CLUSTERING_MODEL_VERSION,
)
from app.schemas.clustering import (
    WellbeingClusterRequest,
    WellbeingClusterResponse,
    WellbeingClusterResult,
)
from app.services.model_loader import (
    model_artifacts,
)


CLUSTER_FEATURES = [
    "age",
    "height_cm",
    "weight_kg",
    "bmi",
    "water_glasses_mean",
    "exercise_minutes_mean",
    "sleep_hours_mean",
    "healthy_meals_count_mean",
    "meditation_minutes_mean",
    "pain_mean",
    "temperature_c_mean",
    "systolic_mmhg_mean",
    "diastolic_mmhg_mean",
    "glucose_mg_dl_mean",
    "heart_rate_bpm_mean",
    "stress_level_mean",
    "energy_level_mean",
    "sleep_quality_mean",
    "mood_score_mean",
    "records_count",
]


def interpret_cluster(
    cluster_id: int,
) -> str:

    profiles = {
        0: "hábitos que requieren mayor atención",
        1: "hábitos relativamente equilibrados",
    }

    return profiles.get(
        cluster_id,
        f"perfil {cluster_id}",
    )


def predict_wellbeing_cluster(
    request: WellbeingClusterRequest,
) -> WellbeingClusterResponse:

    clusterer = model_artifacts.wellbeing_clusterer

    if clusterer is None:
        raise RuntimeError(
            "El modelo de clustering "
            "no está disponible."
        )

    feature_values = request.features.model_dump()

    dataframe = pd.DataFrame(
        [feature_values],
        columns=CLUSTER_FEATURES,
    )

    prediction = clusterer.predict(dataframe)

    cluster_id = int(prediction[0])

    distances = clusterer.transform(dataframe)[0]

    distance_to_centroid = float(distances[cluster_id])

    return WellbeingClusterResponse(
        request_id=request.request_id,
        user_id=request.user_id,
        result=WellbeingClusterResult(
            cluster_id=cluster_id,
            profile=interpret_cluster(
                cluster_id
            ),
            distance_to_centroid=
                round(
                    distance_to_centroid,
                    4,
                ),
        ),
        model_version=
            WELLBEING_CLUSTERING_MODEL_VERSION,
        disclaimer=DISCLAIMER,
    )