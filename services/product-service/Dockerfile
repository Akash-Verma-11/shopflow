FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

FROM python:3.11-slim AS production
RUN useradd --create-home appuser
WORKDIR /app
COPY --from=builder /install /usr/local
COPY . .
USER appuser
EXPOSE 5001
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5001/health')" || exit 1
CMD ["gunicorn", "--bind", "0.0.0.0:5001", "--workers", "2", "app:app"]
