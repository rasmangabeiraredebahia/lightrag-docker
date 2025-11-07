# Este Dockerfile constrói o LightRAG Server a partir do código-fonte:
#  - Instala Python e dependências de sistema
#  - Clona o repositório oficial
#  - Instala LightRAG com suporte a API
#  - Compila o front-end com Bun
#  - Inicia o servidor web do LightRAG

FROM python:3.11-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Dependências de sistema necessárias para compilar e rodar
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl unzip build-essential ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Instala Bun para construir o front-end
RUN curl -fsSL https://bun.sh/install | bash && \
    ln -s /root/.bun/bin/bun /usr/local/bin/bun && \
    ln -s /root/.bun/bin/bunx /usr/local/bin/bunx

# Diretório de trabalho
WORKDIR /app

# Clona o repositório LightRAG
RUN git clone https://github.com/HKUDS/LightRAG.git /app/LightRAG

# Instala LightRAG (modo editável) com suporte de API
WORKDIR /app/LightRAG
RUN pip install --no-cache-dir -e ".[api]"

# Compila os artefatos do front-end
WORKDIR /app/LightRAG/lightrag_webui
RUN bun install --frozen-lockfile && bun run build

# Volta para a raiz do projeto
WORKDIR /app/LightRAG

# Copia env.example como .env se não existir (será sobrescrito pelo volume do compose)
RUN cp -n env.example .env || true

# Expõe a porta padrão da aplicação
EXPOSE 8000

# Comando para iniciar o servidor
CMD ["lightrag-server"]