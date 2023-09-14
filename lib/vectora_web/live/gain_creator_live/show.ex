defmodule VectoraWeb.GainCreatorLive.Show do
  use VectoraWeb, :live_view

  alias Vectora.Tools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:gain_creator, Tools.get_gain_creator!(id))}
  end

  defp page_title(:show), do: "Show Gain creator"
  defp page_title(:edit), do: "Edit Gain creator"
end
