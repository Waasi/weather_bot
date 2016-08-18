defmodule WeatherBot.Bot do
  use WeatherBot.Web, :model

  schema "bots" do
    field :slack_token, :string
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:slack_token, :name])
    |> unique_constraint(:slack_token)
    |> validate_required([:slack_token, :name])
  end
end
