defmodule BatalhaNaval.GamesTest do
  use BatalhaNaval.DataCase

  alias BatalhaNaval.Games

  describe "games" do
    alias BatalhaNaval.Games.Game

    import BatalhaNaval.GamesFixtures

    @invalid_attrs %{status: nil, turns_played: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{status: "some status", turns_played: 42}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.status == "some status"
      assert game.turns_played == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{status: "some updated status", turns_played: 43}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.status == "some updated status"
      assert game.turns_played == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "players" do
    alias BatalhaNaval.Games.Player

    import BatalhaNaval.GamesFixtures

    @invalid_attrs %{name: nil}

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Games.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Games.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Player{} = player} = Games.create_player(valid_attrs)
      assert player.name == "some name"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Player{} = player} = Games.update_player(player, update_attrs)
      assert player.name == "some updated name"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_player(player, @invalid_attrs)
      assert player == Games.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Games.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Games.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Games.change_player(player)
    end
  end

  describe "ships" do
    alias BatalhaNaval.Games.Ship

    import BatalhaNaval.GamesFixtures

    @invalid_attrs %{position: nil, size: nil, type: nil}

    test "list_ships/0 returns all ships" do
      ship = ship_fixture()
      assert Games.list_ships() == [ship]
    end

    test "get_ship!/1 returns the ship with given id" do
      ship = ship_fixture()
      assert Games.get_ship!(ship.id) == ship
    end

    test "create_ship/1 with valid data creates a ship" do
      valid_attrs = %{position: "some position", size: 42, type: "some type"}

      assert {:ok, %Ship{} = ship} = Games.create_ship(valid_attrs)
      assert ship.position == "some position"
      assert ship.size == 42
      assert ship.type == "some type"
    end

    test "create_ship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_ship(@invalid_attrs)
    end

    test "update_ship/2 with valid data updates the ship" do
      ship = ship_fixture()
      update_attrs = %{position: "some updated position", size: 43, type: "some updated type"}

      assert {:ok, %Ship{} = ship} = Games.update_ship(ship, update_attrs)
      assert ship.position == "some updated position"
      assert ship.size == 43
      assert ship.type == "some updated type"
    end

    test "update_ship/2 with invalid data returns error changeset" do
      ship = ship_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_ship(ship, @invalid_attrs)
      assert ship == Games.get_ship!(ship.id)
    end

    test "delete_ship/1 deletes the ship" do
      ship = ship_fixture()
      assert {:ok, %Ship{}} = Games.delete_ship(ship)
      assert_raise Ecto.NoResultsError, fn -> Games.get_ship!(ship.id) end
    end

    test "change_ship/1 returns a ship changeset" do
      ship = ship_fixture()
      assert %Ecto.Changeset{} = Games.change_ship(ship)
    end
  end
end
