import functools

from pydantic import SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    google_genai_use_vertexai: int = 1
    google_cloud_project: SecretStr
    google_cloud_location: str = "us-central1"

    port: int = 8000
    host: str = "127.0.0.1"

    model: str = "gemini-2.5-flash"


@functools.cache
def get_settings() -> Settings:
    """Get the application settings."""
    return Settings()  # type: ignore[call-arg]
