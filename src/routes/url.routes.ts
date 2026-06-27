import type { FastifyInstance } from "fastify";

export async function urlRoutes(app: FastifyInstance) {
  app.get("/urls", async () => {
    return {
      message: "urls resource is alive",
      data: [],
    };
  });
}