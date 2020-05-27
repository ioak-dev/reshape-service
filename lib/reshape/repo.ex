defmodule Reshape.Repo do
  use Ecto.Repo,
    otp_app: :reshape,
    adapter: Ecto.Adapters.Postgres
end
