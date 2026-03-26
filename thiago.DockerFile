# Usa a menor imagem que eu achei do elixir
FROM elixir:1.15-alpine AS build
WORKDIR /app
# Instala as dependências necessárias para compilar a aplicação
RUN apk add --no-cache build-base openssl-dev

COPY mix.exs ./
# Instala as dependências da aplicação
RUN mix local.hex --force && mix local.rebar --force
# Instala apenas as dependências de produção, ignorando as de desenvolvimento e teste
RUN MIX_ENV=prod mix deps.get --only prod

COPY . .
# Compila a aplicação e gera o release
RUN MIX_ENV=prod mix compile
RUN MIX_ENV=prod mix release --overwrite

# Faz multi-stage 
# Usa a menor imagem que eu achei do alpine
FROM alpine:3.18 AS prod
# Instala as dependências necessárias para rodar a aplicação
RUN apk add --no-cache openssl ncurses-libs libgcc libstdc++
WORKDIR /app
# Copia o release gerado na etapa de build para a imagem final
COPY --from=build /app/_build/prod/rel/calculadora_api ./

# Define as variáveis de ambiente
ENV MIX_ENV=prod
ENV REPLACE_OS_VARS=true

EXPOSE 8080
CMD ["./bin/calculadora_api", "start"]