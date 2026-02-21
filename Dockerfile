FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir .

CMD ["sh", "-c", "adk web --host 0.0.0.0 --port ${PORT}"]
