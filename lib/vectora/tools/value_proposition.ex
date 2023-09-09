defmodule Vectora.Tools.ValueProposition do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "value_propositions" do
    field :name, :string
    field :description, :string

    outgoing :pain_killers, Vectora.Tools.PainKiller
    outgoing :gain_creators, Vectora.Tools.GainCreator

    incoming :business_model_canvas, Vectora.Tools.BusinessModelCanvas
    incoming :products, Vectora.Tools.Product

    timestamps()
  end

  def changeset(value_props, attrs) do
    value_props
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
