# adopted from https://kofi.sexy/blog/zero-downtime-render-disk
FROM caddy
RUN apk add --no-cache bind-tools curl jq bash bash-completion
RUN setcap -r /usr/bin/caddy

# Enable bash completion for environment variables
RUN echo 'source /etc/profile.d/bash_completion.sh 2>/dev/null' >> /root/.bashrc && \
    echo 'complete -v export' >> /root/.bashrc && \
    echo 'complete -v echo' >> /root/.bashrc
ARG DOWNSTREAM_HOST
ARG DOWNSTREAM_PORT
ARG PORT=10000
ARG STICKY_SESSION_HEADER
# not working for docker service
# ARG RENDER_SERVICE_NS
ARG NAMESPACE
COPY Caddyfile /etc/caddy/Caddyfile
