defmodule WeatherBot.Repo.Migrations.CreateBot do
  use Ecto.Migration

  def change do
    create table(:bots) do
      add :slack_token, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:bots, [:slack_token])
  end
end
