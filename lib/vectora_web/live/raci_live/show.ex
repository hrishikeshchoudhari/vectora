defmodule VectoraWeb.RACILive.Show do
  use VectoraWeb, :live_view

  alias Vectora.Tools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do

    all_associations = Enum.map(Tools.RACI.__schema__(:associations), &Atom.to_string/1)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:relations, all_associations)
     |> assign(:raci, Tools.get_raci!(id))}
  end

  defp page_title(:show), do: "Show Raci"
  defp page_title(:edit), do: "Edit Raci"
end
