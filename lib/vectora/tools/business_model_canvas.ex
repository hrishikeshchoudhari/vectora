defmodule Vectora.Tools.BusinessModelCanvas do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "business_model_canvas" do
    field :name, :string
    field :description, :string

    outgoing :racis, Vectora.Tools.RACI
    outgoing :partners, Vectora.Tools.Partner
    outgoing :products, Vectora.Tools.Product
    outgoing :value_propositions, Vectora.Tools.ValueProposition

    timestamps()
  end

  @doc false
  def changeset(business_model_canvas, attrs) do
    business_model_canvas
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
