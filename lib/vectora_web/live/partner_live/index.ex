defmodule VectoraWeb.PartnerLive.Index do
  use VectoraWeb, :live_view

  alias Vectora.Tools
  alias Vectora.Tools.Partner

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :partners, Tools.list_partners())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Partner")
    |> assign(:partner, Tools.get_partner!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Partner")
    |> assign(:partner, %Partner{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Partners")
    |> assign(:partner, nil)
  end

  @impl true
  def handle_info({VectoraWeb.PartnerLive.FormComponent, {:saved, partner}}, socket) do
    {:noreply, stream_insert(socket, :partners, partner)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    partner = Tools.get_partner!(id)
    {:ok, _} = Tools.delete_partner(partner)

    {:noreply, stream_delete(socket, :partners, partner)}
  end
end
