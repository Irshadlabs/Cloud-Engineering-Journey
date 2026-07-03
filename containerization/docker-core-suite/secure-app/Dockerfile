# Stage 1: Build and Dependency Isolation Workspace
FROM node:20-alpine AS builder
WORKDIR /usr/src/app
COPY server.js ./
# In a real pipeline, dependency installation runs here (e.g., RUN npm ci --only=production)

# Stage 2: Minimalist Production Runtime Environment
FROM node:20-alpine
WORKDIR /app

# Enforce secure least-privilege boundaries by adding a non-root group and user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Extract only the necessary app artifact from the builder workspace stage
COPY --from=builder /usr/src/app/server.js ./

# Assign explicit file ownership permissions to the non-root execution agent
USER appuser

EXPOSE 8080
CMD ["node", "server.js"]
