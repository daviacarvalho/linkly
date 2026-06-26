import { fastify } from "fastify";

const server = fastify();

server.get("/", (request, reply) => {
  return reply.send("Hello World");
});

server.listen({
  port: 3333,
});

console.log("Server running: http://localhost:3333");
