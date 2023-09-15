defmodule Vectora.Tools.ValueProposition do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "value_propositions" do
    field :name, :string
    field :description, :string

    outgoing :gain_creators, Vectora.Tools.GainCreator
    outgoing :pain_killers, Vectora.Tools.PainKiller

    incoming :business_model_canvas, Vectora.Tools.BusinessModelCanvas
    incoming :products, Vectora.Tools.Product

    timestamps()
  end

  @doc false
  def changeset(value_proposition, attrs) do
    value_proposition
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
