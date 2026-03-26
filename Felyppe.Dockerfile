FROM elixir:1.15-alpine AS builder

# deps de compilação
RUN apk add --no-cache build-base git

WORKDIR /app
ENV MIX_ENV=prod

RUN mix local.hex --force && \
    mix local.rebar --force

# copia manifests primeiro pra aproveitar cache
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

COPY . .
RUN mix release

# imagem final só com o necessário pra rodar
FROM alpine:3.12

# libs que o erlang precisa
RUN apk add --no-cache libgcc libstdc++ openssl ncurses-libs

WORKDIR /app
COPY --from=builder /app/_build/prod/rel/calculadora_api ./

EXPOSE 8080
CMD ["bin/calculadora_api", "start"]