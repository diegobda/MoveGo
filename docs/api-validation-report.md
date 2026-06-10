# API Validation Report — MoveGo

Data: 2026-06-09

Objetivo: validar consistência entre `PROJECT.md`, `docs/architecture.md`, `docs/database.md` e `docs/api-specification.md`.

## Metodologia
- Conferi o schema definido em `backend/migrations/002_schema.sql` e índices em `003_indexes_constraints.sql`.
- Comparei os recursos e campos listados em `docs/database.md` com a especificação API atualizada.

## Inconsistências encontradas

1. Nomenclatura de valores monetários
- `PROJECT.md` e arquitetura mencionavam `fare_amount`/`commission_amount`. No schema usei `fare_cents` / `commission_cents` (bigint) para precisão. Action: API atualizada para `fare_cents`.

2. Localização/position model
- `PROJECT.md` mencionava `lat/lng` em `trip_locations`. No schema usei `location` geometry(Point,4326) com `recorded_at` para melhor indexação geoespacial. API oferece ambos (aceita lat/lng e converte para geometry).

3. Driver current location store
- `PROJECT.md` não especificava onde manter posição atual; arquitetura sugeria Redis. Schema inclui `driver_current_locations` como fallback, mas destaca Redis para alta taxa. Action: documentar claramente que posições em tempo real devem usar Redis/streaming; DB apenas snapshot.

4. Payments / wallet flows
- `PROJECT.md` e `docs/api-specification.md` inicial não detalhavam `wallet_transactions` ledger. Schema adiciona `wallet_transactions` e requisitos de transação. Action: API adicionada para `wallets` e `wallet_transactions`.

5. Idempotência
- Implementado storage `idempotency_keys` e índice parcial em `payments`. API agora exige `Idempotency-Key` para `POST /trips` e `POST /payments/charge`.

6. Partitioning
- `trip_locations` foi definido como particionado por `recorded_at`. API inclui pagination cursor para lidar com large-history reads.

## Recomendações de melhorias de escalabilidade

1. Use Redis (or memory cache + pub/sub) para driver locations and presence. Persist only aggregated snapshots to DB.
2. For high-frequency position updates, use an ingestion pipeline (Kafka/RabbitMQ) and batch writes to partitions to avoid write amplification.
3. Consider sharding `trips` by region or customer-id hash once single-node write contention observed.
4. Monitor table growth of `trip_locations` and implement lifecycle/retention (e.g., move old partitions to cold storage).
5. Add materialized views for billing reports and pre-computed aggregates updated via incremental refresh.
6. Enforce rate limits at API Gateway and provide quota per client.

## Minor suggestions / polishing

- Standardize on `_cents` for all monetary fields across all APIs to avoid floating issues.
- Add `currency` optional on wallets/payments (default BRL) and validate ISO codes.
- Consider cursor-based pagination for endpoints returning large time-series (trip locations, audit logs).

## Next steps
- Approve API spec changes. On approval, generate `docs/openapi.yaml` (full OpenAPI 3.0) automatically from spec and DTOs or from this doc.
- Implement API mocks and tests to validate field-level compatibility with DB migrations.

*** End of report ***
