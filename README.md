# 🔗 Linkly API

Uma API REST para encurtamento de URLs desenvolvida com **Node.js**, **Fastify** e **SQLite**.

Este projeto faz parte do meu estudo de backend, com foco em construção de APIs REST, validação de dados, persistência, tratamento de erros, testes automatizados e boas práticas de Git/GitHub.

---

## 🚀 Objetivos

- Construir uma API REST do zero.
- Aprender Fastify na prática.
- Trabalhar com SQLite via **Prisma ORM**.
- Aplicar validação utilizando JSON Schema.
- Implementar tratamento global de erros.
- Escrever testes com `node:test`.
- Praticar Git e GitHub utilizando um fluxo próximo ao de projetos reais.

---

## 🛠️ Tecnologias

- Node.js 22+
- TypeScript (strict, ESM)
- Fastify 5
- SQLite (gerenciado pelo Prisma)
- Prisma 7 (ORM e migrations)
- Nano ID
- JSON Schema
- node:test

---

## 📂 Estrutura do projeto

```
linkly-api/
├── src/
│   ├── server.ts        # bootstrap Fastify
│   ├── routes/          # registro de rotas (sem lógica)
│   ├── controllers/     # handlers HTTP (request/response)
│   ├── services/        # regras de negócio (orquestra Prisma)
│   ├── lib/             # cliente Prisma, error classes, error-handler
│   └── schemas/         # JSON Schemas
├── prisma/
│   ├── schema.prisma    # model Url
│   └── migrations/      # migrações versionadas
├── test/
├── routes.http
├── README.md
├── project.md
└── package.json
```

---

## 📌 Funcionalidades

- [ ] Criar URL encurtada
- [ ] Redirecionar utilizando o código curto
- [ ] Contabilizar acessos
- [ ] Consultar estatísticas
- [ ] Listar URLs cadastradas
- [ ] Validação com JSON Schema
- [ ] Tratamento global de erros
- [ ] Testes automatizados

---

## 📖 Aprendizados

Durante o desenvolvimento serão registrados estudos sobre:

- REST API
- Fastify
- SQLite
- JSON Schema
- Git
- GitHub
- Testes
- Arquitetura de projetos

---

## 📅 Roadmap

- [x] Configuração inicial
- [x] Servidor Fastify
- [x] Configurar TypeScript (strict + ESM)
- [x] Adicionar Prisma 7 e SQLite
- [x] Migration inicial do banco
- [ ] Repository / Service layer (`src/services/`)
- [ ] Endpoint `POST /urls`
- [ ] Endpoint `GET /:code`
- [ ] Endpoint `GET /urls/:code/stats`
- [ ] Error Handler
- [ ] Testes
- [ ] Publicação da versão `v1.0.0`

---

## 📄 Licença

Projeto desenvolvido exclusivamente para fins de estudo.
