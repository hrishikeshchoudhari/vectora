defmodule Vectora.ToolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Vectora.Tools` context.
  """

  @doc """
  Generate a gain_creator.
  """
  def gain_creator_fixture(attrs \\ %{}) do
    {:ok, gain_creator} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description"
      })
      |> Vectora.Tools.create_gain_creator()

    gain_creator
  end

  @doc """
  Generate a business_model_canvas.
  """
  def business_model_canvas_fixture(attrs \\ %{}) do
    {:ok, business_model_canvas} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description"
      })
      |> Vectora.Tools.create_business_model_canvas()

    business_model_canvas
  end

  @doc """
  Generate a value_proposition.
  """
  def value_proposition_fixture(attrs \\ %{}) do
    {:ok, value_proposition} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description"
      })
      |> Vectora.Tools.create_value_proposition()

    value_proposition
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description"
      })
      |> Vectora.Tools.create_product()

    product
  end

  @doc """
  Generate a pain_killer.
  """
  def pain_killer_fixture(attrs \\ %{}) do
    {:ok, pain_killer} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description"
      })
      |> Vectora.Tools.create_pain_killer()

    pain_killer
  end

  @doc """
  Generate a partner.
  """
  def partner_fixture(attrs \\ %{}) do
    {:ok, partner} =
      attrs
      |> Enum.into(%{
        name: "some name",
        description: "some description"
      })
      |> Vectora.Tools.create_partner()

    partner
  end

  @doc """
  Generate a raci.
  """
  def raci_fixture(attrs \\ %{}) do
    {:ok, raci} =
      attrs
      |> Enum.into(%{
        responsible: "some responsible",
        accountable: "some accountable",
        consulted: "some consulted",
        informed: "some informed"
      })
      |> Vectora.Tools.create_raci()

    raci
  end
end
