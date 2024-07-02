defmodule BatalhaNaval.Repo do
  use Ecto.Repo,
    otp_app: :batalha_naval,
    adapter: Ecto.Adapters.Postgres
end
