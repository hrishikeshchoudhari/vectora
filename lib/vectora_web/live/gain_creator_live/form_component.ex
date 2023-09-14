defmodule VectoraWeb.GainCreatorLive.FormComponent do
  use VectoraWeb, :live_component

  alias Vectora.Tools

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage gain_creator records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="gain_creator-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Gain creator</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{gain_creator: gain_creator} = assigns, socket) do
    changeset = Tools.change_gain_creator(gain_creator)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"gain_creator" => gain_creator_params}, socket) do
    changeset =
      socket.assigns.gain_creator
      |> Tools.change_gain_creator(gain_creator_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"gain_creator" => gain_creator_params}, socket) do
    save_gain_creator(socket, socket.assigns.action, gain_creator_params)
  end

  defp save_gain_creator(socket, :edit, gain_creator_params) do
    case Tools.update_gain_creator(socket.assigns.gain_creator, gain_creator_params) do
      {:ok, gain_creator} ->
        notify_parent({:saved, gain_creator})

        {:noreply,
         socket
         |> put_flash(:info, "Gain creator updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_gain_creator(socket, :new, gain_creator_params) do
    case Tools.create_gain_creator(gain_creator_params) do
      {:ok, gain_creator} ->
        notify_parent({:saved, gain_creator})

        {:noreply,
         socket
         |> put_flash(:info, "Gain creator created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
