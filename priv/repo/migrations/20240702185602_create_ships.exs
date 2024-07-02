defmodule BatalhaNaval.Repo.Migrations.CreateShips do
  use Ecto.Migration

  def change do
    create table(:ships) do
      add :type, :string
      add :size, :integer
      add :position, :string
      add :game_id, references(:games, on_delete: :nothing)
      add :player_id, references(:players, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:ships, [:game_id])
    create index(:ships, [:player_id])
  end
end
