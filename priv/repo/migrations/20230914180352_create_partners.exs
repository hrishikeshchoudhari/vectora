defmodule Vectora.Repo.Migrations.CreatePartners do
  use ArangoXEcto.Migration
  alias Elixir.Vectora.Repo

  def up do
    create(collection(:partners))
  end
end
