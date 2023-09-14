defmodule VectoraWeb.ValuePropositionLive.Index do
  use VectoraWeb, :live_view

  alias Vectora.Tools
  alias Vectora.Tools.ValueProposition

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :value_propositions, Tools.list_value_propositions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Value proposition")
    |> assign(:value_proposition, Tools.get_value_proposition!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Value proposition")
    |> assign(:value_proposition, %ValueProposition{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Value propositions")
    |> assign(:value_proposition, nil)
  end

  @impl true
  def handle_info({VectoraWeb.ValuePropositionLive.FormComponent, {:saved, value_proposition}}, socket) do
    {:noreply, stream_insert(socket, :value_propositions, value_proposition)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    value_proposition = Tools.get_value_proposition!(id)
    {:ok, _} = Tools.delete_value_proposition(value_proposition)

    {:noreply, stream_delete(socket, :value_propositions, value_proposition)}
  end
end
