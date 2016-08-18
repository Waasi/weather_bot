defmodule WeatherBot.BotController do
  use WeatherBot.Web, :controller

  alias WeatherBot.Bot
  alias Juracan.WeatherWorker

  def new(conn, _params) do
    changeset = Bot.changeset(%Bot{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bot" => bot_params}) do
    changeset = Bot.changeset(%Bot{}, bot_params)

    case Repo.insert(changeset) do
      {:ok, bot} ->
        conn
        |> put_flash(:info, "Bot created successfully.")
        |> redirect(to: "/bots/#{bot.slack_token}")
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => slack_token}) do
    bot = Repo.get_by!(Bot, slack_token: slack_token)
    render(conn, "show.html", bot: bot)
  end

  def edit(conn, %{"id" => slack_token}) do
    bot = Repo.get_by!(Bot, slack_token: slack_token)
    changeset = Bot.changeset(bot)
    render(conn, "edit.html", bot: bot, changeset: changeset)
  end

  def update(conn, %{"id" => slack_token, "bot" => bot_params}) do
    bot = Repo.get_by!(Bot, slack_token: slack_token)
    changeset = Bot.changeset(bot, bot_params)

    case Repo.update(changeset) do
      {:ok, bot} ->
        conn
        |> put_flash(:info, "Bot updated successfully.")
        |> redirect(to: "/bots/#{bot.slack_token}")
      {:error, changeset} ->
        render(conn, "edit.html", bot: bot, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => slack_token}) do
    bot = Repo.get_by!(Bot, slack_token: slack_token)

    Repo.delete!(bot)

    conn
    |> put_flash(:info, "Bot deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end

  def ask(conn, %{"token" => slack_token, "text" => location}) do
    bot = Repo.get_by!(Bot, slack_token: slack_token)
    unless bot, do: text conn, ""

    result = WeatherWorker.report(location)

    case result do
      {:ok, report} ->
        text conn, report
      {:error, msg} ->
        text conn, msg
    end
  end
end
