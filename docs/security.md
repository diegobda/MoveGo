# Segurança — MoveGo

## Overview

Objetivos de segurança:
- Proteger dados pessoais (LGPD)
- Garantir integridade e confidencialidade em pagamentos
- Prevenir fraudes e abuso da plataforma

## Autenticação

- JWT (Access Token) — curto prazo (ex: 15 min)
- Refresh Token — longo prazo (ex: 30 dias), armazenado no DB com revogação
- OAuth providers: Google, Apple
- Multi-factor optional (SMS/email/Authenticator) para ações sensíveis

## Autorização

- RBAC (roles: user, driver, admin, superadmin)
- Policies no backend (nestjs guards + decorators)
- Escopo de token para limitar ações por cliente/aplicação

## Proteção de dados

- Criptografia em trânsito (TLS 1.2+)
- Criptografia em repouso: AES-256 para campos sensíveis (documentos, PII)
- Secrets: AWS KMS / Hashicorp Vault para chaves e segredos
- Hash de senhas: Argon2id / bcrypt com salt

## Proteção de endpoints

- Rate limiting (per IP and per user)
- WAF (opcional) para bloquear padrões conhecidos
- Input validation and sanitization (prevent injection)
- Reject overly-large requests

## Pagamentos e finanças

- Idempotency keys for payment operations
- Webhook verification for Stripe/TTP providers
- Reconciliation batch jobs
- PCI scope: avoid storing raw card data — use Stripe Elements / hosted forms

## Auditing and Monitoring

- Audit logs for admin actions and financial changes
- Immutable write-ahead audit store (append-only) for critical ops
- Alerts on anomalous patterns (many cancellations, refund spikes)

## Penetration testing & reviews

- Scheduled pentests pre-release to production
- Dependency vulnerability scanning (Snyk, dependabot)

## Incident response

- Runbook for data breach: containment, notification, remediation
- Rotate keys that might be leaked

## Privacy (LGPD)

- Data retention policies
- Endpoints for data export / deletion
- Minimal collection of PII

## Recommendations

- Centralized secrets management (Vault)
- Periodic key rotation
- Use CSP and secure headers in admin frontend
- Monitor and block suspicious device/fingerprint patterns
