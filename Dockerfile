# Dockerfile para aplicação Go
FROM golang:1.23-alpine AS builder

WORKDIR /app

# Copia os arquivos de dependência
COPY go.mod go.sum ./
RUN go mod download

# Copia o código fonte
COPY . .

# Compila a aplicação
RUN go build -o main .

# Imagem final menor
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copia o binário compilado
COPY --from=builder /app/main .

# Expõe a porta que a aplicação usa (geralmente 8080 para Go)
EXPOSE 8080

# Comando para executar a aplicação
CMD ["./main"]