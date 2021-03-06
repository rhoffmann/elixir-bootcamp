FROM bitwalker/alpine-elixir-phoenix:latest as build

EXPOSE 5000
ENV PORT=5000 MIX_ENV=prod

ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

ADD assets/package.json assets/
RUN cd assets && \
  npm install

ADD . .

RUN cd assets/ && \
  npm run deploy && \
  cd - && \
  mix do compile, phx.digest

USER default

CMD ["mix", "phx.server"]