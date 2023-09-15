defmodule VectoraWeb.ValuePropositionLive.Show do
  use VectoraWeb, :live_view

  alias Vectora.Tools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do

    all_associations = Enum.map(Tools.ValueProposition.__schema__(:associations), &Atom.to_string/1)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:relations, all_associations)
     |> assign(:value_proposition, Tools.get_value_proposition!(id))}
  end

  defp page_title(:show), do: "Show Value proposition"
  defp page_title(:edit), do: "Edit Value proposition"
end
