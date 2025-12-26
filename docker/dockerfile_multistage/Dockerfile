# ---------- STAGE 1: builder ----------

FROM node:18 AS builder

WORKDIR /app

COPY src/package.json ./

RUN npm install

COPY src/ . 


# ---------- STAGE 2: runtime ----------

FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000

CMD ["npm", "start"] 