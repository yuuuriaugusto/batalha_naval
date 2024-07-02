defmodule BatalhaNaval.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :status, :string
    field :turns_played, :integer

    has_many :players, BatalhaNaval.Games.Player
    has_many :ships, BatalhaNaval.Games.Ship

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:turns_played, :status])
    |> validate_required([:turns_played, :status])
  end
end
