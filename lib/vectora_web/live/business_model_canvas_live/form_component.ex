defmodule VectoraWeb.BusinessModelCanvasLive.FormComponent do
  use VectoraWeb, :live_component

  alias Vectora.Tools

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage business_model_canvas records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="business_model_canvas-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Business model canvas</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{business_model_canvas: business_model_canvas} = assigns, socket) do
    changeset = Tools.change_business_model_canvas(business_model_canvas)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"business_model_canvas" => business_model_canvas_params}, socket) do
    changeset =
      socket.assigns.business_model_canvas
      |> Tools.change_business_model_canvas(business_model_canvas_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"business_model_canvas" => business_model_canvas_params}, socket) do
    save_business_model_canvas(socket, socket.assigns.action, business_model_canvas_params)
  end

  defp save_business_model_canvas(socket, :edit, business_model_canvas_params) do
    case Tools.update_business_model_canvas(socket.assigns.business_model_canvas, business_model_canvas_params) do
      {:ok, business_model_canvas} ->
        notify_parent({:saved, business_model_canvas})

        {:noreply,
         socket
         |> put_flash(:info, "Business model canvas updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_business_model_canvas(socket, :new, business_model_canvas_params) do
    case Tools.create_business_model_canvas(business_model_canvas_params) do
      {:ok, business_model_canvas} ->
        notify_parent({:saved, business_model_canvas})

        {:noreply,
         socket
         |> put_flash(:info, "Business model canvas created successfully")
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
