-- CreateTable
CREATE TABLE "urls" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "shortCode" TEXT NOT NULL,
    "originalUrl" TEXT NOT NULL,
    "clicks" INTEGER NOT NULL DEFAULT 0,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE UNIQUE INDEX "urls_shortCode_key" ON "urls"("shortCode");

-- CreateIndex
CREATE INDEX "urls_shortCode_idx" ON "urls"("shortCode");
