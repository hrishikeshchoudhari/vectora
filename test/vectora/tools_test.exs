defmodule Vectora.ToolsTest do
  use Vectora.DataCase

  alias Vectora.Tools

  describe "gain_creators" do
    alias Vectora.Tools.GainCreator

    import Vectora.ToolsFixtures

    @invalid_attrs %{}

    test "list_gain_creators/0 returns all gain_creators" do
      gain_creator = gain_creator_fixture()
      assert Tools.list_gain_creators() == [gain_creator]
    end

    test "get_gain_creator!/1 returns the gain_creator with given id" do
      gain_creator = gain_creator_fixture()
      assert Tools.get_gain_creator!(gain_creator.id) == gain_creator
    end

    test "create_gain_creator/1 with valid data creates a gain_creator" do
      valid_attrs = %{}

      assert {:ok, %GainCreator{} = gain_creator} = Tools.create_gain_creator(valid_attrs)
    end

    test "create_gain_creator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_gain_creator(@invalid_attrs)
    end

    test "update_gain_creator/2 with valid data updates the gain_creator" do
      gain_creator = gain_creator_fixture()
      update_attrs = %{}

      assert {:ok, %GainCreator{} = gain_creator} = Tools.update_gain_creator(gain_creator, update_attrs)
    end

    test "update_gain_creator/2 with invalid data returns error changeset" do
      gain_creator = gain_creator_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_gain_creator(gain_creator, @invalid_attrs)
      assert gain_creator == Tools.get_gain_creator!(gain_creator.id)
    end

    test "delete_gain_creator/1 deletes the gain_creator" do
      gain_creator = gain_creator_fixture()
      assert {:ok, %GainCreator{}} = Tools.delete_gain_creator(gain_creator)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_gain_creator!(gain_creator.id) end
    end

    test "change_gain_creator/1 returns a gain_creator changeset" do
      gain_creator = gain_creator_fixture()
      assert %Ecto.Changeset{} = Tools.change_gain_creator(gain_creator)
    end
  end

  describe "gain_creators" do
    alias Vectora.Tools.GainCreator

    import Vectora.ToolsFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_gain_creators/0 returns all gain_creators" do
      gain_creator = gain_creator_fixture()
      assert Tools.list_gain_creators() == [gain_creator]
    end

    test "get_gain_creator!/1 returns the gain_creator with given id" do
      gain_creator = gain_creator_fixture()
      assert Tools.get_gain_creator!(gain_creator.id) == gain_creator
    end

    test "create_gain_creator/1 with valid data creates a gain_creator" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %GainCreator{} = gain_creator} = Tools.create_gain_creator(valid_attrs)
      assert gain_creator.name == "some name"
      assert gain_creator.description == "some description"
    end

    test "create_gain_creator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_gain_creator(@invalid_attrs)
    end

    test "update_gain_creator/2 with valid data updates the gain_creator" do
      gain_creator = gain_creator_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %GainCreator{} = gain_creator} = Tools.update_gain_creator(gain_creator, update_attrs)
      assert gain_creator.name == "some updated name"
      assert gain_creator.description == "some updated description"
    end

    test "update_gain_creator/2 with invalid data returns error changeset" do
      gain_creator = gain_creator_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_gain_creator(gain_creator, @invalid_attrs)
      assert gain_creator == Tools.get_gain_creator!(gain_creator.id)
    end

    test "delete_gain_creator/1 deletes the gain_creator" do
      gain_creator = gain_creator_fixture()
      assert {:ok, %GainCreator{}} = Tools.delete_gain_creator(gain_creator)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_gain_creator!(gain_creator.id) end
    end

    test "change_gain_creator/1 returns a gain_creator changeset" do
      gain_creator = gain_creator_fixture()
      assert %Ecto.Changeset{} = Tools.change_gain_creator(gain_creator)
    end
  end

  describe "business_model_canvas" do
    alias Vectora.Tools.BusinessModelCanvas

    import Vectora.ToolsFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_business_model_canvas/0 returns all business_model_canvas" do
      business_model_canvas = business_model_canvas_fixture()
      assert Tools.list_business_model_canvas() == [business_model_canvas]
    end

    test "get_business_model_canvas!/1 returns the business_model_canvas with given id" do
      business_model_canvas = business_model_canvas_fixture()
      assert Tools.get_business_model_canvas!(business_model_canvas.id) == business_model_canvas
    end

    test "create_business_model_canvas/1 with valid data creates a business_model_canvas" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %BusinessModelCanvas{} = business_model_canvas} = Tools.create_business_model_canvas(valid_attrs)
      assert business_model_canvas.name == "some name"
      assert business_model_canvas.description == "some description"
    end

    test "create_business_model_canvas/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_business_model_canvas(@invalid_attrs)
    end

    test "update_business_model_canvas/2 with valid data updates the business_model_canvas" do
      business_model_canvas = business_model_canvas_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %BusinessModelCanvas{} = business_model_canvas} = Tools.update_business_model_canvas(business_model_canvas, update_attrs)
      assert business_model_canvas.name == "some updated name"
      assert business_model_canvas.description == "some updated description"
    end

    test "update_business_model_canvas/2 with invalid data returns error changeset" do
      business_model_canvas = business_model_canvas_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_business_model_canvas(business_model_canvas, @invalid_attrs)
      assert business_model_canvas == Tools.get_business_model_canvas!(business_model_canvas.id)
    end

    test "delete_business_model_canvas/1 deletes the business_model_canvas" do
      business_model_canvas = business_model_canvas_fixture()
      assert {:ok, %BusinessModelCanvas{}} = Tools.delete_business_model_canvas(business_model_canvas)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_business_model_canvas!(business_model_canvas.id) end
    end

    test "change_business_model_canvas/1 returns a business_model_canvas changeset" do
      business_model_canvas = business_model_canvas_fixture()
      assert %Ecto.Changeset{} = Tools.change_business_model_canvas(business_model_canvas)
    end
  end

  describe "value_propositions" do
    alias Vectora.Tools.ValueProposition

    import Vectora.ToolsFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_value_propositions/0 returns all value_propositions" do
      value_proposition = value_proposition_fixture()
      assert Tools.list_value_propositions() == [value_proposition]
    end

    test "get_value_proposition!/1 returns the value_proposition with given id" do
      value_proposition = value_proposition_fixture()
      assert Tools.get_value_proposition!(value_proposition.id) == value_proposition
    end

    test "create_value_proposition/1 with valid data creates a value_proposition" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %ValueProposition{} = value_proposition} = Tools.create_value_proposition(valid_attrs)
      assert value_proposition.name == "some name"
      assert value_proposition.description == "some description"
    end

    test "create_value_proposition/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_value_proposition(@invalid_attrs)
    end

    test "update_value_proposition/2 with valid data updates the value_proposition" do
      value_proposition = value_proposition_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %ValueProposition{} = value_proposition} = Tools.update_value_proposition(value_proposition, update_attrs)
      assert value_proposition.name == "some updated name"
      assert value_proposition.description == "some updated description"
    end

    test "update_value_proposition/2 with invalid data returns error changeset" do
      value_proposition = value_proposition_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_value_proposition(value_proposition, @invalid_attrs)
      assert value_proposition == Tools.get_value_proposition!(value_proposition.id)
    end

    test "delete_value_proposition/1 deletes the value_proposition" do
      value_proposition = value_proposition_fixture()
      assert {:ok, %ValueProposition{}} = Tools.delete_value_proposition(value_proposition)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_value_proposition!(value_proposition.id) end
    end

    test "change_value_proposition/1 returns a value_proposition changeset" do
      value_proposition = value_proposition_fixture()
      assert %Ecto.Changeset{} = Tools.change_value_proposition(value_proposition)
    end
  end

  describe "products" do
    alias Vectora.Tools.Product

    import Vectora.ToolsFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Tools.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Tools.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Product{} = product} = Tools.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Product{} = product} = Tools.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.description == "some updated description"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_product(product, @invalid_attrs)
      assert product == Tools.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Tools.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Tools.change_product(product)
    end
  end

  describe "pain_killers" do
    alias Vectora.Tools.PainKiller

    import Vectora.ToolsFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_pain_killers/0 returns all pain_killers" do
      pain_killer = pain_killer_fixture()
      assert Tools.list_pain_killers() == [pain_killer]
    end

    test "get_pain_killer!/1 returns the pain_killer with given id" do
      pain_killer = pain_killer_fixture()
      assert Tools.get_pain_killer!(pain_killer.id) == pain_killer
    end

    test "create_pain_killer/1 with valid data creates a pain_killer" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %PainKiller{} = pain_killer} = Tools.create_pain_killer(valid_attrs)
      assert pain_killer.name == "some name"
      assert pain_killer.description == "some description"
    end

    test "create_pain_killer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_pain_killer(@invalid_attrs)
    end

    test "update_pain_killer/2 with valid data updates the pain_killer" do
      pain_killer = pain_killer_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %PainKiller{} = pain_killer} = Tools.update_pain_killer(pain_killer, update_attrs)
      assert pain_killer.name == "some updated name"
      assert pain_killer.description == "some updated description"
    end

    test "update_pain_killer/2 with invalid data returns error changeset" do
      pain_killer = pain_killer_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_pain_killer(pain_killer, @invalid_attrs)
      assert pain_killer == Tools.get_pain_killer!(pain_killer.id)
    end

    test "delete_pain_killer/1 deletes the pain_killer" do
      pain_killer = pain_killer_fixture()
      assert {:ok, %PainKiller{}} = Tools.delete_pain_killer(pain_killer)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_pain_killer!(pain_killer.id) end
    end

    test "change_pain_killer/1 returns a pain_killer changeset" do
      pain_killer = pain_killer_fixture()
      assert %Ecto.Changeset{} = Tools.change_pain_killer(pain_killer)
    end
  end

  describe "partners" do
    alias Vectora.Tools.Partner

    import Vectora.ToolsFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Tools.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Tools.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Partner{} = partner} = Tools.create_partner(valid_attrs)
      assert partner.name == "some name"
      assert partner.description == "some description"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Partner{} = partner} = Tools.update_partner(partner, update_attrs)
      assert partner.name == "some updated name"
      assert partner.description == "some updated description"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_partner(partner, @invalid_attrs)
      assert partner == Tools.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Tools.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Tools.change_partner(partner)
    end
  end

  describe "racis" do
    alias Vectora.Tools.RACI

    import Vectora.ToolsFixtures

    @invalid_attrs %{responsible: nil, accountable: nil, consulted: nil, informed: nil}

    test "list_racis/0 returns all racis" do
      raci = raci_fixture()
      assert Tools.list_racis() == [raci]
    end

    test "get_raci!/1 returns the raci with given id" do
      raci = raci_fixture()
      assert Tools.get_raci!(raci.id) == raci
    end

    test "create_raci/1 with valid data creates a raci" do
      valid_attrs = %{responsible: "some responsible", accountable: "some accountable", consulted: "some consulted", informed: "some informed"}

      assert {:ok, %RACI{} = raci} = Tools.create_raci(valid_attrs)
      assert raci.responsible == "some responsible"
      assert raci.accountable == "some accountable"
      assert raci.consulted == "some consulted"
      assert raci.informed == "some informed"
    end

    test "create_raci/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tools.create_raci(@invalid_attrs)
    end

    test "update_raci/2 with valid data updates the raci" do
      raci = raci_fixture()
      update_attrs = %{responsible: "some updated responsible", accountable: "some updated accountable", consulted: "some updated consulted", informed: "some updated informed"}

      assert {:ok, %RACI{} = raci} = Tools.update_raci(raci, update_attrs)
      assert raci.responsible == "some updated responsible"
      assert raci.accountable == "some updated accountable"
      assert raci.consulted == "some updated consulted"
      assert raci.informed == "some updated informed"
    end

    test "update_raci/2 with invalid data returns error changeset" do
      raci = raci_fixture()
      assert {:error, %Ecto.Changeset{}} = Tools.update_raci(raci, @invalid_attrs)
      assert raci == Tools.get_raci!(raci.id)
    end

    test "delete_raci/1 deletes the raci" do
      raci = raci_fixture()
      assert {:ok, %RACI{}} = Tools.delete_raci(raci)
      assert_raise Ecto.NoResultsError, fn -> Tools.get_raci!(raci.id) end
    end

    test "change_raci/1 returns a raci changeset" do
      raci = raci_fixture()
      assert %Ecto.Changeset{} = Tools.change_raci(raci)
    end
  end
end
