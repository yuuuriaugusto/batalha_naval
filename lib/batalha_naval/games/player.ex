defmodule BatalhaNaval.Games.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :name, :string
    # field :game_id, :id
    belongs_to :game, BatalhaNaval.Games.Game

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :game_id])
    |> validate_required([:name, :game_id])
  end
end
