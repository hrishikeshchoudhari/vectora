defmodule Vectora.Tools.Partner do
  use ArangoXEcto.Schema
  import Ecto.Changeset

  schema "partner" do
    field :name, :string
    field :description, :string


    outgoing :racis, Vectora.Tools.RACI

    incoming :business_model_canvas, Vectora.Tools.BusinessModelCanvas




    timestamps()
  end

  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
