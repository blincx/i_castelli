defmodule Ic.Repo do
  use Ecto.Repo,
    otp_app: :ic,
    adapter: Ecto.Adapters.Postgres
end
