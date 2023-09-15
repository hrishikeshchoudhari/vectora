defmodule VectoraWeb.BusinessModelCanvasLive.Show do
  use VectoraWeb, :live_view

  alias Vectora.Tools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do

    all_associations = Enum.map(Tools.BusinessModelCanvas.__schema__(:associations), &Atom.to_string/1)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:relations, all_associations)
     |> assign(:business_model_canvas, Tools.get_business_model_canvas!(id))}
  end

  defp page_title(:show), do: "Show Business model canvas"
  defp page_title(:edit), do: "Edit Business model canvas"
end
