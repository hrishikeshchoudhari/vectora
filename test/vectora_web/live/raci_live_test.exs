defmodule VectoraWeb.RACILiveTest do
  use VectoraWeb.ConnCase

  import Phoenix.LiveViewTest
  import Vectora.ToolsFixtures

  @create_attrs %{responsible: "some responsible", accountable: "some accountable", consulted: "some consulted", informed: "some informed"}
  @update_attrs %{responsible: "some updated responsible", accountable: "some updated accountable", consulted: "some updated consulted", informed: "some updated informed"}
  @invalid_attrs %{responsible: nil, accountable: nil, consulted: nil, informed: nil}

  defp create_raci(_) do
    raci = raci_fixture()
    %{raci: raci}
  end

  describe "Index" do
    setup [:create_raci]

    test "lists all racis", %{conn: conn, raci: raci} do
      {:ok, _index_live, html} = live(conn, ~p"/racis")

      assert html =~ "Listing Racis"
      assert html =~ raci.responsible
    end

    test "saves new raci", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/racis")

      assert index_live |> element("a", "New Raci") |> render_click() =~
               "New Raci"

      assert_patch(index_live, ~p"/racis/new")

      assert index_live
             |> form("#raci-form", raci: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#raci-form", raci: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/racis")

      html = render(index_live)
      assert html =~ "Raci created successfully"
      assert html =~ "some responsible"
    end

    test "updates raci in listing", %{conn: conn, raci: raci} do
      {:ok, index_live, _html} = live(conn, ~p"/racis")

      assert index_live |> element("#racis-#{raci.id} a", "Edit") |> render_click() =~
               "Edit Raci"

      assert_patch(index_live, ~p"/racis/#{raci}/edit")

      assert index_live
             |> form("#raci-form", raci: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#raci-form", raci: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/racis")

      html = render(index_live)
      assert html =~ "Raci updated successfully"
      assert html =~ "some updated responsible"
    end

    test "deletes raci in listing", %{conn: conn, raci: raci} do
      {:ok, index_live, _html} = live(conn, ~p"/racis")

      assert index_live |> element("#racis-#{raci.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#racis-#{raci.id}")
    end
  end

  describe "Show" do
    setup [:create_raci]

    test "displays raci", %{conn: conn, raci: raci} do
      {:ok, _show_live, html} = live(conn, ~p"/racis/#{raci}")

      assert html =~ "Show Raci"
      assert html =~ raci.responsible
    end

    test "updates raci within modal", %{conn: conn, raci: raci} do
      {:ok, show_live, _html} = live(conn, ~p"/racis/#{raci}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Raci"

      assert_patch(show_live, ~p"/racis/#{raci}/show/edit")

      assert show_live
             |> form("#raci-form", raci: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#raci-form", raci: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/racis/#{raci}")

      html = render(show_live)
      assert html =~ "Raci updated successfully"
      assert html =~ "some updated responsible"
    end
  end
end
