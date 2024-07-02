defmodule BatalhaNaval.Board do
  @grid_size 10

  def new() do
    for _y <- 1..@grid_size, do: for(_x <- 1..@grid_size, do: :empty)
  end
end
