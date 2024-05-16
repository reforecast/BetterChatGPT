FROM node:alpine AS builder

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

FROM node:alpine

WORKDIR /app
COPY --from=builder /app/dist .
COPY public/. .

RUN npm install -g http-server

EXPOSE 80

CMD ["http-server", "-p", "80", "-a", "0.0.0.0"]
