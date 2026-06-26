---
name: working-agreement
description: Como vamos trabalhar juntos no linkly. Ritmo, formato de review, quando parar pra checar notas vs quando seguir codando.
metadata:
  type: feedback
---

# Working agreement — linkly

## Ritmo

- **Uma task por vez.** Quando terminar uma, paramos pra eu revisar antes de ir pra próxima.
- **Code review a cada commit** (ou pelo menos a cada "exercício" do `../project.md`).
- **Não acumular débitos:** se eu notar algo fora do escopo do exercício atual (ex: "isso devia ter testes"), anoto em [[linkly-overview]] como "próximo passo" em vez de fazer agora.

## Why

O usuário pediu pra "entrar no flow comigo" — isso significa colaboração contínua, não entrega de projeto inteiro. Forçar o ritmo dele em 7 exercícios seguidos = ignorar o pedido. Ritmo de uma coisa por vez = fluxo.

## How to apply

Quando o usuário disser coisas como:
- "terminei o X" → revisar X, atualizar [[linkly-overview]] com status, sugerir próximo.
- "vou implementar Y" → checar se Y está no escopo da v1. Se não (ex: auth, rate limit), lembrar que vira estudo seguinte.
- "como faz Z?" → explicar o conceito do Fastify primeiro, dar exemplo de código, deixar ele adaptar (não dar copy-paste).
- "tá pronto o linkly?" → voltar nos critérios de "pronto" do `../project.md` seção 8, não no que parece pronto.

## Formato de code review

- **Sempre apontar o que está bom antes do que mudar.** Razão: começar com crítica = desmotivação. Começar com o que funciona = ele sabe o que preservar.
- **Distinguir "bloqueador" de "sugestão".** Bloqueador = quebra spec, gera bug, viola padrão já estabelecido. Sugestão = melhoria de estilo, performance, futuro.
- **Citar linha** (`server.ts:12`) quando possível.

## O que NÃO fazer

- Não criar arquivos além dos que o usuário pediu (ex: ele não pediu Dockerfile, CI, lint config — não criar).
- Não instalar deps não combinadas.
- Não escrever testes antes dele pedir.
- Não "melhorar" código dele sem ele pedir ("tá meio verboso, refatora pra X" — a menos que seja bloqueador real).
- Não fingir que está tudo ok. Se o `src/server.ts` estava vazio, eu disse.