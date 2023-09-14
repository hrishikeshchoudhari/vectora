defmodule Vectora.Repo.Migrations.CreatePainKillers do
  use ArangoXEcto.Migration
  alias Elixir.Vectora.Repo

  def up do
    create(collection(:pain_killers))
  end
end
