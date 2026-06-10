# Backlog & Tasks — MoveGo

Este backlog é uma decomposição inicial organizada por epics, priorizada para entrega do MVP e além.

## Como usar
- Tasks têm prioridade (P0, P1, P2)
- Estimativas em pontos (T-shirt or story points) indicativas

## Epic: Infra & Foundations
- INF-001: Configurar repositório monorepo e estrutura `/apps` (P0) — 3pts
- INF-002: Criar `docker-compose.yml` para dev local (Postgres, Redis, RabbitMQ, Minio) (P0) — 2pts
- INF-003: Provisionar cluster Kubernetes de dev/staging/prod (Terraform) (P0) — 8pts
- INF-004: CI pipelines (PR checks, build, push image) (P0) — 5pts
- INF-005: Observability stack (Prometheus, Grafana, Loki) (P1) — 5pts

## Epic: Auth & Users
- AUTH-001: Implementar Auth Service (register/login/password reset) (P0) — 8pts
- AUTH-002: OAuth (Google/Apple) integration (P1) — 5pts
- AUTH-003: Refresh tokens & revocation (P0) — 3pts
- AUTH-004: User profile endpoints (get/update) (P0) — 3pts

## Epic: Drivers
- DRV-001: Driver onboarding flow + docs upload (P0) — 8pts
- DRV-002: Driver approval workflow (admin) (P0) — 3pts
- DRV-003: Driver online/offline and presence tracking (P0) — 5pts

## Epic: Trips & Real-time
- TRP-001: Create Trip API + basic matching (P0) — 13pts
- TRP-002: WebSocket infra and position updates (P0) — 8pts
- TRP-003: Trip lifecycle endpoints (accept/start/complete/cancel) (P0) — 8pts
- TRP-004: Geospatial index and driver search (P0) — 8pts
- TRP-005: TripLocations ingestion and retention policy (P1) — 5pts

## Epic: Billing & Payments
- PAY-001: Integrate Stripe (charge flow) (P0) — 8pts
- PAY-002: Wallet model and internal transfers (P1) — 5pts
- PAY-003: Reconciliation jobs and webhooks (P0) — 5pts
- PAY-004: PIX/local gateway integration (P1) — 8pts

## Epic: Admin Panel
- ADM-001: Next.js admin skeleton (auth + RBAC) (P0) — 5pts
- ADM-002: Users/Drivers list with actions (approve/suspend) (P0) — 5pts
- ADM-003: Financial reports and exports (P1) — 8pts

## Epic: Notifications & Communications
- NOT-001: Push via Firebase (P0) — 3pts
- NOT-002: SMS via Twilio (P1) — 3pts
- NOT-003: In-app notification store and retrieval (P1) — 3pts

## Epic: QA & Testing
- QA-001: Unit test coverage baseline (target 70%) (P0) — 8pts
- QA-002: Integration tests for trip flow (P0) — 8pts
- QA-003: Load testing scripts for matching + real-time (P0) — 8pts

## Epic: Security & Compliance
- SEC-001: Pen test pre-prod (P1) — 5pts
- SEC-002: Data export/delete endpoints (LGPD) (P0) — 3pts
- SEC-003: Secrets management integration (Vault/KMS) (P0) — 3pts

## Maintenance & Ops
- OPS-001: Backups configured for Postgres (P0) — 3pts
- OPS-002: DR runbook (P1) — 3pts

## Sprints sugeridos para MVP (8 sprints, 2 semanas cada)
- Sprint 1: INF-001, INF-002, AUTH-001 (bootstrap)
- Sprint 2: TRP-001, DRV-001
- Sprint 3: TRP-002, DRV-003
- Sprint 4: PAY-001, TRP-003
- Sprint 5: ADM-001, AUTH-003
- Sprint 6: QA-001, QA-002
- Sprint 7: Observability, infra hardening
- Sprint 8: Polish, documentation, release

## Notas finais
Backlog deve ser refinado com PO e estimativas validadas com time. Muitas tasks dependem de integração externa (Stripe, Google Maps), portanto bloquear e mockar essas integrações nos testes.