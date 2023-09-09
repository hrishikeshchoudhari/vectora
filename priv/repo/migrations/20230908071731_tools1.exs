defmodule Vectora.Repo.Migrations.Tools1 do
  use ArangoXEcto.Migration
  alias Elixir.Vectora.Repo

  def up do
    # Add actions for `up` action. Refer to `ArangoXEcto.Migration` for usage here.
    create(collection(:business_model_canvas))
    create(collection(:value_propositions))
    create(collection(:partners))
    create(collection(:products))
    create(collection(:racis))
    create(collection(:gain_creators))
    create(collection(:pain_killers))

    # create(index("users", [:email]))
  end

  def down do
    # Add actions for `down` action. Refer to `ArangoXEcto.Migration` for usage here.
    # NOTE: If a collection is dropped you do not need to drop the index also as it will be removed automatically.
    drop(collection(:business_model_canvas))
    drop(collection(:value_propositions))
    drop(collection(:partners))
    drop(collection(:products))
    drop(collection(:racis))
    drop(collection(:gain_creators))
    drop(collection(:pain_killers))
  end
end
