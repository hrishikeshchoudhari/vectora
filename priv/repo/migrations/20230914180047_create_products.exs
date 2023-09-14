defmodule Vectora.Repo.Migrations.CreateProducts do
  use ArangoXEcto.Migration
  alias Elixir.Vectora.Repo

  def up do
    create(collection(:products))
  end
end
