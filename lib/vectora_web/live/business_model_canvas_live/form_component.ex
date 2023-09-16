# This module represents a LiveComponent for the BusinessModelCanvas form in the VectoraWeb application.
# It allows users to create or edit BusinessModelCanvas records using a live interactive form.
defmodule VectoraWeb.BusinessModelCanvasLive.FormComponent do
  # Use the LiveComponent functionalities provided by the VectoraWeb framework.
  use VectoraWeb, :live_component

  # Alias the module for easier referencing.
  alias Vectora.Tools

  # Implement the render callback to define the HTML structure for this LiveComponent.
  # This renders the BusinessModelCanvas form with the provided data in the assigns.
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

  # Update callback is called whenever the LiveComponent is mounted or updated with new data.
  # It initializes or updates the form state based on the provided business_model_canvas data.
  @impl true
  def update(%{business_model_canvas: business_model_canvas} = assigns, socket) do
    # Create or update the changeset for the provided business_model_canvas.
    changeset = Tools.change_business_model_canvas(business_model_canvas)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  # Handle the "validate" event triggered when changes are made to the form.
  # It validates the data and updates the form state accordingly.
  @impl true
  def handle_event("validate", %{"business_model_canvas" => business_model_canvas_params}, socket) do
    changeset =
      socket.assigns.business_model_canvas
      |> Tools.change_business_model_canvas(business_model_canvas_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  # Handle the "save" event triggered when the form is submitted.
  # Based on the action (either :edit or :new), it either updates an existing record or creates a new one.
  def handle_event("save", %{"business_model_canvas" => business_model_canvas_params}, socket) do
    save_business_model_canvas(socket, socket.assigns.action, business_model_canvas_params)
  end

  # Private helper function to save changes for an existing BusinessModelCanvas.
  # On success, it notifies the parent process and updates the UI.
  # On failure, it updates the form state with the error data.
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

  # Private helper function to create a new BusinessModelCanvas.
  # On success, it notifies the parent process and updates the UI.
  # On failure, it updates the form state with the error data.
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

  # Private helper function to assign the changeset to the form.
  # It converts the changeset to a form structure that can be used in the render function.
  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  # Private helper function to send a notification to the parent process.
  # This is used to notify the parent about successful operations like saving a BusinessModelCanvas.
  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
