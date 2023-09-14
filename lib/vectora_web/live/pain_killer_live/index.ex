defmodule VectoraWeb.PainKillerLive.Index do
  use VectoraWeb, :live_view

  alias Vectora.Tools
  alias Vectora.Tools.PainKiller

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :pain_killers, Tools.list_pain_killers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Pain killer")
    |> assign(:pain_killer, Tools.get_pain_killer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Pain killer")
    |> assign(:pain_killer, %PainKiller{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Pain killers")
    |> assign(:pain_killer, nil)
  end

  @impl true
  def handle_info({VectoraWeb.PainKillerLive.FormComponent, {:saved, pain_killer}}, socket) do
    {:noreply, stream_insert(socket, :pain_killers, pain_killer)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    pain_killer = Tools.get_pain_killer!(id)
    {:ok, _} = Tools.delete_pain_killer(pain_killer)

    {:noreply, stream_delete(socket, :pain_killers, pain_killer)}
  end
end
