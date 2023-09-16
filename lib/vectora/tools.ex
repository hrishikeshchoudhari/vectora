defmodule Vectora.Tools do
  @moduledoc """
  The Tools context.
  """

  import Ecto.Query, warn: false
  alias Vectora.Repo

  alias Vectora.Tools.GainCreator
  alias Vectora.Tools.BusinessModelCanvas
  alias Vectora.Tools.ValueProposition
  alias Vectora.Tools.PainKiller
  alias Vectora.Tools.Product
  alias Vectora.Tools.Partner
  alias Vectora.Tools.RACI

  # This function retrieves the connections (i.e., related nodes) for a given gain creator from the database.
  #
  # @param _gain_creator - This parameter is unused in the current implementation. It might be a placeholder or
  #                        left for potential future use.
  # @param id - The ID of the gain creator for which we want to fetch the connections.
  # @return - Returns a list of connected value propositions for the given gain creator.
  def get_gain_creator_connections(_gain_creator, id) do
    # Executes an ArangoDB AQL query. The query fetches all nodes directly connected
    # to the gain creator with the provided ID via the 'gaincreator_valueproposition' edge.
    {:ok, res} = ArangoXEcto.aql_query(Repo,
                "WITH gain_creators FOR v, e IN 1..1 ANY 'gain_creators/"<> id <>"' gaincreator_valueproposition RETURN v")

                # Maps over the result to load each map into the corresponding ValueProposition Ecto schema.
    Enum.map(res, fn map -> Repo.load(ValueProposition, map) end)
  end

  def linking() do
    g1 = Vectora.Tools.get_gain_creator!("1643012")
    v1 = Vectora.Tools.get_value_proposition!("1675760")
    e1 = ArangoXEcto.create_edge(Repo, g1, v1)
    IO.inspect(e1)
  end

  @doc """
  Returns the list of gain_creators.
  """
  def list_gain_creators do
    Repo.all(GainCreator)
  end

  @doc """
  Gets a single gain_creator.

  Raises `Ecto.NoResultsError` if the Gain creator does not exist.

  """
  def get_gain_creator!(id), do: Repo.get!(GainCreator, id)

  @doc """
  Creates a gain_creator.


  """
  def create_gain_creator(attrs \\ %{}) do
    %GainCreator{}
    |> GainCreator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gain_creator.

  """
  def update_gain_creator(%GainCreator{} = gain_creator, attrs) do
    gain_creator
    |> GainCreator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gain_creator.


  """
  def delete_gain_creator(%GainCreator{} = gain_creator) do
    Repo.delete(gain_creator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gain_creator changes.


  """
  def change_gain_creator(%GainCreator{} = gain_creator, attrs \\ %{}) do
    GainCreator.changeset(gain_creator, attrs)
  end

  alias Vectora.Tools.BusinessModelCanvas

  @doc """
  Returns the list of business_model_canvas.


  """
  def list_business_model_canvas do
    Repo.all(BusinessModelCanvas)
  end

  @doc """
  Gets a single business_model_canvas.


  """
  def get_business_model_canvas!(id), do: Repo.get!(BusinessModelCanvas, id)

  @doc """
  Creates a business_model_canvas.


  """
  def create_business_model_canvas(attrs \\ %{}) do
    %BusinessModelCanvas{}
    |> BusinessModelCanvas.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a business_model_canvas.


  """
  def update_business_model_canvas(%BusinessModelCanvas{} = business_model_canvas, attrs) do
    business_model_canvas
    |> BusinessModelCanvas.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a business_model_canvas.


  """
  def delete_business_model_canvas(%BusinessModelCanvas{} = business_model_canvas) do
    Repo.delete(business_model_canvas)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business_model_canvas changes.


  """
  def change_business_model_canvas(%BusinessModelCanvas{} = business_model_canvas, attrs \\ %{}) do
    BusinessModelCanvas.changeset(business_model_canvas, attrs)
  end

  alias Vectora.Tools.ValueProposition

  @doc """
  Returns the list of value_propositions.


  """
  def list_value_propositions do
    IO.inspect(Repo.aggregate(ValueProposition, :count, :id))
    Repo.all(ValueProposition)
  end

  @doc """
  Gets a single value_proposition.

  Raises `Ecto.NoResultsError` if the Value proposition does not exist.


  """
  def get_value_proposition!(id), do: Repo.get!(ValueProposition, id)

  @doc """
  Creates a value_proposition.


  """
  def create_value_proposition(attrs \\ %{}) do
    %ValueProposition{}
    |> ValueProposition.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a value_proposition.


  """
  def update_value_proposition(%ValueProposition{} = value_proposition, attrs) do
    value_proposition
    |> ValueProposition.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a value_proposition.


  """
  def delete_value_proposition(%ValueProposition{} = value_proposition) do
    Repo.delete(value_proposition)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking value_proposition changes.


  """
  def change_value_proposition(%ValueProposition{} = value_proposition, attrs \\ %{}) do
    ValueProposition.changeset(value_proposition, attrs)
  end

  alias Vectora.Tools.Product

  @doc """
  Returns the list of products.


  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  alias Vectora.Tools.PainKiller

  @doc """
  Returns the list of pain_killers.

  """
  def list_pain_killers do
    Repo.all(PainKiller)
  end

  @doc """
  Gets a single pain_killer.

  Raises `Ecto.NoResultsError` if the Pain killer does not exist.

  """
  def get_pain_killer!(id), do: Repo.get!(PainKiller, id)

  @doc """
  Creates a pain_killer.

  """
  def create_pain_killer(attrs \\ %{}) do
    %PainKiller{}
    |> PainKiller.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pain_killer.

  """
  def update_pain_killer(%PainKiller{} = pain_killer, attrs) do
    pain_killer
    |> PainKiller.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pain_killer.

  """
  def delete_pain_killer(%PainKiller{} = pain_killer) do
    Repo.delete(pain_killer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pain_killer changes.


  """
  def change_pain_killer(%PainKiller{} = pain_killer, attrs \\ %{}) do
    PainKiller.changeset(pain_killer, attrs)
  end

  alias Vectora.Tools.Partner

  @doc """
  Returns the list of partners.

  """
  def list_partners do
    Repo.all(Partner)
  end

  @doc """
  Gets a single partner.

  Raises `Ecto.NoResultsError` if the Partner does not exist.

  """
  def get_partner!(id), do: Repo.get!(Partner, id)

  @doc """
  Creates a partner.

  """
  def create_partner(attrs \\ %{}) do
    %Partner{}
    |> Partner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a partner.


  """
  def update_partner(%Partner{} = partner, attrs) do
    partner
    |> Partner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a partner.


  """
  def delete_partner(%Partner{} = partner) do
    Repo.delete(partner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking partner changes.


  """
  def change_partner(%Partner{} = partner, attrs \\ %{}) do
    Partner.changeset(partner, attrs)
  end

  alias Vectora.Tools.RACI

  @doc """
  Returns the list of racis.


  """
  def list_racis do
    Repo.all(RACI)
  end

  @doc """
  Gets a single raci.


  """
  def get_raci!(id), do: Repo.get!(RACI, id)

  @doc """
  Creates a raci.


  """
  def create_raci(attrs \\ %{}) do
    %RACI{}
    |> RACI.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raci.


  """
  def update_raci(%RACI{} = raci, attrs) do
    raci
    |> RACI.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a raci.


  """
  def delete_raci(%RACI{} = raci) do
    Repo.delete(raci)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raci changes.


  """
  def change_raci(%RACI{} = raci, attrs \\ %{}) do
    RACI.changeset(raci, attrs)
  end
end
