use Mix.Config

config :weather_bot, WeatherBot.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "https://safe-stream-88823.herokuapp.com", port: 443],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :weather_bot, WeatherBot.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

# Do not print debug messages in production
config :logger, level: :info
