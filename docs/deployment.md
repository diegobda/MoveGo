# Deploy & Infra — MoveGo

## Objetivo
Documentar a estratégia de containerização, desenvolvimento local, e deploy para Kubernetes e CI/CD.

## Local dev

- `docker-compose.yml` com serviços mínimos: postgres, redis, rabbitmq, minio (S3), localstack (opcional), backend (na imagem de desenvolvimento), admin (nextjs), mobile emulator

Exemplo (resumo):
```
services:
  postgres:
  redis:
  rabbitmq:
  minio:
  backend:
  admin:
```

## Containerização

- Cada serviço empacotado como Docker image (multi-stage builds)
- Tags: `movego/<service>:<git-sha>`
- Use distroless base quando apropriado

## Kubernetes

- Namespace por ambiente (`dev`, `staging`, `prod`)
- Deployments + HPA (targets: CPU, memory, custom metrics like queue length or connection count)
- Services: ClusterIP para internos, LoadBalancer/Ingress para gateways
- Ingress: NGINX Ingress Controller ou AWS ALB Ingress
- ConfigMaps / Secrets para configurações
- Volumes: PVs para backups e minio

## Helm

- Criar charts para cada serviço (ou umbrella chart)
- Valores por ambiente

## CI/CD — GitHub Actions

Pipelines sugeridos:
- PR pipeline: lint, unit tests, build images (optional), security scans
- Main pipeline: build Docker images, push to registry, run integration tests, deploy to staging
- Release pipeline: deploy to production with manual approval

Secrets: armazenar creds no GitHub Secrets ou Hashi Vault connector

## Observability e SRE

- Metrics: Prometheus scraping endpoints /metrics
- Dashboards: Grafana
- Logs: centralizar com Loki
- Tracing: Jaeger

## Backups e DR

- Postgres backups (pg_dump / base backups) com retention
- Backup S3 objects
- Disaster recovery runbook

## Autoscaling e capacidade

- HPA para services stateless
- VPA (opcional) para ajustar recursos
- Cluster autoscaler para ganho de nós

## Rollback e Canary

- Deploys canary com ingress/traffic-splitting
- Rollback via Helm rollback

## Secrets and IAM

- Use IAM roles for service accounts (IRSA on EKS) or KMS for secrets
- Least privilege for DB and S3

## Networking and security

- NetworkPolicies para limitar tráfego entre pods
- TLS via cert-manager
- WAF para exposição pública

## CronJobs and Batch

- Jobs para reconciliation, settlements, analytics

## Infra as Code

- Terraform para VPC, EKS (or managed k8s), RDS, IAM, S3, CloudFront

## Deployment checklist

- Run migrations (automated with deploy hook)
- Run smoke tests
- Monitor SLO slippage post-deploy

## Observação
Detalhar templates de `docker-compose.yml`, `Dockerfile`, `helm` e `k8s manifests` será a próxima etapa quando for iniciar infra como código.