defmodule VectoraWeb.ValuePropositionLiveTest do
  use VectoraWeb.ConnCase

  import Phoenix.LiveViewTest
  import Vectora.ToolsFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_value_proposition(_) do
    value_proposition = value_proposition_fixture()
    %{value_proposition: value_proposition}
  end

  describe "Index" do
    setup [:create_value_proposition]

    test "lists all value_propositions", %{conn: conn, value_proposition: value_proposition} do
      {:ok, _index_live, html} = live(conn, ~p"/value_propositions")

      assert html =~ "Listing Value propositions"
      assert html =~ value_proposition.name
    end

    test "saves new value_proposition", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/value_propositions")

      assert index_live |> element("a", "New Value proposition") |> render_click() =~
               "New Value proposition"

      assert_patch(index_live, ~p"/value_propositions/new")

      assert index_live
             |> form("#value_proposition-form", value_proposition: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#value_proposition-form", value_proposition: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/value_propositions")

      html = render(index_live)
      assert html =~ "Value proposition created successfully"
      assert html =~ "some name"
    end

    test "updates value_proposition in listing", %{conn: conn, value_proposition: value_proposition} do
      {:ok, index_live, _html} = live(conn, ~p"/value_propositions")

      assert index_live |> element("#value_propositions-#{value_proposition.id} a", "Edit") |> render_click() =~
               "Edit Value proposition"

      assert_patch(index_live, ~p"/value_propositions/#{value_proposition}/edit")

      assert index_live
             |> form("#value_proposition-form", value_proposition: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#value_proposition-form", value_proposition: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/value_propositions")

      html = render(index_live)
      assert html =~ "Value proposition updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes value_proposition in listing", %{conn: conn, value_proposition: value_proposition} do
      {:ok, index_live, _html} = live(conn, ~p"/value_propositions")

      assert index_live |> element("#value_propositions-#{value_proposition.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#value_propositions-#{value_proposition.id}")
    end
  end

  describe "Show" do
    setup [:create_value_proposition]

    test "displays value_proposition", %{conn: conn, value_proposition: value_proposition} do
      {:ok, _show_live, html} = live(conn, ~p"/value_propositions/#{value_proposition}")

      assert html =~ "Show Value proposition"
      assert html =~ value_proposition.name
    end

    test "updates value_proposition within modal", %{conn: conn, value_proposition: value_proposition} do
      {:ok, show_live, _html} = live(conn, ~p"/value_propositions/#{value_proposition}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Value proposition"

      assert_patch(show_live, ~p"/value_propositions/#{value_proposition}/show/edit")

      assert show_live
             |> form("#value_proposition-form", value_proposition: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#value_proposition-form", value_proposition: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/value_propositions/#{value_proposition}")

      html = render(show_live)
      assert html =~ "Value proposition updated successfully"
      assert html =~ "some updated name"
    end
  end
end
