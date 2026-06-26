---
name: linkly-overview
description: Encurtador de URLs em Fastify + SQLite. Projeto de estudo dentro do roadmap back-to-fullstack. Escopo fechado: 3 endpoints + lista debug.
metadata:
  type: project
---

# Linkly

Encurtador de URLs — projeto de estudo do [[back-to-fullstack]]/01-backend.

## Posição no roadmap

Subprojeto dentro de `01-backend/`. Referência teórica: `../project.md` (criado na conversa anterior à criação do linkly). O `README.md` do linkly é a versão "pública" do mesmo plano — ele está bem escrito, vale atualizar lá também quando o escopo mudar.

## Stack (decidida em conversa 2026-06-25)

- **TypeScript** (não JS como o `../project.md` sugeria) — usuário escolheu configurar TS direito.
- **Fastify 5** com `@fastify/type-provider-typebox` ainda não decidido (ver [[setup-decisions]]).
- **SQLite via better-sqlite3** — síncrono, arquivo local.
- **nanoid** para short codes.
- **node:test** para testes.
- **`tsx`** como dev runner (`npm run dev`), compilação via `tsc` só para checar tipos (ainda não decidido se builda).

## Escopo da v1 (do `../project.md`)

| Método | Rota                | Resposta                                                |
|--------|---------------------|---------------------------------------------------------|
| POST   | `/urls`             | 201 + `{ shortCode, shortUrl, originalUrl, createdAt }` |
| GET    | `/:code`            | 301 redirect + incrementa cliques                       |
| GET    | `/urls/:code/stats` | 200 + `{ shortCode, originalUrl, clicks, createdAt }`   |
| GET    | `/urls`             | lista (debug, remover depois)                           |

Erros: 400 (body inválido), 404 (código inexistente), 409 (colisão após retries), 500 (erro de banco).

**Por que isso importa:** o projeto cobre 4 tópicos do `01-backend/README.md` — Framework web (Fastify), Validação (JSON Schema), REST, Tratamento de erros.

## Status atual (2026-06-25)

- Commit zero feito: README, .gitignore, package.json (CJS!), src/server.ts **vazio**.
- Nada de código ainda. Estamos subindo o servidor mínimo.
- **Why:** o usuário pediu pra "entrar no flow" depois de bootstrappear. Não tem código pra revisar ainda — só plano.

## Como aplicar

Quando ele voltar dizendo "vamos para o próximo endpoint" ou "vou implementar X", checar antes:
1. Estamos no Exercício N do `../project.md`?
2. Os critérios de "pronto" do Exercício N-1 foram cumpridos?
3. O que ele anotou em `notes.md` desde a última vez? (Ainda não existe.)

Se ele desviar do escopo (auth, rate limit, frontend), lembrar gentilmente que isso vira estudo seguinte — não inlinear no linkly.