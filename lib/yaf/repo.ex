defmodule Yaf.Repo do
  use Ecto.Repo,
    otp_app: :yaf,
    adapter: Ecto.Adapters.Postgres
end
