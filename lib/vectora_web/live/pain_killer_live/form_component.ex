defmodule VectoraWeb.PainKillerLive.FormComponent do
  use VectoraWeb, :live_component

  alias Vectora.Tools

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage pain_killer records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="pain_killer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Pain killer</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{pain_killer: pain_killer} = assigns, socket) do
    changeset = Tools.change_pain_killer(pain_killer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"pain_killer" => pain_killer_params}, socket) do
    changeset =
      socket.assigns.pain_killer
      |> Tools.change_pain_killer(pain_killer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"pain_killer" => pain_killer_params}, socket) do
    save_pain_killer(socket, socket.assigns.action, pain_killer_params)
  end

  defp save_pain_killer(socket, :edit, pain_killer_params) do
    case Tools.update_pain_killer(socket.assigns.pain_killer, pain_killer_params) do
      {:ok, pain_killer} ->
        notify_parent({:saved, pain_killer})

        {:noreply,
         socket
         |> put_flash(:info, "Pain killer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_pain_killer(socket, :new, pain_killer_params) do
    case Tools.create_pain_killer(pain_killer_params) do
      {:ok, pain_killer} ->
        notify_parent({:saved, pain_killer})

        {:noreply,
         socket
         |> put_flash(:info, "Pain killer created successfully")
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
