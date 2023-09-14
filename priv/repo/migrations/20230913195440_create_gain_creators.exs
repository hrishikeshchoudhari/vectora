defmodule Vectora.Repo.Migrations.CreateGainCreators do
  use ArangoXEcto.Migration
  alias Elixir.Vectora.Repo

  def up do
    create(collection(:gain_creators))
  end
end
