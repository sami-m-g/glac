import functools

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    port: int = 8000
    host: str = "127.0.0.1"

    model: str = "gemini-2.5-flash"


@functools.cache
def get_settings() -> Settings:
    """Get the application settings."""
    return Settings()
