#!/bin/bash
set -e

if [ -z "${CRON_LINE:-}" ]; then
  echo "[ERROR] Variable CRON_LINE no definida"
  exit 1
fi

echo "$CRON_LINE /usr/local/bin/backup.sh" > /tmp/crontab

echo "[INFO] Cron configurado con Supercronic: $CRON_LINE"
echo "[INFO] Lanzando planificador de tareas como UID 200..."

exec supercronic /tmp/crontab
