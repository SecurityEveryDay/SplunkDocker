#!/bin/bash

# -----------------------------
# Função para validar dependências
# -----------------------------
check_dependencies() {
    echo "🔍 Verificando dependências..."

    if ! command -v docker &> /dev/null; then
        echo "⚠ Docker não encontrado. Instalando..."
        apt update && apt install docker.io -y
    else
        echo "✔ Docker já está instalado."
    fi

    if ! command -v docker-compose &> /dev/null; then
        echo "⚠ Docker Compose não encontrado. Instalando..."
        apt update && apt install docker-compose -y
    else
        echo "✔ Docker Compose já está instalado."
    fi
}

# -----------------------------
# Execução principal
# -----------------------------

check_dependencies

case "$1" in
    "")
        echo "Nenhum parâmetro informado. Subindo aplicação..."
        docker-compose up --build -d
        ;;
    --reset)
        echo "Parâmetro '--reset' detectado. Resetando o ambiente..."
        docker-compose down -v && docker-compose up --build -d
        ;;
    *)
        echo "❌ Parâmetro inválido: $1"
        echo "Uso correto:"
        echo "  ./script.sh            -> Sobe o ambiente"
        echo "  ./script.sh --reset    -> Reseta o ambiente"
        exit 1
        ;;
esac
