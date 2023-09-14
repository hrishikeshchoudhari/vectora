defmodule VectoraWeb.PartnerLive.FormComponent do
  use VectoraWeb, :live_component

  alias Vectora.Tools

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage partner records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="partner-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Partner</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{partner: partner} = assigns, socket) do
    changeset = Tools.change_partner(partner)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"partner" => partner_params}, socket) do
    changeset =
      socket.assigns.partner
      |> Tools.change_partner(partner_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"partner" => partner_params}, socket) do
    save_partner(socket, socket.assigns.action, partner_params)
  end

  defp save_partner(socket, :edit, partner_params) do
    case Tools.update_partner(socket.assigns.partner, partner_params) do
      {:ok, partner} ->
        notify_parent({:saved, partner})

        {:noreply,
         socket
         |> put_flash(:info, "Partner updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_partner(socket, :new, partner_params) do
    case Tools.create_partner(partner_params) do
      {:ok, partner} ->
        notify_parent({:saved, partner})

        {:noreply,
         socket
         |> put_flash(:info, "Partner created successfully")
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
