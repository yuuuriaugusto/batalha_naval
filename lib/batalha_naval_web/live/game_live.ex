defmodule BatalhaNavalWeb.GameLive do
  use BatalhaNavalWeb, :live_view

  alias BatalhaNaval.Games
  alias BatalhaNaval.Games.Ship
  import Ecto.Query, only: [preload: 2] # Importe a função preload

  def mount(%{"id" => game_id}, _session, socket) do
    game = Games.get_game!(game_id) |> preload([:players, :ships])
    player_index = if(length(game.players) == 1, do: 2, else: 1)
    player = Games.get_player_by_game(game.id, player_index)
    ships = ship_list()

    # Crie o board aqui:
    board = create_board()

    {:ok,
      assign(socket,
        game: game,
        player: player,
        ships: ships,
        board: board
      )
    }
  end

  def handle_event("set_ship", %{"ship_index" => ship_index, "x" => x, "y" => y, "orientation" => orientation} = _params, socket) do
    # Apenas para fins de demonstração, vamos definir a posição do navio como uma string "x,y,orientation"
    position = "#{x},#{y},#{orientation}"
    index = String.to_integer(ship_index)
    ship_type = Enum.at(ship_list(), index).type
    size = Enum.at(ship_list(), index).size

    {:ok, _ship} =
      Games.create_ship(%{
        type: ship_type,
        size: size,
        position: position,
        game_id: socket.assigns.game.id,
        player_id: socket.assigns.player.id
      })

    # Remova o navio da lista de navios disponíveis
    updated_ships = List.delete_at(socket.assigns.ships, index)

    # Atualize o socket com o novo navio e a lista de navios atualizada
    {:noreply, assign(socket, ships: updated_ships)}
  end

  def handle_event("change_player", _params, socket) do
    game = socket.assigns.game
    player_index = if(socket.assigns.player.id == 1, do: 2, else: 1)

    player = Games.get_player_by_game(game.id, player_index)
    ships =  Games.list_ships(game)

    {:noreply, assign(socket, player: player, ships: ships)}
  end

  def handle_event("attack", %{"x" => x, "y" => y}, socket) do
    # Converte as coordenadas para inteiros
    x = String.to_integer(x)
    y = String.to_integer(y)

    # Lógica para processar o ataque
    new_board = update_board(socket.assigns.board, x, y)
    {:noreply, assign(socket, board: new_board)}
  end

  defp ship_list() do
    [
      %{ type: "Porta-Aviões", size: 5 },
      %{ type: "Encouraçado", size: 4 },
      %{ type: "Cruzador", size: 3 },
      %{ type: "Submarino", size: 3 },
      %{ type: "Destroyer", size: 2 }
    ]
  end

  # Função auxiliar para criar um novo tabuleiro
  defp create_board() do
    for _ <- 1..10, do: for(_ <- 1..10, do: %{})
  end

  # Função auxiliar para atualizar o tabuleiro com um ataque
  defp update_board(board, x, y) do
    List.update_at(board, y - 1, fn row ->
      List.update_at(row, x - 1, fn cell ->
        Map.put(cell, :attacked, true)
      end)
    end)
  end

  # Função que verifica se todos os navios foram afundados
  def game_over?(game) do
    # Percorre os jogadores (vamos assumir que são apenas dois por enquanto)
    Enum.any?(game.players, fn player ->
      # Verifica se todos os navios do jogador foram afundados
      all_ships_sunk?(game, player.id)
    end)
  end

  defp all_ships_sunk?(game, player_id) do
    # Obtém todos os navios do jogador
    player_ships = Enum.filter(game.ships, &(&1.player_id == player_id))

    # Verifica se todos os navios estão afundados
    Enum.all?(player_ships, fn ship ->
      ship_position = String.split(ship.position, ",") |> Enum.map(&String.to_integer/1)
      ship_x = Enum.at(ship_position, 0)
      ship_y = Enum.at(ship_position, 1)
      orientation = Enum.at(ship_position, 2)

      case orientation do
        "horizontal" ->
          Enum.all?(ship_x..(ship_x + ship.size - 1), fn cell_x ->
            cell = Enum.at(Enum.at(game.board, ship_y - 1), cell_x - 1)
            cell[:attacked] == true
          end)

        "vertical" ->
          Enum.all?(ship_y..(ship_y + ship.size - 1), fn cell_y ->
            cell = Enum.at(Enum.at(game.board, cell_y - 1), ship_x - 1)
            cell[:attacked] == true
          end)

      _   ->
          false
      end
    end)
  end

  # Função do ganhador
  def winner(game) do
    case game_over?(game) do
      true ->
        # Se o jogo acabou, encontre o jogador com todos os navios afundados
        Enum.find(game.players, fn player ->
          all_ships_sunk?(game, player.id)
        end)
      false ->
        # Se o jogo não acabou, não há vencedor ainda
        nil
    end
  end

  def render_cell(cell, show_ship \\ false) do
    case cell do
      %{attacked: true, result: :hit} -> "🔥" # Célula atacada com navio
      %{attacked: true, result: :miss} -> "🌊" # Célula atacada sem navio
      %{ship: true} when show_ship -> "🚢" # Célula com navio (apenas para o dono)
      _ -> " " # Célula vazia
    end
  end
  def cell_style(cell) do
    # Por enquanto, retorna um estilo vazio
    ""
  end
end
