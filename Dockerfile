FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN python -m pip install --upgrade pip \
    && pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-cache --no-install-project

COPY . .

CMD ["sh", "-c", "uv run adk web"]
