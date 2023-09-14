defmodule VectoraWeb.RACILive.Index do
  use VectoraWeb, :live_view

  alias Vectora.Tools
  alias Vectora.Tools.RACI

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :racis, Tools.list_racis())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Raci")
    |> assign(:raci, Tools.get_raci!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Raci")
    |> assign(:raci, %RACI{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Racis")
    |> assign(:raci, nil)
  end

  @impl true
  def handle_info({VectoraWeb.RACILive.FormComponent, {:saved, raci}}, socket) do
    {:noreply, stream_insert(socket, :racis, raci)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    raci = Tools.get_raci!(id)
    {:ok, _} = Tools.delete_raci(raci)

    {:noreply, stream_delete(socket, :racis, raci)}
  end
end
