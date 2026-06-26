---
name: setup-decisions
description: Decisões de setup do linkly — TypeScript vs JS, CommonJS vs ESM, tsx vs ts-node, dependências. Útil pra lembrar o "porquê" quando revisitarmos config.
metadata:
  type: project
---

# Setup decisions — linkly

## TypeScript (decisão do usuário em 2026-06-25)

**Por que:** usuário escolheu explicitamente "TypeScript (configurar direito agora)" quando eu apontei que o `src/server.ts` estava vazio mas o `package.json` era CommonJS sem `tsconfig.json`.

**Como aplicar:**
- `tsconfig.json` com `strict: true`, `target: "ES2022"`, `module: "ESNext"`, `moduleResolution: "Bundler"` (compatível com tsx).
- Dev runner: `tsx watch src/server.ts` — não `ts-node`, não `nodemon`.
- `"type": "module"` no `package.json` se quisermos ESM real; senão, tsx com `tsconfig` apontando pra CommonJS interop.
- **Decisão pendente:** ESM nativo vs CommonJS-interop. tsx aceita os dois. Vou perguntar quando formos configurar o tsconfig, ou seguir ESM (alinhado com o estudo anterior em 01-backend/ que já é ESM).

## Why: por que não seguir o plano original (JS + ESM)

O `../project.md` que eu escrevi na conversa anterior sugeria JS puro + ESM, alinhado com o estudo do usuário em `01-backend/server.js`. Mas o usuário bootstrapou como `.ts`. Mudar pra JS agora seria retrocesso — ele já decidiu TS. Adaptar o plano, não brigar com a decisão.

**How to apply:** quando eu for mostrar exemplos de código, usar `.ts` syntax (types nos params, generics do Fastify). Não usar `import` ESM se ele não configurou `"type": "module"` — verificar.

## Dependências pendentes

Já instalado:
- `fastify@^5.8.5`

A instalar:
- `better-sqlite3` — driver SQLite síncrono. Não precisa de `@types/better-sqlite3`? Sim, precisa. Adicionar junto.
- `nanoid` — short codes. Não precisa de types separados, tem próprios.
- Dev: `tsx`, `typescript`, `@types/node`.

## Como aplicar (próxima task de setup)

Quando instalar deps:
1. `npm install fastify` ✓ (já feito)
2. `npm install better-sqlite3 nanoid`
3. `npm install -D typescript tsx @types/node @types/better-sqlite3`
4. Criar `tsconfig.json` antes do primeiro código TS.
5. Atualizar scripts do `package.json`: `dev: "tsx watch src/server.ts"`, `typecheck: "tsc --noEmit"`, `test: "node --test --import tsx"` (ou similar).