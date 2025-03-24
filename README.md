# Model Context Protocol (MCP) Server

This repository contains the Kubernetes deployment configuration for the MCP server on Azure Kubernetes Service (AKS).

## Prerequisites

- Azure CLI
- kubectl
- Docker
- Node.js 18+

## Project Structure

```
.
├── k8s/
│   ├── deployment.yaml    # Kubernetes deployment configuration
│   ├── service.yaml      # Kubernetes service configuration
│   └── configmap.yaml    # Kubernetes configmap for environment variables
├── src/                  # Source code directory
├── Dockerfile           # Container build configuration
├── package.json         # Node.js dependencies
└── tsconfig.json        # TypeScript configuration
```

## Deployment Steps

1. Build the Docker image:
```bash
docker build -t mcp-server:latest .
```

2. Push the image to Azure Container Registry (ACR):
```bash
az acr login --name <your-acr-name>
docker tag mcp-server:latest <your-acr-name>.azurecr.io/mcp-server:latest
docker push <your-acr-name>.azurecr.io/mcp-server:latest
```

3. Apply Kubernetes manifests:
```bash
kubectl apply -f k8s/
```

4. Verify deployment:
```bash
kubectl get pods
kubectl get services
```

## Configuration

The application can be configured through environment variables defined in the ConfigMap (`k8s/configmap.yaml`).

## Health Checks

The application exposes a `/health` endpoint for Kubernetes health checks.

## Monitoring

- Resource usage can be monitored through Azure Monitor
- Application logs are available through `kubectl logs`

## Security

- The application uses HTTPS
- CORS is configured for secure cross-origin requests
- Rate limiting is implemented to prevent abuse
- Helmet.js is used for security headers

## Scaling

The deployment is configured with 3 replicas by default. You can scale up or down using:

```bash
kubectl scale deployment mcp-server --replicas=<number>
``` 