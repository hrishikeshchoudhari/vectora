defmodule Vectora.Tools.RACI do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "racis" do
    field :responsible, :string
    field :accountable, :string
    field :consulted, :string
    field :informed, :string

    incoming :business_model_canvas, Vectora.Tools.BusinessModelCanvas
    incoming :partners, Vectora.Tools.Partner
    incoming :products, Vectora.Tools.Product

    timestamps()
  end

  def changeset(raci, attrs) do
    raci
    |> cast(attrs, [:responsible, :accountable, :consulted, :informed])
    |> validate_required([:responsible, :accountable, :consulted, :informed])
  end
end
