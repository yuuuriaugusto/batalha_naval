defmodule BatalhaNaval.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BatalhaNaval.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        status: "some status",
        turns_played: 42
      })
      |> BatalhaNaval.Games.create_game()

    game
  end

  @doc """
  Generate a player.
  """
  def player_fixture(attrs \\ %{}) do
    {:ok, player} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> BatalhaNaval.Games.create_player()

    player
  end

  @doc """
  Generate a ship.
  """
  def ship_fixture(attrs \\ %{}) do
    {:ok, ship} =
      attrs
      |> Enum.into(%{
        position: "some position",
        size: 42,
        type: "some type"
      })
      |> BatalhaNaval.Games.create_ship()

    ship
  end
end
