defmodule VectoraWeb.GainCreatorLiveTest do
  use VectoraWeb.ConnCase

  import Phoenix.LiveViewTest
  import Vectora.ToolsFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_gain_creator(_) do
    gain_creator = gain_creator_fixture()
    %{gain_creator: gain_creator}
  end

  describe "Index" do
    setup [:create_gain_creator]

    test "lists all gain_creators", %{conn: conn, gain_creator: gain_creator} do
      {:ok, _index_live, html} = live(conn, ~p"/gain_creators")

      assert html =~ "Listing Gain creators"
      assert html =~ gain_creator.name
    end

    test "saves new gain_creator", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/gain_creators")

      assert index_live |> element("a", "New Gain creator") |> render_click() =~
               "New Gain creator"

      assert_patch(index_live, ~p"/gain_creators/new")

      assert index_live
             |> form("#gain_creator-form", gain_creator: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#gain_creator-form", gain_creator: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/gain_creators")

      html = render(index_live)
      assert html =~ "Gain creator created successfully"
      assert html =~ "some name"
    end

    test "updates gain_creator in listing", %{conn: conn, gain_creator: gain_creator} do
      {:ok, index_live, _html} = live(conn, ~p"/gain_creators")

      assert index_live |> element("#gain_creators-#{gain_creator.id} a", "Edit") |> render_click() =~
               "Edit Gain creator"

      assert_patch(index_live, ~p"/gain_creators/#{gain_creator}/edit")

      assert index_live
             |> form("#gain_creator-form", gain_creator: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#gain_creator-form", gain_creator: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/gain_creators")

      html = render(index_live)
      assert html =~ "Gain creator updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes gain_creator in listing", %{conn: conn, gain_creator: gain_creator} do
      {:ok, index_live, _html} = live(conn, ~p"/gain_creators")

      assert index_live |> element("#gain_creators-#{gain_creator.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#gain_creators-#{gain_creator.id}")
    end
  end

  describe "Show" do
    setup [:create_gain_creator]

    test "displays gain_creator", %{conn: conn, gain_creator: gain_creator} do
      {:ok, _show_live, html} = live(conn, ~p"/gain_creators/#{gain_creator}")

      assert html =~ "Show Gain creator"
      assert html =~ gain_creator.name
    end

    test "updates gain_creator within modal", %{conn: conn, gain_creator: gain_creator} do
      {:ok, show_live, _html} = live(conn, ~p"/gain_creators/#{gain_creator}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Gain creator"

      assert_patch(show_live, ~p"/gain_creators/#{gain_creator}/show/edit")

      assert show_live
             |> form("#gain_creator-form", gain_creator: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#gain_creator-form", gain_creator: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/gain_creators/#{gain_creator}")

      html = render(show_live)
      assert html =~ "Gain creator updated successfully"
      assert html =~ "some updated name"
    end
  end
end
