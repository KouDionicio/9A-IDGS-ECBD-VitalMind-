from __future__ import annotations

from fastapi import (
    APIRouter,
    HTTPException,
    status,
)

from app.schemas.anomaly import (
    AnomalyRequest,
    AnomalyResponse,
)
from app.services.anomaly_service import (
    predict_anomaly,
)


router = APIRouter(
    prefix="/api/v1",
    tags=["anomaly-detection"],
)


@router.post(
    "/anomaly-detection",
    response_model=AnomalyResponse,
    status_code=status.HTTP_200_OK,
)
def anomaly_detection(
    request: AnomalyRequest,
) -> AnomalyResponse:

    try:

        return predict_anomaly(
            request
        )

    except RuntimeError as error:

        raise HTTPException(
            status_code=
                status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail={
                "request_id":
                    request.request_id,

                "status":
                    "internal_error",

                "message":
                    "No fue posible ejecutar "
                    "la detección de anomalías.",
            },
        ) from error