defmodule VectoraWeb.BusinessModelCanvasLiveTest do
  use VectoraWeb.ConnCase

  import Phoenix.LiveViewTest
  import Vectora.ToolsFixtures

  @create_attrs %{name: "some name", description: "some description"}
  @update_attrs %{name: "some updated name", description: "some updated description"}
  @invalid_attrs %{name: nil, description: nil}

  defp create_business_model_canvas(_) do
    business_model_canvas = business_model_canvas_fixture()
    %{business_model_canvas: business_model_canvas}
  end

  describe "Index" do
    setup [:create_business_model_canvas]

    test "lists all business_model_canvas", %{conn: conn, business_model_canvas: business_model_canvas} do
      {:ok, _index_live, html} = live(conn, ~p"/business_model_canvas")

      assert html =~ "Listing Business model canvas"
      assert html =~ business_model_canvas.name
    end

    test "saves new business_model_canvas", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/business_model_canvas")

      assert index_live |> element("a", "New Business model canvas") |> render_click() =~
               "New Business model canvas"

      assert_patch(index_live, ~p"/business_model_canvas/new")

      assert index_live
             |> form("#business_model_canvas-form", business_model_canvas: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#business_model_canvas-form", business_model_canvas: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/business_model_canvas")

      html = render(index_live)
      assert html =~ "Business model canvas created successfully"
      assert html =~ "some name"
    end

    test "updates business_model_canvas in listing", %{conn: conn, business_model_canvas: business_model_canvas} do
      {:ok, index_live, _html} = live(conn, ~p"/business_model_canvas")

      assert index_live |> element("#business_model_canvas-#{business_model_canvas.id} a", "Edit") |> render_click() =~
               "Edit Business model canvas"

      assert_patch(index_live, ~p"/business_model_canvas/#{business_model_canvas}/edit")

      assert index_live
             |> form("#business_model_canvas-form", business_model_canvas: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#business_model_canvas-form", business_model_canvas: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/business_model_canvas")

      html = render(index_live)
      assert html =~ "Business model canvas updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes business_model_canvas in listing", %{conn: conn, business_model_canvas: business_model_canvas} do
      {:ok, index_live, _html} = live(conn, ~p"/business_model_canvas")

      assert index_live |> element("#business_model_canvas-#{business_model_canvas.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#business_model_canvas-#{business_model_canvas.id}")
    end
  end

  describe "Show" do
    setup [:create_business_model_canvas]

    test "displays business_model_canvas", %{conn: conn, business_model_canvas: business_model_canvas} do
      {:ok, _show_live, html} = live(conn, ~p"/business_model_canvas/#{business_model_canvas}")

      assert html =~ "Show Business model canvas"
      assert html =~ business_model_canvas.name
    end

    test "updates business_model_canvas within modal", %{conn: conn, business_model_canvas: business_model_canvas} do
      {:ok, show_live, _html} = live(conn, ~p"/business_model_canvas/#{business_model_canvas}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Business model canvas"

      assert_patch(show_live, ~p"/business_model_canvas/#{business_model_canvas}/show/edit")

      assert show_live
             |> form("#business_model_canvas-form", business_model_canvas: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#business_model_canvas-form", business_model_canvas: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/business_model_canvas/#{business_model_canvas}")

      html = render(show_live)
      assert html =~ "Business model canvas updated successfully"
      assert html =~ "some updated name"
    end
  end
end
