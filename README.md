# 🔗 Linkly API

Uma API REST para encurtamento de URLs desenvolvida com **Node.js**, **Fastify** e **SQLite**.

Este projeto faz parte do meu estudo de backend, com foco em construção de APIs REST, validação de dados, persistência, tratamento de erros, testes automatizados e boas práticas de Git/GitHub.

---

## 🚀 Objetivos

- Construir uma API REST do zero.
- Aprender Fastify na prática.
- Trabalhar com SQLite usando `better-sqlite3`.
- Aplicar validação utilizando JSON Schema.
- Implementar tratamento global de erros.
- Escrever testes com `node:test`.
- Praticar Git e GitHub utilizando um fluxo próximo ao de projetos reais.

---

## 🛠️ Tecnologias

- Node.js 22+
- Fastify
- SQLite
- better-sqlite3
- Nano ID
- JSON Schema
- node:test

---

## 📂 Estrutura do projeto

```
linkly-api/
├── src/
│   ├── database/
│   ├── plugins/
│   ├── routes/
│   ├── schemas/
│   └── server.js
├── test/
├── routes.http
├── README.md
├── notes.md
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

- [ ] Configuração inicial
- [ ] Servidor Fastify
- [ ] Banco SQLite
- [ ] Repository Pattern
- [ ] Endpoint `POST /urls`
- [ ] Endpoint `GET /:code`
- [ ] Endpoint `GET /urls/:code/stats`
- [ ] Error Handler
- [ ] Testes
- [ ] Publicação da versão `v1.0.0`

---

## 📄 Licença

Projeto desenvolvido exclusivamente para fins de estudo.
