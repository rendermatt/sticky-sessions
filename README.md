# Sticky Sessions Caddy Proxy

A Caddy reverse proxy implementation with sticky sessions using dynamic SRV-based service discovery.

## Test it out

Run the following from the web shell of your caddy service for a curl command to run locally

```bash
echo "curl -i -H '${STICKY_SESSION_HEADER}: session-123' https://${RENDER_EXTERNAL_HOSTNAME}/"
```

## Troubleshooting

Run all of the following from the web shell of your caddy service

### Caddy Admin API to check the status of the proxy

```bash
# Get current configuration
curl http://localhost:2019/config/ | jq .

# Get reverse proxy upstreams status
curl http://localhost:2019/config/apps/http/servers | jq .
```

### Test the proxy endpoint directly

```bash
# Basic connectivity test
curl -i http://localhost:10000/

# Test with sticky session header
curl -i -H "${STICKY_SESSION_HEADER}: session-123" http://localhost:10000/
```

### DNS Troubleshooting

```bash
# Check SRV records for service discovery
dig SRV ${DOWNSTREAM_HOST}-discovery.${NAMESPACE}.svc.cluster.local

# Check DNS resolution
nslookup ${DOWNSTREAM_HOST}-discovery
```

## Environment Variables

- `PORT` - Port the Caddy proxy listens on
- `DOWNSTREAM_HOST` - Downstream service hostname prefix
- `NAMESPACE` - Kubernetes namespace for service discovery
- `STICKY_SESSION_HEADER` - Header name used for sticky session routing
