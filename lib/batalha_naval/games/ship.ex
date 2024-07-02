defmodule BatalhaNaval.Games.Ship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ships" do
    field :position, :string
    field :size, :integer
    field :type, :string
    belongs_to :game, BatalhaNaval.Games.Game
    belongs_to :player, BatalhaNaval.Games.Player
    # field :game_id, :id
    # field :player_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ship, attrs) do
    ship
    |> cast(attrs, [:type, :size, :position, :game_id, :player_id])
    |> validate_required([:type, :size, :position, :game_id, :player_id])
  end
end
