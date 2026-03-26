FROM elixir:1.14-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force

COPY mix.exs ./
RUN MIX_ENV=prod mix deps.get --only prod

COPY lib ./lib
RUN MIX_ENV=prod mix do compile, release

FROM gcr.io/distroless/cc-debian12

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/calculadora_api ./

EXPOSE 8080

USER nonroot:nonroot

CMD ["bin/calculadora_api", "start"]
