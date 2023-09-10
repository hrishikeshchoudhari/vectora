defmodule VectoraWeb.Cursors do
  alias VectoraWeb.Presence
  use VectoraWeb, :live_view

  @channel_topic "cursor_page"

  def mount(_params, _session, socket) do

    username = MnemonicSlugs.generate_slug

    color = RandomColor.hex()

    Presence.track(self(), @channel_topic, socket.id, %{
      socket_id: socket.id,
      x: 50,
      y: 50,
      username: username,
      color: color
    })

    VectoraWeb.Endpoint.subscribe(@channel_topic)

    initial_users =
      Presence.list(@channel_topic)
      |> Enum.map(fn {_, data} -> data[:metas] |> List.first() end)

    updated =
      socket
      |> assign(:username, username)
      |> assign(:users, initial_users)
      |> assign(:socket_id, socket.id)

    {:ok, updated}
  end

  def handle_event("cursor-move", %{"mouse_x" => x, "mouse_y" => y}, socket) do

    key = socket.id
    payload = %{x: x, y: y}

    metas =
      Presence.get_by_key(@channel_topic, key) [:metas]
      |> List.first()
      |> Map.merge(payload)

    Presence.update(self(), @channel_topic, key, metas)

    {:noreply, socket}
  end

  def handle_info(%{event: "presence_diff", payload: _payload}, socket) do
    users =
      Presence.list(@channel_topic)
      |> Enum.map(fn {_, data} -> data[:metas] |> List.first() end)

    updated =
      socket
      |> assign(users: users)
      |> assign(socket_id: socket.id)

    {:noreply, updated}
  end

  # @impl true
  # def mount(_params, _session, socket) do
  #   {:ok, assign(socket, :cursors, %{})}
  # end

  # @impl true
  # def handle_info(
  #       %{
  #         event: "cursor_move",
  #         payload: %{"x" => x, "y" => y, "id" => id}
  #       } = msg,
  #       socket
  #     ) do
  #   {:noreply, assign(socket, :cursors, Map.put(socket.assigns.cursors, id, %{x: x, y: y}))}
  # end

  # @impl true
  # def handle_info(
  #       %{
  #         event: "cursor_leave",
  #         payload: %{"id" => id}
  #       } = msg,
  #       socket
  #     ) do
  #   {:noreply, assign(socket, :cursors, Map.delete(socket.assigns.cursors, id))}
  # end
end
