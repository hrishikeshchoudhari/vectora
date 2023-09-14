defmodule VectoraWeb.GainCreatorLive.Index do
  use VectoraWeb, :live_view

  alias Vectora.Tools
  alias Vectora.Tools.GainCreator

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :gain_creators, Tools.list_gain_creators())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gain creator")
    |> assign(:gain_creator, Tools.get_gain_creator!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gain creator")
    |> assign(:gain_creator, %GainCreator{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Gain creators")
    |> assign(:gain_creator, nil)
  end

  @impl true
  def handle_info({VectoraWeb.GainCreatorLive.FormComponent, {:saved, gain_creator}}, socket) do
    {:noreply, stream_insert(socket, :gain_creators, gain_creator)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gain_creator = Tools.get_gain_creator!(id)
    {:ok, _} = Tools.delete_gain_creator(gain_creator)

    {:noreply, stream_delete(socket, :gain_creators, gain_creator)}
  end
end
