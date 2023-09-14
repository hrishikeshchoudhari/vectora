defmodule VectoraWeb.BusinessModelCanvasLive.Index do
  use VectoraWeb, :live_view

  alias Vectora.Tools
  alias Vectora.Tools.BusinessModelCanvas

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :business_model_canvas_collection, Tools.list_business_model_canvas())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Business model canvas")
    |> assign(:business_model_canvas, Tools.get_business_model_canvas!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Business model canvas")
    |> assign(:business_model_canvas, %BusinessModelCanvas{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Business model canvas")
    |> assign(:business_model_canvas, nil)
  end

  @impl true
  def handle_info({VectoraWeb.BusinessModelCanvasLive.FormComponent, {:saved, business_model_canvas}}, socket) do
    {:noreply, stream_insert(socket, :business_model_canvas_collection, business_model_canvas)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    business_model_canvas = Tools.get_business_model_canvas!(id)
    {:ok, _} = Tools.delete_business_model_canvas(business_model_canvas)

    {:noreply, stream_delete(socket, :business_model_canvas_collection, business_model_canvas)}
  end
end
