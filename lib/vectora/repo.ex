defmodule Vectora.Repo do
  use Ecto.Repo,
    otp_app: :vectora,
    adapter: ArangoXEcto.Adapter
end
