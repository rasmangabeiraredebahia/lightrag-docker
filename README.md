# Ambiente Docker para LightRAG (OpenAI)

Este projeto provisiona um ambiente completo com Docker Compose para executar o **LightRAG** (UI e API) usando **OpenAI** como provedor de LLM e embeddings via API.

## Estrutura

- `Dockerfile`: constrói o LightRAG Server a partir do código-fonte oficial
- `docker-compose.yml`: sobe apenas o serviço `lightrag` (sem Ollama)
- `env/.env`: configurações de LLM, embeddings e rede, incluindo `OPENAI_API_KEY`
- `data/lightrag`: dados/resultados do LightRAG

## Pré-requisitos

- macOS com Docker Desktop instalado
- Chave válida da OpenAI (`OPENAI_API_KEY`)
- Internet para baixar dependências

## Configuração

1. Edite o arquivo `env/.env` e insira sua chave de API da OpenAI:
   
   ```env
   # Este arquivo .env configura o LightRAG para usar a OpenAI via API,
   # além de modelos de embedding da OpenAI (text-embedding-3-large).
   # Substitua a chave abaixo pela sua chave real da OpenAI.
   OPENAI_API_KEY=coloque_sua_chave_aqui
   LLM_PROVIDER=openai
   LLM_MODEL=gpt-4o
   EMBEDDING_PROVIDER=openai
   EMBEDDING_MODEL=text-embedding-3-large
   RERANKER_PROVIDER=none
   PORT=8000
   HOST=0.0.0.0
   ```

2. (Opcional) Se usar um proxy compatível com OpenAI, defina `OPENAI_BASE_URL`.

## Como executar

1. Suba o serviço:
   
   ```bash
   docker compose up --build
   ```

2. Acesse a UI:
   - `http://localhost:8000`

## Observações

- O LightRAG recomenda modelos com grande capacidade para melhor indexação. A configuração acima usa `gpt-4o` (OpenAI) e o melhor embedding disponível `text-embedding-3-large` para qualidade superior.
- Você pode alterar o modelo de LLM e/ou embedding ajustando o `.env` conforme necessidade.

## Referência

- Repositório oficial: https://github.com/HKUDS/LightRAG