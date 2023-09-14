defmodule Vectora.Repo.Migrations.CreateValuePropositions do
  use ArangoXEcto.Migration
  alias Elixir.Vectora.Repo

  def up do
    create(collection(:value_propositions))
  end
end
