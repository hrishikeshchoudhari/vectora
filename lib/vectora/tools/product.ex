defmodule Vectora.Tools.Product do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string

    outgoing :racis, Vectora.Tools.RACI

    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
