# Tasks — Linkly API

Checklist de construção da v1, baseado em [`project.md`](./project.md). Cada item é um commit separado. Marque `[x]` ao terminar **e commitar**.

> **Convenção:** um exercício por commit. Não acumule mudanças de dois exercícios no mesmo commit — dificulta review e rollback.

---

## Arquitetura atual (revisada)

```
src/
├── server.ts           # bootstrap Fastify + registra rotas + listen
├── routes/             # registro de rotas no Fastify (sem lógica)
├── controllers/        # handlers HTTP — request/response, conversão de erro → status
├── services/           # regras de negócio — orquestra repository e regras (ex: colisão)
├── lib/                # cliente Prisma, helpers, error classes, error-handler plugin
└── schemas/            # JSON Schemas (validação e serialização)

prisma/
├── schema.prisma       # model Url, datasource sqlite
├── migrations/         # migrações versionadas
└── dev.db              # banco local (ignorado)

prisma.config.ts        # config Prisma 7 (datasource url vem daqui)
```

Fluxo: **route → controller → service → Prisma client**

---

## Setup (pré-requisitos da v1)

- [x] **S0.1** — Instalar dependências de runtime (`nanoid`, `prisma`, `@prisma/client`)
- [x] **S0.2** — Instalar dependências de dev (`typescript`, `tsx`, `@types/node`, `dotenv`)
- [x] **S0.3** — Configurar `tsconfig.json` (strict, ESM, target ES2022)
- [x] **S0.4** — Trocar `package.json` para `"type": "module"`
- [x] **S0.5** — Adicionar scripts (`dev`, `start`, `typecheck`, `test`, `db:migrate`, `db:generate`, `db:studio`)
- [x] **S0.6** — Criar estrutura de pastas (`src/{routes,controllers,services,lib,schemas}` + `test/` + `prisma/`)
- [x] **S0.7** — Servidor Fastify respondendo `GET /` (Hello World)
- [x] **S0.8** — Atualizar `.gitignore` (`dist/`, `*.tsbuildinfo`, `.claude/`, `prisma/dev.db`, `prisma/dev.db-journal`)
- [x] **S0.9** — Configurar Prisma (`prisma/schema.prisma` + `prisma.config.ts` + `.env`)
- [x] **S0.10** — Rodar `prisma migrate dev --name init` (migration inicial criada)
- [x] **S0.11** — Trocar `better-sqlite3` por Prisma (desinstalar + reposicionar arquivos)

---

## Exercícios do `project.md` (adaptados para a nova arquitetura)

### Exercício 1 — Setup do banco e migração ✅ (feito no S0.9–S0.10)
- [x] **E1.1** — Schema Prisma definido em `prisma/schema.prisma` com model `Url`
- [x] **E1.2** — Migration inicial aplicada (`prisma/migrations/`)
- [x] **E1.3** — `dev.db` criado em `prisma/dev.db` (ignorado pelo git)
- [ ] **E1.4** — Criar `src/lib/prisma.ts` exportando `PrismaClient` singleton
- [ ] **E1.5** — Criar `src/lib/errors.ts` com error classes tipadas (`NotFoundError`, `CollisionError`)

**Conceito a registrar em `notes.md`:** Prisma 7 mudou a config — `url` saiu do schema e foi pro `prisma.config.ts`. Trade-off: mais arquivos, mas datasource fica centralizado.

### Exercício 2 — `POST /urls` mínimo (sem validação)
- [ ] **E2.1** — Criar `src/services/urls-service.ts` com `createShortUrl(originalUrl)` que gera `shortCode` com nanoid e chama `prisma.url.create()`
- [ ] **E2.2** — Tratar `P2002` (unique constraint) com retry (max 5) → `CollisionError` → 409
- [ ] **E2.3** — Criar `src/controllers/urls-controller.ts` com `createUrl(request, reply)` chamando o service
- [ ] **E2.4** — Criar `src/routes/urls.ts` registrando `POST /urls` → `urlsController.createUrl`
- [ ] **E2.5** — Registrar a rota no `server.ts`
- [ ] **E2.6** — Retornar 201 com `{ shortCode, shortUrl, originalUrl, createdAt }`
- [ ] **E2.7** — Testar com `routes.http`: enviar `{ url: "https://exemplo.com" }` → 201
- [ ] **E2.8** — **Quebrar de propósito:** enviar `{ url: "não-é-url" }` → observar o que acontece (deve quebrar até E3)

**Conceito a registrar:** error code do Prisma (`P2002` = unique violation) e por que capturamos no service, não no controller.

### Exercício 3 — Validação com JSON Schema
- [ ] **E3.1** — Criar `src/schemas/url.ts` com schema de body (`format: "uri"`, `required: ["url"]`)
- [ ] **E3.2** — Aplicar `schema: { body: createUrlSchema }` na rota via Fastify
- [ ] **E3.3** — Repetir o teste quebrado (E2.8) → ver 400 automático do fastify
- [ ] **E3.4** — Adicionar `schema.response` (201) para garantir shape de retorno

