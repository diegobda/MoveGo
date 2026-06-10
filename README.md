# 🚖 MoveGo

Plataforma de mobilidade urbana inspirada em Uber, 99 e InDrive, desenvolvida com arquitetura moderna baseada em Flutter, NestJS, PostgreSQL e AWS.

O projeto foi concebido para suportar crescimento regional e nacional, oferecendo aplicativos para passageiros e motoristas, painel administrativo, pagamentos digitais, rastreamento em tempo real e infraestrutura cloud-native.

---

# 📋 Visão Geral

MoveGo conecta passageiros e motoristas através de geolocalização em tempo real, permitindo solicitações de corridas, acompanhamento de viagens, pagamentos digitais e gerenciamento completo da operação.

## Principais Recursos

### Passageiro

* Cadastro e autenticação
* Solicitação de corridas
* Rastreamento em tempo real
* Histórico de viagens
* Pagamento via PIX
* Pagamento via cartão
* Compartilhamento de rota
* Avaliação de motoristas

### Motorista

* Cadastro e validação documental
* Aceitação de corridas
* Navegação GPS
* Controle financeiro
* Histórico de ganhos
* Avaliação pelos passageiros

### Administração

* Dashboard operacional
* Gestão de usuários
* Gestão de motoristas
* Gestão financeira
* Relatórios gerenciais
* Cupons e promoções

---

# 🏗 Arquitetura

O projeto segue princípios de:

* Clean Architecture
* SOLID
* Domain Driven Design (DDD)
* API First
* Event Driven Architecture
* Cloud Native Design

## Componentes

```text
┌─────────────────────────────┐
│        Flutter App          │
│   Passageiro / Motorista    │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│       API Gateway           │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│         NestJS API          │
└──────────────┬──────────────┘
               │
 ┌─────────────┼─────────────┐
 ▼             ▼             ▼
PostgreSQL    Redis      RabbitMQ
```

---

# 🛠 Stack Tecnológica

## Mobile

* Flutter
* Dart

## Backend

* NestJS
* TypeScript
* Prisma ORM

## Banco de Dados

* PostgreSQL

## Cache

* Redis

## Mensageria

* RabbitMQ

## Frontend Administrativo

* Next.js
* TypeScript
* TailwindCSS

## Infraestrutura

* Docker
* Docker Compose
* Kubernetes

## Cloud

* AWS
* RDS
* S3
* EKS
* CloudFront
* Route53

---

# 📁 Estrutura do Projeto

```text
movego/

├── backend/
│
├── mobile/
│
├── admin/
│
├── infra/
│
├── docs/
│
├── scripts/
│
├── tests/
│
└── README.md
```

---

# 🔐 Segurança

O projeto foi projetado seguindo recomendações da OWASP.

## Recursos

* JWT Authentication
* Refresh Tokens
* Role Based Access Control (RBAC)
* MFA (planejado)
* LGPD Compliance
* Criptografia AES-256
* Auditoria de eventos
* Rate Limiting
* Proteção contra ataques comuns

---

# 🚗 Módulos Principais

## Passageiros

* Users
* Wallets
* Payments
* Ratings
* Notifications

## Motoristas

* Drivers
* Vehicles
* Driver Availability
* Driver Location

## Corridas

* Trips
* Trip Events
* Trip Locations
* Fare Calculation

## Administração

* Dashboard
* Reports
* Audit Logs
* Promotions

---

# 💰 Monetização

Modelo de receita:

* Comissão por corrida
* Taxas de processamento
* Conta corporativa
* Programa premium
* Marketplace futuro

---

# 📈 Roadmap

## MVP

* Cadastro
* Login
* Solicitação de corrida
* GPS
* Rastreamento
* Pagamentos
* Avaliações

## V1

* Cupons
* Cashback
* Programa de indicação
* Corridas agendadas

## V2

* Entregas
* Marketplace
* Conta empresarial
* Assinaturas

---

# 🧪 Testes

Serão implementados:

* Unit Tests
* Integration Tests
* E2E Tests
* Load Tests

Ferramentas:

* Jest
* Supertest
* Flutter Test

---

# 🚀 Ambiente Local

## Requisitos

* Docker
* Docker Compose
* Node.js
* Flutter SDK

## Inicialização

```bash
git clone <repository-url>

cd movego

docker compose up -d
```

---

# 📚 Documentação

Toda documentação do projeto encontra-se em:

```text
docs/
```

Arquivos principais:

```text
PROJECT.md
architecture.md
database.md
api-specification.md
openapi.yaml
security.md
deployment.md
roadmap.md
tasks.md
```

---

# 🤝 Contribuição

1. Crie uma branch.
2. Implemente a funcionalidade.
3. Execute os testes.
4. Abra um Pull Request.

---

# 📄 Licença

Projeto privado.

Todos os direitos reservados.

---

# 👨‍💻 Status do Projeto

🚧 Em desenvolvimento

Fase atual:

✅ Planejamento

✅ Arquitetura

✅ Banco de Dados

✅ Especificação OpenAPI

🔄 Estruturação do Monorepo

⏳ Backend NestJS

⏳ Aplicativo Flutter

⏳ Painel Administrativo

⏳ Infraestrutura Kubernetes
