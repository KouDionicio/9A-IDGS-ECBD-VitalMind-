from __future__ import annotations

from fastapi import (
    APIRouter,
    HTTPException,
    status,
)

from app.schemas.clustering import (
    WellbeingClusterRequest,
    WellbeingClusterResponse,
)
from app.services.clustering_service import (
    predict_wellbeing_cluster,
)


router = APIRouter(
    prefix="/api/v1",
    tags=["clustering"],
)


@router.post(
    "/wellbeing-cluster",
    response_model=WellbeingClusterResponse,
    status_code=status.HTTP_200_OK,
)
def wellbeing_cluster(
    request: WellbeingClusterRequest,
) -> WellbeingClusterResponse:

    try:

        return predict_wellbeing_cluster(
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
                    "No fue posible ejecutar la segmentación.",
            },
        ) from error