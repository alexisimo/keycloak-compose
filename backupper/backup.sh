#!/bin/bash
set -euo pipefail
while IFS= read -r -d '' line; do   export "$line"; done < /proc/1/environ
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
WEEKDAY=$(date +"%w")

BACKUP_DIR="/pgsqlbackup"
APP_SRC="/app-data"
APP_DEST="${BACKUP_DIR}/app-data"
DB_FILE="${BACKUP_DIR}/postgres_${WEEKDAY}.dump"

echo "[INFO] === Backup iniciado: $DATE ==="

export PGPASSWORD="${POSTGRES_PASSWORD}"

echo "[INFO] Ejecutando pg_dump..."
pg_dump \
  -h keycloak-db \
  -U "${POSTGRES_USER}" \
  -d "${POSTGRES_DB}" \
  -F c \
  -f "${DB_FILE}"

echo "[INFO] Dump guardado en ${DB_FILE}"

echo "[INFO] Sincronizando blob store..."
mkdir -p "${APP_DEST}"

rsync -a --delete \
  --numeric-ids \
  --inplace \
  "${APP_SRC}/" "${APP_DEST}/"

echo "[INFO] Blob store sincronizado"

echo "[INFO] === Backup completado ==
