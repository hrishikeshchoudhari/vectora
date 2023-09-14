defmodule VectoraWeb.PainKillerLiveTest do
  use VectoraWeb.ConnCase

  import Phoenix.LiveViewTest
  import Vectora.ToolsFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_pain_killer(_) do
    pain_killer = pain_killer_fixture()
    %{pain_killer: pain_killer}
  end

  describe "Index" do
    setup [:create_pain_killer]

    test "lists all pain_killers", %{conn: conn, pain_killer: pain_killer} do
      {:ok, _index_live, html} = live(conn, ~p"/pain_killers")

      assert html =~ "Listing Pain killers"
      assert html =~ pain_killer.name
    end

    test "saves new pain_killer", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/pain_killers")

      assert index_live |> element("a", "New Pain killer") |> render_click() =~
               "New Pain killer"

      assert_patch(index_live, ~p"/pain_killers/new")

      assert index_live
             |> form("#pain_killer-form", pain_killer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pain_killer-form", pain_killer: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pain_killers")

      html = render(index_live)
      assert html =~ "Pain killer created successfully"
      assert html =~ "some name"
    end

    test "updates pain_killer in listing", %{conn: conn, pain_killer: pain_killer} do
      {:ok, index_live, _html} = live(conn, ~p"/pain_killers")

      assert index_live |> element("#pain_killers-#{pain_killer.id} a", "Edit") |> render_click() =~
               "Edit Pain killer"

      assert_patch(index_live, ~p"/pain_killers/#{pain_killer}/edit")

      assert index_live
             |> form("#pain_killer-form", pain_killer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pain_killer-form", pain_killer: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pain_killers")

      html = render(index_live)
      assert html =~ "Pain killer updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes pain_killer in listing", %{conn: conn, pain_killer: pain_killer} do
      {:ok, index_live, _html} = live(conn, ~p"/pain_killers")

      assert index_live |> element("#pain_killers-#{pain_killer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pain_killers-#{pain_killer.id}")
    end
  end

  describe "Show" do
    setup [:create_pain_killer]

    test "displays pain_killer", %{conn: conn, pain_killer: pain_killer} do
      {:ok, _show_live, html} = live(conn, ~p"/pain_killers/#{pain_killer}")

      assert html =~ "Show Pain killer"
      assert html =~ pain_killer.name
    end

    test "updates pain_killer within modal", %{conn: conn, pain_killer: pain_killer} do
      {:ok, show_live, _html} = live(conn, ~p"/pain_killers/#{pain_killer}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pain killer"

      assert_patch(show_live, ~p"/pain_killers/#{pain_killer}/show/edit")

      assert show_live
             |> form("#pain_killer-form", pain_killer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#pain_killer-form", pain_killer: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/pain_killers/#{pain_killer}")

      html = render(show_live)
      assert html =~ "Pain killer updated successfully"
      assert html =~ "some updated name"
    end
  end
end
