defmodule WeatherBot.BotControllerTest do
  use WeatherBot.ConnCase

  alias WeatherBot.Bot
  @valid_attrs %{name: "some content", slack_token: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bot_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing bots"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bot_path(conn, :new)
    assert html_response(conn, 200) =~ "New bot"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bot_path(conn, :create), bot: @valid_attrs
    assert redirected_to(conn) == bot_path(conn, :index)
    assert Repo.get_by(Bot, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bot_path(conn, :create), bot: @invalid_attrs
    assert html_response(conn, 200) =~ "New bot"
  end

  test "shows chosen resource", %{conn: conn} do
    bot = Repo.insert! %Bot{}
    conn = get conn, bot_path(conn, :show, bot)
    assert html_response(conn, 200) =~ "Show bot"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bot_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bot = Repo.insert! %Bot{}
    conn = get conn, bot_path(conn, :edit, bot)
    assert html_response(conn, 200) =~ "Edit bot"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bot = Repo.insert! %Bot{}
    conn = put conn, bot_path(conn, :update, bot), bot: @valid_attrs
    assert redirected_to(conn) == bot_path(conn, :show, bot)
    assert Repo.get_by(Bot, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bot = Repo.insert! %Bot{}
    conn = put conn, bot_path(conn, :update, bot), bot: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bot"
  end

  test "deletes chosen resource", %{conn: conn} do
    bot = Repo.insert! %Bot{}
    conn = delete conn, bot_path(conn, :delete, bot)
    assert redirected_to(conn) == bot_path(conn, :index)
    refute Repo.get(Bot, bot.id)
  end
end
