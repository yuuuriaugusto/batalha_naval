defmodule BatalhaNavalWeb.PageLive do
  use BatalhaNavalWeb, :live_view
  # alias BatalhaNavalWeb.Router.Helpers, as: Routes



  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       game: nil,
       player1_name: "",
       player2_name: ""
     )}
  end

  def handle_event("start_game", %{"player1_name" => player1_name, "player2_name" => player2_name}, socket) do
    game = create_game(player1_name, player2_name)
    {:noreply, push_redirect(socket, to: ~p"/games/#{game.id}")}
    # path = Routes.game_path(socket, :show, game.id)
    # {:noreply, socket}
    # {:noreply, live_redirect(socket, to: Routes.game_path(socket, :show, game.id))}
    # {:ok, redirect(socket, to: Routes.game_path(socket, :show, game.id))}
  end

  defp create_game(player1_name, player2_name) do
    {:ok, game} =
      BatalhaNaval.Games.create_game(%{
        status: "Em andamento",
        turns_played: 0
      })

    {:ok, _player1} =
      BatalhaNaval.Games.create_player(%{
        name: player1_name,
        game_id: game.id
      })

    {:ok, _player2} =
      BatalhaNaval.Games.create_player(%{
        name: player2_name,
        game_id: game.id
      })

    game
  end
end
