# MOVEGO

## Visão Geral

MoveGo é uma plataforma de mobilidade urbana inspirada em Uber, 99 e InDrive.

O sistema conecta passageiros e motoristas através de geolocalização em tempo real, pagamentos digitais e gerenciamento centralizado.

O projeto deve ser desenvolvido utilizando arquitetura moderna, escalável e preparada para milhares de usuários simultâneos.

---

# Objetivos

## Passageiro

* Solicitar corridas
* Acompanhar motorista
* Realizar pagamentos
* Avaliar corridas
* Compartilhar localização

## Motorista

* Receber corridas
* Navegar até passageiros
* Gerenciar ganhos
* Acompanhar histórico

## Administração

* Gerenciar usuários
* Gerenciar motoristas
* Gerenciar corridas
* Gerenciar pagamentos
* Gerenciar promoções

---

# Tecnologias

## Mobile

Flutter
Dart

## Backend

NestJS
TypeScript

## Banco de Dados

PostgreSQL

## Cache

Redis

## Mensageria

RabbitMQ

## Frontend Administrativo

NextJS
TypeScript

## Infraestrutura

Docker
Docker Compose
Kubernetes

## Cloud

AWS

---

# Estrutura do Projeto

/apps

/backend

/mobile

/admin

/infra

/docs

/tests

/scripts

---

# Aplicativo Passageiro

## Funcionalidades

### Autenticação

* Cadastro
* Login
* Recuperação de senha
* Login Google
* Login Apple

### Perfil

* Foto
* Dados pessoais
* Métodos de pagamento

### Corridas

* Solicitar corrida
* Agendar corrida
* Cancelar corrida
* Histórico

### Localização

* GPS em tempo real
* Compartilhamento de rota

### Pagamentos

* PIX
* Cartão
* Carteira Digital

### Avaliações

* Avaliar motorista
* Histórico de avaliações

---

# Aplicativo Motorista

## Cadastro

* Nome
* CPF
* CNH
* Documento do veículo

## Operação

* Online
* Offline

## Corridas

* Aceitar
* Recusar
* Iniciar
* Finalizar

## Financeiro

* Ganhos
* Saques
* Extrato

## Avaliações

* Nota média
* Comentários

---

# Painel Administrativo

## Dashboard

* Usuários ativos
* Motoristas ativos
* Corridas em andamento
* Receita

## Usuários

* Listar
* Editar
* Suspender

## Motoristas

* Aprovar
* Bloquear
* Auditar

## Financeiro

* Comissões
* Saques
* Relatórios

## Promoções

* Cupons
* Cashback

---

# Banco de Dados

## Entidades

Users

Drivers

Vehicles

Trips

TripLocations

Payments

Wallets

Ratings

Coupons

Notifications

AuditLogs

AdminUsers

---

# Segurança

JWT

Refresh Token

RBAC

LGPD

OWASP TOP 10

Criptografia AES-256

Rate Limiting

Logs de Auditoria

---

# Integrações

Google Maps

Firebase

Stripe

Twilio

OpenStreetMap

---

# Escalabilidade

Suportar inicialmente:

* 10.000 usuários simultâneos
* 2.000 corridas simultâneas

Preparado para:

* Escala nacional
* Multi-região
* Multi-tenant

---

# DevOps

Docker

Kubernetes

GitHub Actions

CI/CD

Prometheus

Grafana

Loki

---

# Roadmap MVP

Fase 1

* Login
* Cadastro
* Passageiro
* Motorista
* Corridas
* GPS
* Pagamentos

---

# Roadmap V1

* Cupons
* Cashback
* Programa de indicação

---

# Roadmap V2

* Entregas
* Marketplace
* Conta empresarial

---

# Critérios de Aceitação

O sistema será considerado pronto quando:

* Backend funcional
* Aplicativo Passageiro funcional
* Aplicativo Motorista funcional
* Painel Administrativo funcional
* APIs documentadas
* Testes automatizados aprovados
* Deploy automatizado configurado
* Ambiente de produção operacional

---

# Instruções para Claude Code

Sempre:

1. Ler PROJECT.md antes de qualquer alteração.
2. Atualizar documentação quando necessário.
3. Explicar impacto das mudanças.
4. Criar código funcional.
5. Criar testes automatizados.
6. Seguir Clean Architecture.
7. Seguir SOLID.
8. Seguir DDD quando aplicável.
9. Seguir melhores práticas de segurança.
10. Nunca gerar pseudocódigo.
11. Nunca remover funcionalidades sem autorização.

Este documento é a fonte oficial de requisitos do projeto.
