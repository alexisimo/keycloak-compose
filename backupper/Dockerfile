FROM postgres:16

ENV DEBIAN_FRONTEND=noninteractive
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.46/supercronic-linux-amd64
ENV SUPERCRONIC_SHA1SUM=5bcefed628e32adc08e32634db2d10e9230dbca0 
ENV SUPERCRONIC=supercronic-linux-amd64

RUN apt-get update && \

    apt-get install -y \
        curl \
        rsync \
        bash \
        tzdata && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSLO "$SUPERCRONIC_URL" \

 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

COPY backup.sh /usr/local/bin/backup.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /usr/local/bin/backup.sh /entrypoint.sh
RUN adduser --uid 200 --disabled-password --gecos "" backupuser
RUN mkdir -p /var/run/cron /var/spool/cron/crontabs /var/log && \

    chown -R backupuser:backupuser /var/run /var/spool/cron /var/log


ENTRYPOINT ["/entrypoint.sh"]


