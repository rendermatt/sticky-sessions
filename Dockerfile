# adopted from https://kofi.sexy/blog/zero-downtime-render-disk
FROM caddy
RUN setcap -r /usr/bin/caddy
ARG DOWNSTREAM_HOST
ARG DOWNSTREAM_PORT
ARG PORT=10000
COPY Caddyfile /etc/caddy/Caddyfile
