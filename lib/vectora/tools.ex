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


  def get_gain_creator_connections(_gain_creator, id) do
  {:ok, res} = ArangoXEcto.aql_query(Repo,
                "WITH gain_creators FOR v, e IN 1..1 ANY 'gain_creators/"<> id <>"' gaincreator_valueproposition RETURN v")
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

  ## Examples

      iex> list_gain_creators()
      [%GainCreator{}, ...]

  """
  def list_gain_creators do
    Repo.all(GainCreator)
  end

  @doc """
  Gets a single gain_creator.

  Raises `Ecto.NoResultsError` if the Gain creator does not exist.

  ## Examples

      iex> get_gain_creator!(123)
      %GainCreator{}

      iex> get_gain_creator!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gain_creator!(id), do: Repo.get!(GainCreator, id)

  @doc """
  Creates a gain_creator.

  ## Examples

      iex> create_gain_creator(%{field: value})
      {:ok, %GainCreator{}}

      iex> create_gain_creator(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gain_creator(attrs \\ %{}) do
    %GainCreator{}
    |> GainCreator.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gain_creator.

  ## Examples

      iex> update_gain_creator(gain_creator, %{field: new_value})
      {:ok, %GainCreator{}}

      iex> update_gain_creator(gain_creator, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gain_creator(%GainCreator{} = gain_creator, attrs) do
    gain_creator
    |> GainCreator.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gain_creator.

  ## Examples

      iex> delete_gain_creator(gain_creator)
      {:ok, %GainCreator{}}

      iex> delete_gain_creator(gain_creator)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gain_creator(%GainCreator{} = gain_creator) do
    Repo.delete(gain_creator)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gain_creator changes.

  ## Examples

      iex> change_gain_creator(gain_creator)
      %Ecto.Changeset{data: %GainCreator{}}

  """
  def change_gain_creator(%GainCreator{} = gain_creator, attrs \\ %{}) do
    GainCreator.changeset(gain_creator, attrs)
  end

  alias Vectora.Tools.BusinessModelCanvas

  @doc """
  Returns the list of business_model_canvas.

  ## Examples

      iex> list_business_model_canvas()
      [%BusinessModelCanvas{}, ...]

  """
  def list_business_model_canvas do
    Repo.all(BusinessModelCanvas)
  end

  @doc """
  Gets a single business_model_canvas.

  Raises `Ecto.NoResultsError` if the Business model canvas does not exist.

  ## Examples

      iex> get_business_model_canvas!(123)
      %BusinessModelCanvas{}

      iex> get_business_model_canvas!(456)
      ** (Ecto.NoResultsError)

  """
  def get_business_model_canvas!(id), do: Repo.get!(BusinessModelCanvas, id)

  @doc """
  Creates a business_model_canvas.

  ## Examples

      iex> create_business_model_canvas(%{field: value})
      {:ok, %BusinessModelCanvas{}}

      iex> create_business_model_canvas(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_business_model_canvas(attrs \\ %{}) do
    %BusinessModelCanvas{}
    |> BusinessModelCanvas.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a business_model_canvas.

  ## Examples

      iex> update_business_model_canvas(business_model_canvas, %{field: new_value})
      {:ok, %BusinessModelCanvas{}}

      iex> update_business_model_canvas(business_model_canvas, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_business_model_canvas(%BusinessModelCanvas{} = business_model_canvas, attrs) do
    business_model_canvas
    |> BusinessModelCanvas.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a business_model_canvas.

  ## Examples

      iex> delete_business_model_canvas(business_model_canvas)
      {:ok, %BusinessModelCanvas{}}

      iex> delete_business_model_canvas(business_model_canvas)
      {:error, %Ecto.Changeset{}}

  """
  def delete_business_model_canvas(%BusinessModelCanvas{} = business_model_canvas) do
    Repo.delete(business_model_canvas)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking business_model_canvas changes.

  ## Examples

      iex> change_business_model_canvas(business_model_canvas)
      %Ecto.Changeset{data: %BusinessModelCanvas{}}

  """
  def change_business_model_canvas(%BusinessModelCanvas{} = business_model_canvas, attrs \\ %{}) do
    BusinessModelCanvas.changeset(business_model_canvas, attrs)
  end

  alias Vectora.Tools.ValueProposition

  @doc """
  Returns the list of value_propositions.

  ## Examples

      iex> list_value_propositions()
      [%ValueProposition{}, ...]

  """
  def list_value_propositions do
    IO.inspect(Repo.aggregate(ValueProposition, :count, :id))
    Repo.all(ValueProposition)
  end

  @doc """
  Gets a single value_proposition.

  Raises `Ecto.NoResultsError` if the Value proposition does not exist.

  ## Examples

      iex> get_value_proposition!(123)
      %ValueProposition{}

      iex> get_value_proposition!(456)
      ** (Ecto.NoResultsError)

  """
  def get_value_proposition!(id), do: Repo.get!(ValueProposition, id)

  @doc """
  Creates a value_proposition.

  ## Examples

      iex> create_value_proposition(%{field: value})
      {:ok, %ValueProposition{}}

      iex> create_value_proposition(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_value_proposition(attrs \\ %{}) do
    %ValueProposition{}
    |> ValueProposition.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a value_proposition.

  ## Examples

      iex> update_value_proposition(value_proposition, %{field: new_value})
      {:ok, %ValueProposition{}}

      iex> update_value_proposition(value_proposition, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_value_proposition(%ValueProposition{} = value_proposition, attrs) do
    value_proposition
    |> ValueProposition.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a value_proposition.

  ## Examples

      iex> delete_value_proposition(value_proposition)
      {:ok, %ValueProposition{}}

      iex> delete_value_proposition(value_proposition)
      {:error, %Ecto.Changeset{}}

  """
  def delete_value_proposition(%ValueProposition{} = value_proposition) do
    Repo.delete(value_proposition)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking value_proposition changes.

  ## Examples

      iex> change_value_proposition(value_proposition)
      %Ecto.Changeset{data: %ValueProposition{}}

  """
  def change_value_proposition(%ValueProposition{} = value_proposition, attrs \\ %{}) do
    ValueProposition.changeset(value_proposition, attrs)
  end

  alias Vectora.Tools.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  alias Vectora.Tools.PainKiller

  @doc """
  Returns the list of pain_killers.

  ## Examples

      iex> list_pain_killers()
      [%PainKiller{}, ...]

  """
  def list_pain_killers do
    Repo.all(PainKiller)
  end

  @doc """
  Gets a single pain_killer.

  Raises `Ecto.NoResultsError` if the Pain killer does not exist.

  ## Examples

      iex> get_pain_killer!(123)
      %PainKiller{}

      iex> get_pain_killer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pain_killer!(id), do: Repo.get!(PainKiller, id)

  @doc """
  Creates a pain_killer.

  ## Examples

      iex> create_pain_killer(%{field: value})
      {:ok, %PainKiller{}}

      iex> create_pain_killer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pain_killer(attrs \\ %{}) do
    %PainKiller{}
    |> PainKiller.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pain_killer.

  ## Examples

      iex> update_pain_killer(pain_killer, %{field: new_value})
      {:ok, %PainKiller{}}

      iex> update_pain_killer(pain_killer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pain_killer(%PainKiller{} = pain_killer, attrs) do
    pain_killer
    |> PainKiller.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pain_killer.

  ## Examples

      iex> delete_pain_killer(pain_killer)
      {:ok, %PainKiller{}}

      iex> delete_pain_killer(pain_killer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pain_killer(%PainKiller{} = pain_killer) do
    Repo.delete(pain_killer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pain_killer changes.

  ## Examples

      iex> change_pain_killer(pain_killer)
      %Ecto.Changeset{data: %PainKiller{}}

  """
  def change_pain_killer(%PainKiller{} = pain_killer, attrs \\ %{}) do
    PainKiller.changeset(pain_killer, attrs)
  end

  alias Vectora.Tools.Partner

  @doc """
  Returns the list of partners.

  ## Examples

      iex> list_partners()
      [%Partner{}, ...]

  """
  def list_partners do
    Repo.all(Partner)
  end

  @doc """
  Gets a single partner.

  Raises `Ecto.NoResultsError` if the Partner does not exist.

  ## Examples

      iex> get_partner!(123)
      %Partner{}

      iex> get_partner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_partner!(id), do: Repo.get!(Partner, id)

  @doc """
  Creates a partner.

  ## Examples

      iex> create_partner(%{field: value})
      {:ok, %Partner{}}

      iex> create_partner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_partner(attrs \\ %{}) do
    %Partner{}
    |> Partner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a partner.

  ## Examples

      iex> update_partner(partner, %{field: new_value})
      {:ok, %Partner{}}

      iex> update_partner(partner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_partner(%Partner{} = partner, attrs) do
    partner
    |> Partner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a partner.

  ## Examples

      iex> delete_partner(partner)
      {:ok, %Partner{}}

      iex> delete_partner(partner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_partner(%Partner{} = partner) do
    Repo.delete(partner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking partner changes.

  ## Examples

      iex> change_partner(partner)
      %Ecto.Changeset{data: %Partner{}}

  """
  def change_partner(%Partner{} = partner, attrs \\ %{}) do
    Partner.changeset(partner, attrs)
  end

  alias Vectora.Tools.RACI

  @doc """
  Returns the list of racis.

  ## Examples

      iex> list_racis()
      [%RACI{}, ...]

  """
  def list_racis do
    Repo.all(RACI)
  end

  @doc """
  Gets a single raci.

  Raises `Ecto.NoResultsError` if the Raci does not exist.

  ## Examples

      iex> get_raci!(123)
      %RACI{}

      iex> get_raci!(456)
      ** (Ecto.NoResultsError)

  """
  def get_raci!(id), do: Repo.get!(RACI, id)

  @doc """
  Creates a raci.

  ## Examples

      iex> create_raci(%{field: value})
      {:ok, %RACI{}}

      iex> create_raci(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_raci(attrs \\ %{}) do
    %RACI{}
    |> RACI.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raci.

  ## Examples

      iex> update_raci(raci, %{field: new_value})
      {:ok, %RACI{}}

      iex> update_raci(raci, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_raci(%RACI{} = raci, attrs) do
    raci
    |> RACI.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a raci.

  ## Examples

      iex> delete_raci(raci)
      {:ok, %RACI{}}

      iex> delete_raci(raci)
      {:error, %Ecto.Changeset{}}

  """
  def delete_raci(%RACI{} = raci) do
    Repo.delete(raci)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raci changes.

  ## Examples

      iex> change_raci(raci)
      %Ecto.Changeset{data: %RACI{}}

  """
  def change_raci(%RACI{} = raci, attrs \\ %{}) do
    RACI.changeset(raci, attrs)
  end
end
