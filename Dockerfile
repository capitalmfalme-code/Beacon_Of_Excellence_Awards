# Use official Python image
FROM python:3.11-slim

# Prevent Python from writing .pyc files and buffering logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system packages for psycopg & Pillow
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project files
COPY . /app/

# Collect static files at build time (safe — reads from settings only)
RUN python manage.py collectstatic --noinput || true

# DO NOT hardcode PORT — Railway injects $PORT at runtime.

# Expose a default (informational only; Railway ignores this)
EXPOSE 8000

# Entrypoint: migrate, then run gunicorn on Railway's $PORT
CMD ["sh", "-c", "python manage.py migrate --noinput && gunicorn beacon_awards.wsgi:application --bind 0.0.0.0:${PORT:-8000} --workers 2 --timeout 120 --access-logfile - --error-logfile -"]