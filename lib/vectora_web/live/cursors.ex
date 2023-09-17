# This module manages the presence and movements of user cursors in a live view.
# It enables tracking of user cursor positions and broadcasts these movements to others.
defmodule VectoraWeb.Cursors do
  # Alias for ease of reference.
  alias VectoraWeb.Presence

  # Makes use of live view functionalities provided by the `VectoraWeb` module.
  use VectoraWeb, :live_view

  # Defines a constant for the topic under which cursor presence will be managed.
  @channel_topic "cursor_page"

  # The `mount/3` function initializes and sets up the initial state for the live view.
  # It assigns a unique username and color for the cursor, and subscribes to presence updates.
  def mount(_params, _session, socket) do

    # Generates a mnemonic slug as a username for the user.
    username = MnemonicSlugs.generate_slug

    # Assigns a random color to the user's cursor.
    color = RandomColor.hex()

    # Tracks the presence of the user's cursor in the system.
    Presence.track(self(), @channel_topic, socket.id, %{
      socket_id: socket.id,
      x: 50,
      y: 50,
      username: username,
      color: color
    })

    # Subscribes to presence updates for the defined channel topic.
    VectoraWeb.Endpoint.subscribe(@channel_topic)

    # Fetches the list of all users currently present.
    initial_users =
      Presence.list(@channel_topic)
      |> Enum.map(fn {_, data} -> data[:metas] |> List.first() end)

    # Assigns the generated username, initial users, and socket ID to the socket's state.
    updated =
      socket
      |> assign(:username, username)
      |> assign(:users, initial_users)
      |> assign(:socket_id, socket.id)

    {:ok, updated}
  end

  # Handles "cursor-move" events by updating the position of the cursor in the presence system.
  def handle_event("cursor-move", %{"mouse_x" => x, "mouse_y" => y}, socket) do

    # Key to identify the current user's presence.
    key = socket.id
    payload = %{x: x, y: y}

    # Fetches and updates the metadata associated with the current user.
    metas =
      Presence.get_by_key(@channel_topic, key) [:metas]
      |> List.first()
      |> Map.merge(payload)

    # Updates the presence with the new cursor position.
    Presence.update(self(), @channel_topic, key, metas)

    {:noreply, socket}
  end

  # Handles updates to the presence system and refreshes the list of users.
  # This ensures the live view reflects the latest presence data.
  def handle_info(%{event: "presence_diff", payload: _payload}, socket) do
    users =
      Presence.list(@channel_topic)
      |> Enum.map(fn {_, data} -> data[:metas] |> List.first() end)

    # Updates the socket's state with the latest list of users and the current socket ID.
    updated =
      socket
      |> assign(users: users)
      |> assign(socket_id: socket.id)

    {:noreply, updated}
  end
end
