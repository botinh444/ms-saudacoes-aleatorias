# Estágio de build
FROM golang:1.23-alpine AS builder

WORKDIR /app

# Copia os arquivos de módulo
COPY go.mod ./
COPY main.go ./

# Compila a aplicação
RUN go build -o main .

# Estágio final
FROM alpine:latest

WORKDIR /root/

# Copia o binário compilado
COPY --from=builder /app/main .

# Expõe a porta
EXPOSE 8080

# Executa a aplicação
CMD ["./main"]