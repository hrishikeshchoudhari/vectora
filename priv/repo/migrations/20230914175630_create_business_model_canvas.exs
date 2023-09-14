defmodule Vectora.Repo.Migrations.CreateBusinessModelCanvas do
  use ArangoXEcto.Migration
  alias Elixir.Vectora.Repo

  def up do
    create(collection(:business_model_canvas))
  end
end
