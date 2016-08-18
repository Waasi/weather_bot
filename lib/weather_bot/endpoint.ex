defmodule WeatherBot.Endpoint do
  use Phoenix.Endpoint, otp_app: :weather_bot

  socket "/socket", WeatherBot.UserSocket

  plug Plug.Static,
    at: "/", from: :weather_bot, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_weather_bot_key",
    signing_salt: "dygXVRe+"

  plug WeatherBot.Router
end
