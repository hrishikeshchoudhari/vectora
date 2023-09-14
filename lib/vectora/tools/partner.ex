defmodule Vectora.Tools.Partner do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "partners" do
    field :name, :string
    field :description, :string

    outgoing :racis, Vectora.Tools.RACI

    incoming :business_model_canvas, Vectora.Tools.BusinessModelCanvas
    incoming :products, Vectora.Tools.Product

    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
