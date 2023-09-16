defmodule VectoraWeb.GainCreatorLive.Show do
  use VectoraWeb, :live_view

  alias Vectora.Tools

  @impl true
  def mount(_params, _session, socket) do
    # {:ok, socket}
    {:ok, assign(socket, connections: [])}

  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do

    all_associations = Enum.map(Tools.GainCreator.__schema__(:associations), &Atom.to_string/1)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:relations, all_associations)
     |> assign(:gain_creator, Tools.get_gain_creator!(id))}
  end

  @impl true
  def handle_event("get_rel", %{"id" => id}, socket) do
    IO.puts("get_rel")
    connections = Tools.get_gain_creator_connections(socket.assigns.gain_creator, id)
    IO.inspect(connections)
    {:noreply,
      socket
      |> assign(:connections, connections)
    }
  end

  defp page_title(:show), do: "Show Gain creator"
  defp page_title(:edit), do: "Edit Gain creator"
end
