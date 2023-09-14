defmodule VectoraWeb.ValuePropositionLive.FormComponent do
  use VectoraWeb, :live_component

  alias Vectora.Tools

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage value_proposition records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="value_proposition-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Value proposition</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{value_proposition: value_proposition} = assigns, socket) do
    changeset = Tools.change_value_proposition(value_proposition)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"value_proposition" => value_proposition_params}, socket) do
    changeset =
      socket.assigns.value_proposition
      |> Tools.change_value_proposition(value_proposition_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"value_proposition" => value_proposition_params}, socket) do
    save_value_proposition(socket, socket.assigns.action, value_proposition_params)
  end

  defp save_value_proposition(socket, :edit, value_proposition_params) do
    case Tools.update_value_proposition(socket.assigns.value_proposition, value_proposition_params) do
      {:ok, value_proposition} ->
        notify_parent({:saved, value_proposition})

        {:noreply,
         socket
         |> put_flash(:info, "Value proposition updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_value_proposition(socket, :new, value_proposition_params) do
    case Tools.create_value_proposition(value_proposition_params) do
      {:ok, value_proposition} ->
        notify_parent({:saved, value_proposition})

        {:noreply,
         socket
         |> put_flash(:info, "Value proposition created successfully")
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
