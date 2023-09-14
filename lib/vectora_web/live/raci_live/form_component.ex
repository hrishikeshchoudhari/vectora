defmodule VectoraWeb.RACILive.FormComponent do
  use VectoraWeb, :live_component

  alias Vectora.Tools

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage RACI records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="raci-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:responsible]} type="text" label="Responsible" />
        <.input field={@form[:accountable]} type="text" label="Accountable" />
        <.input field={@form[:consulted]} type="text" label="Consulted" />
        <.input field={@form[:informed]} type="text" label="Informed" />
        <:actions>
          <.button phx-disable-with="Saving...">Save RACI</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{raci: raci} = assigns, socket) do
    changeset = Tools.change_raci(raci)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"raci" => raci_params}, socket) do
    changeset =
      socket.assigns.raci
      |> Tools.change_raci(raci_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"raci" => raci_params}, socket) do
    save_raci(socket, socket.assigns.action, raci_params)
  end

  defp save_raci(socket, :edit, raci_params) do
    case Tools.update_raci(socket.assigns.raci, raci_params) do
      {:ok, raci} ->
        notify_parent({:saved, raci})

        {:noreply,
         socket
         |> put_flash(:info, "RACI updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_raci(socket, :new, raci_params) do
    case Tools.create_raci(raci_params) do
      {:ok, raci} ->
        notify_parent({:saved, raci})

        {:noreply,
         socket
         |> put_flash(:info, "RACI created successfully")
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
