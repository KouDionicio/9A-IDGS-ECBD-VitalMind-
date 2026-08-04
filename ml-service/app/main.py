"""
Aplicación principal del microservicio ML de VitalMind AI.
"""

from __future__ import annotations

from collections.abc import AsyncIterator
from contextlib import asynccontextmanager

from fastapi import FastAPI
from fastapi.exceptions import (
    RequestValidationError,
)

from app.core.exception_handlers import (
    request_validation_exception_handler,
)
from app.api.system import router as system_router
from app.core.config import (
    APP_NAME,
    APP_VERSION,
)
from app.services.model_loader import (
    load_all_artifacts,
    unload_all_artifacts,
)
from app.api.analysis import(
    router as analysis_router,
) 

@asynccontextmanager
async def lifespan(
    app: FastAPI,
) -> AsyncIterator[None]:
    """
    Carga los modelos al iniciar y libera referencias
    al detener el servicio.
    """
    del app

    load_all_artifacts()

    yield

    unload_all_artifacts()


app = FastAPI(
    title=APP_NAME,
    version=APP_VERSION,
    description=(
        "Microservicio de inferencia de riesgo y bienestar "
        "para VitalMind AI. Los modelos utilizan datos "
        "sintéticos y no representan diagnósticos clínicos."
    ),
    lifespan=lifespan,
)

app.add_exception_handler(
    RequestValidationError,
    request_validation_exception_handler,
)

app.include_router(
    system_router
)



app.include_router(
    analysis_router
)