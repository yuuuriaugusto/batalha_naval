defmodule BatalhaNaval.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :turns_played, :integer
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
