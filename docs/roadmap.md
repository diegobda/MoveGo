# Roadmap — MoveGo

## Visão
Roadmap dividido em MVP, V1 e V2 com entregas, critérios de aceite e estimativas de esforço.

### MVP (Goal: core product — Passenger + Driver + Payments)
Duration estimate: 10–14 weeks

- Auth (email/phone/password, OAuth)
- Passenger app: request trip, cancel, history
- Driver app: accept/reject, go online/offline, navigate
- Trips lifecycle: request → match → start → complete
- GPS tracking (basic ping every 5s)
- Payments: card via Stripe + wallet integration
- Admin panel: user/driver list, manual trip adjustment
- Backend core services: Auth, Trips, Users, Drivers, Billing
- CI/CD, staging deploy, logging/metrics

Acceptance criteria (MVP):
- End-to-end flow: passenger requests + driver completes a trip + payment reconciles
- Basic monitoring and alerts

### V1 (Goal: growth & retention)
Duration estimate: 8–12 weeks

- Coupons & cashback
- Program de indicação
- Melhorias em matching e otimização de rota
- Suporte a PIX e carteiras locais
- Melhor UX de GPS (fusão de sensores, atualização eficiente)
- Melhorias de segurança e AML checks

Acceptance criteria (V1):
- Stable billing with coupons applied and reconciliation
- Reduced cancelation rate (metrics)

### V2 (Goal: new verticals & enterprise)
Duration estimate: 12–20 weeks

- Entregas (logistics module)
- Marketplace (parcerias)
- Conta empresarial / multi-tenant
- Multi-region deployment

Acceptance criteria (V2):
- Enterprise onboarding flow
- Region failover tested

## Milestones e releases
- Week 1–2: Core auth, infra, DB modeling
- Week 3–6: Trips and real-time prototype
- Week 7–10: Payments + end-to-end flows
- Week 11–14: Admin, observability, polish

## Métricas a acompanhar
- Time to match
- Trips completed per hour
- Revenue per trip
- Uptime, error rates
- Latency 95/99 percentiles

## Dependências por fase
- MVP: Stripe, Firebase, Google Maps
- V1: Local payment providers (PIX), marketing tools
- V2: Multi-region infra, enterprise billing integrations

## Observações sobre estimativas
- Estimativas assumem time de 4–6 engenheiros (backend, mobile, infra) + 1 PM/PO
- Se time menor, timeline escala linearmente

