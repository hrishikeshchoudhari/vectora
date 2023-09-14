defmodule Vectora.Repo.Migrations.CreateRacis do
  use ArangoXEcto.Migration
  alias Elixir.Vectora.Repo

  def up do
    create(collection(:racis))
  end
end
