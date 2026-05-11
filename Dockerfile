# syntax=docker/dockerfile:1.7
FROM nginxinc/nginx-unprivileged:1.27-alpine AS runtime

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY public/ /usr/share/nginx/html/

LABEL org.opencontainers.image.source="https://github.com/hexiejexie/pricing-advisor-web" \
      org.opencontainers.image.description="Static dashboard for the n8n competitive pricing workflow" \
      org.opencontainers.image.licenses="MIT"

EXPOSE 8080

HEALTHCHECK --interval=60s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://127.0.0.1:8080/healthz >/dev/null || exit 1