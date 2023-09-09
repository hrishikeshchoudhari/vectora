defmodule Vectora.Tools.PainKiller do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "pain_killers" do
    field :name, :string
    field :description, :string

    incoming :value_propositions, Vectora.Tools.ValueProposition

    timestamps()
  end

  def changeset(pain_killer, attrs) do
    pain_killer
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
