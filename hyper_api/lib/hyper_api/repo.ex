defmodule HyperApi.Repo do
  use Ecto.Repo,
    otp_app: :hyper_api,
    adapter: Ecto.Adapters.Postgres
end
