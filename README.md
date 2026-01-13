# Sticky Sessions Caddy Proxy

A Caddy reverse proxy implementation with sticky sessions using dynamic SRV-based service discovery.

## Set up

1. Make a note of your Workspaces namespace

From a service running as a Native Runtime find your namespace by running the following from a webshell
```bash
echo $RENDER_SERVICE_NS
```

2. Deploy the blueprint entering use the value from step 1 when prompted for the `NAMESPACE` environment variable. Make sure this environment variable is present on your Caddy service after the first sync is complete.

## Test it out

Run the following from the web shell of your caddy service for a curl command to run locally

```bash
echo "curl -i -H '${STICKY_SESSION_HEADER}: session-123' https://${RENDER_EXTERNAL_HOSTNAME}/"
```

### 502/503 errors on initial deploy

If you're getting `502` or `503` errors on initial deploy

- Double check that the `NAMESPACE` variable exists for the Caddy reverse proxy
- Try redeploying both services

## Troubleshooting

Run all of the following from the web shell of your caddy service

### Caddy Admin API to check the config of the proxy

```bash
# Get current configuration
curl http://localhost:2019/config/ | jq .
```

### Test the endpoint directly

```bash
# Basic connectivity test
curl -i http://$DOWNSTREAM_HOST:$DOWNSTREAM_PORT

# Test via the proxy
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
