# adopted from https://kofi.sexy/blog/zero-downtime-render-disk
FROM caddy
RUN apk add --no-cache bind-tools curl jq
RUN setcap -r /usr/bin/caddy
ARG DOWNSTREAM_HOST
ARG DOWNSTREAM_PORT
ARG PORT=10000
ARG STICKY_SESSION_HEADER
# not working for docker service
# ARG RENDER_SERVICE_NS
ARG NAMESPACE
COPY Caddyfile /etc/caddy/Caddyfile
