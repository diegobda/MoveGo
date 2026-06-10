
# MoveGo

Resumo do repositório e documentação centralizada para o projeto MoveGo.

## Visão geral

MoveGo é uma plataforma de mobilidade que gerencia usuários, motoristas, veículos,
corridas, pagamentos, wallets e notificações. Este repositório concentra a
documentação do produto, especificação da API, migrações do banco e artefatos
de engenharia necessários para iniciar o desenvolvimento e deploy.

Referências principais: [PROJECT.md](PROJECT.md), [docs/PRD.md](docs/PRD.md).

## Arquitetura

A arquitetura é orientada a serviços, com componentes de Auth, Trips, Billing,
Users/Drivers e Notifications; eventos assíncronos são trocados via RabbitMQ e
posições em tempo real são gerenciadas preferencialmente em Redis com snapshot
para Postgres/PostGIS. Para detalhes e diagramas veja [docs/architecture.md](docs/architecture.md)
e [docs/er_diagram.md](docs/er_diagram.md).

## Stack tecnológica

- Banco: PostgreSQL + PostGIS, extensões `pgcrypto`, `citext`
- Real-time / cache: Redis (pub/sub, geo)
- Messaging: RabbitMQ
- Backend: NestJS (TypeScript)
- Mobile: Flutter
- Admin: Next.js
- Payments: Stripe, PIX
- Infra: Docker, Docker Compose (local), Kubernetes + Helm (prod)
- Observability: Prometheus, Grafana, Loki

## Estrutura de diretórios

- `admin/` — Next.js admin frontend
- `backend/` — serviços backend, migrações e scripts (ver `backend/migrations/`)
- `mobile/` — Flutter app
- `infra/` — infra as code, compose templates (work in progress)
- `docs/` — documentação (arquitetura, DB, API, deployment, roadmap)
- `tests/` — testes automatizados

Consulte `docs/` para a documentação detalhada.

## Como executar localmente (resumo)

Requisitos: Docker, Docker Compose, Node.js, pnpm/npm, Python 3.12 (opcional),
Postgres com PostGIS, Redis e RabbitMQ.

Exemplo rápido usando Docker Compose (template em `docs/deployment.md`):

```bash
# subir serviços de infra
docker compose -f infra/docker-compose.yml up --build

# criar venv (opcional para utilitários)
python3 -m venv .venv
. .venv/bin/activate
pip install -r backend/requirements.txt  # se existir

# rodar migrações (exemplo SQL já em backend/migrations)
psql "postgresql://user:pass@localhost:5432/movego" -f backend/migrations/001_extensions.sql
psql "postgresql://user:pass@localhost:5432/movego" -f backend/migrations/002_schema.sql
psql "postgresql://user:pass@localhost:5432/movego" -f backend/migrations/003_indexes_constraints.sql

# iniciar backend (exemplo)
cd backend
pnpm install
pnpm start:dev
```

Para orientação completa de deploy e infra veja [docs/deployment.md](docs/deployment.md).

## Roadmap

Visão de entregas e prioridades está em [docs/roadmap.md](docs/roadmap.md) e
tarefas em [docs/tasks.md](docs/tasks.md). Principais marcos:

- MVP: autenticação, criação/execução de corridas, cobranças e rating
- V1: wallet, cupons, métricas e observabilidade
- V2: escala nacional, particionamento, sharding e melhorias de SRE

## Convenções de desenvolvimento

- Moedas: campos inteiros em centavos (`*_cents`) — evitar floats
- IDs: usar UUID v4 (`gen_random_uuid()` no Postgres)
- API: OpenAPI 3.1 especificada em [docs/openapi.yaml](docs/openapi.yaml)
- Idempotência: cabeçalho `Idempotency-Key` onde aplicável (pagamentos, criação de corridas)
- Localização: GeoJSON (`Point`) ou `{lat,lng}` — ver `TripLocation` em OpenAPI

Regras de contribuição, lint e commits: siga o guia de commits e código do time
(adicionar quando houver `CONTRIBUTING.md`).

## Status da documentação

Documentação principal (DB, API, arquitetura, validações) está em `docs/`.
O relatório de validação OpenAPI encontra-se em [docs/openapi-validation-report.md](docs/openapi-validation-report.md).

## Próximos passos sugeridos

- Finalizar validação OpenAPI e corrigir inconsistências (`docs/openapi.yaml`).
- Criar `docker-compose.yml` definitivo e templates Helm (infra/).
- Gerar stubs do servidor/cliente a partir da OpenAPI quando validada.

---

Se quiser, posso agora executar a validação completa do OpenAPI e aplicar correções automáticas.
# MoveGo
