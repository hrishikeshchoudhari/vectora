defmodule VectoraWeb.ProductLive.Show do
  use VectoraWeb, :live_view

  alias Vectora.Tools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, connections: [])}

  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do

    all_associations = Enum.map(Tools.Product.__schema__(:associations), &Atom.to_string/1)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:relations, all_associations)
     |> assign(:product, Tools.get_product!(id))}
  end

  @impl true
  def handle_event("get_rel", %{"id" => id}, socket) do
    IO.puts("get_rel" <> id)
    connections = Tools.get_product_connections(socket.assigns.product, id)
    IO.inspect(connections)
    {:noreply,
      socket
      |> assign(:connections, connections)
    }
  end

  def handle_event("create_valprop", props, socket) do
    {:ok, new_valprop} = Tools.create_value_proposition(props)
    Tools.linking(new_valprop, socket.assigns.product)
    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
end
