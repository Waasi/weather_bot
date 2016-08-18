# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :weather_bot,
  ecto_repos: [WeatherBot.Repo]

# Configures the endpoint
config :weather_bot, WeatherBot.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zJvFvuTLTahiLJBfJVXXpluIrnyp7iorjN34TkULBbO968Pvat+ve5U6af2MlIqJ",
  render_errors: [view: WeatherBot.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WeatherBot.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
import_config "../deps/juracan/config/config.exs"
