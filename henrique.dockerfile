
FROM elixir:1.14-alpine AS henrique

ENV MIX_ENV=prod

WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix deps.get --only prod
RUN mix deps.compile

COPY lib lib

RUN mix compile
RUN mix release

FROM alpine:3.20

WORKDIR /app

RUN apk add --no-cache libstdc++ openssl ncurses-libs

COPY --from=henrique /app/_build/prod/rel/calculadora_api ./

EXPOSE 8080

CMD ["bin/calculadora_api", "start"]