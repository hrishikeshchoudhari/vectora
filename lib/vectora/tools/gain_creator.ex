defmodule Vectora.Tools.GainCreator do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "gain_creators" do
    field :name, :string
    field :description, :string

    incoming :value_propositions, Vectora.Tools.ValueProposition

    timestamps()
  end

  def changeset(gain_creator, attrs) do
    gain_creator
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