**Conceito a registrar:** o que o fastify faz sozinho (validação, serialização) vs o que não faz (mensagem customizada, i18n).

### Exercício 4 — `GET /:code` com redirect
- [ ] **E4.1** — Adicionar `findByCode(code)` em `urls-service.ts` (usa `prisma.url.findUnique`)
- [ ] **E4.2** — Adicionar `incrementClicks(code)` em `urls-service.ts` (`UPDATE clicks = clicks + 1`)
- [ ] **E4.3** — Adicionar controller `redirectToUrl(request, reply)` em `urls-controller.ts`
- [ ] **E4.4** — Registrar `GET /:code` em `routes/urls.ts`
- [ ] **E4.5** — `reply.redirect(301, originalUrl)` — método nativo do Fastify
- [ ] **E4.6** — Adicionar `schema.params` validando formato do code (string, 3-20 chars)
- [ ] **E4.7** — Tratar `NotFoundError` → 404 (helper no controller? ou só deixar o handler global?)

**Conceito a registrar:** update atômico de contador (concorrência) — por que `clicks = clicks + 1` e não `clicks = ?`.

### Exercício 5 — Error handler global
- [ ] **E5.1** — Criar `src/lib/error-handler.ts` exportando função `(app: FastifyInstance) => void`
- [ ] **E5.2** — Registrar via `app.setErrorHandler(...)` no `server.ts`
- [ ] **E5.3** — Padronizar resposta no formato RFC 7807 (`application/problem+json`)
- [ ] **E5.4** — Mapear `NotFoundError` → 404, `CollisionError` → 409, erro genérico → 500
- [ ] **E5.5** — Garantir que `pino` (logger do fastify) registra stack mas cliente não vê
- [ ] **E5.6** — Refatorar handlers que tinham `try/catch` local → usar handler central

**Conceito a registrar:** diferença entre `error.statusCode` vs `error.code`, e o que é "vazamento de info".

### Exercício 6 — `GET /urls/:code/stats` e `GET /urls`
- [ ] **E6.1** — Adicionar `getStats(code)` em `urls-service.ts`
- [ ] **E6.2** — Adicionar controller `getStats(request, reply)`
- [ ] **E6.3** — Registrar `GET /urls/:code/stats`
- [ ] **E6.4** — Retornar `{ shortCode, originalUrl, clicks, createdAt }`
- [ ] **E6.5** — Garantir tipos com `schema.response`
- [ ] **E6.6** — Implementar `GET /urls` (lista completa — debug)

**Conceito a registrar:** serialização coerciva via schema — por que é melhor que confiar no driver.

### Exercício 7 — Testes com `node:test`
- [ ] **E7.1** — Configurar `test/` com `node:test` + `tsx`
- [ ] **E7.2** — Teste: criar URL → 201 + estrutura correta
- [ ] **E7.3** — Teste: body inválido → 400
- [ ] **E7.4** — Teste: redirect com código válido → 301 + Location + contador +1
- [ ] **E7.5** — Teste: redirect com código inexistente → 404
- [ ] **E7.6** — Teste: stats após N cliques → `clicks === N`
- [ ] **E7.7** — Teste: colisão forçada (injetar `nanoid` mockado via decorator) → 409

**Conceito a registrar:** decorator injection vs mock de lib — por que preferimos o primeiro.

---

## Pós-v1 (viram estudos seguintes — **não fazer agora**)

- [ ] Autenticação de usuário (qual user criou o link)
- [ ] Rate limit (evitar abuse do POST)
- [ ] Analytics temporal (cliques por dia, geo)
- [ ] Custom slug (`{ url, slug: "meu-link" }`)
- [ ] Expiração de links
- [ ] Frontend que consome a API
- [ ] CI / lint / prettier
- [ ] Dockerfile + deploy

---

## Critérios de "v1 pronta" (do `project.md`)

- [ ] Todos os 4 endpoints respondem corretamente
- [ ] Todos os 4 casos de erro (400/404/409/500) retornam status + payload adequados
- [ ] Nenhum `try/catch` espalhado pelos controllers
- [ ] Nenhum stack trace vaza pro cliente
- [ ] Testes do E7 passam com `npm test`
- [ ] `routes.http` cobre fluxo feliz + 1 caso de erro por endpoint
- [ ] `notes.md` tem pelo menos 3 dúvidas que apareceram no caminho
- [ ] `cheatsheet.md` atualizado com o que aprendeu

---

## Como usar este arquivo

1. Marque `[x]` **só depois de commitar**.
2. Se travar num item, anote a dúvida em `notes.md` e siga — não fique parado.
3. Se um conceito novo aparecer que não está em `project.md`, adicione nesta lista como item extra **depois** de discutir comigo — não surta código.
4. Quando terminar a v1 inteira, este arquivo vira histórico.