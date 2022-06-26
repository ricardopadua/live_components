defmodule AlchemistWeb.PageLive do
  use Phoenix.LiveView

  alias AlchemistWeb.Live.Component.Toast

  def mount(_session, _params, socket) do
    socket =
      socket
      |> assign(message: %Toast.Message{})

    {:ok, socket}
  end

  def handle_event("add_toast", _, socket) do

    {:noreply, socket |> assign(message: Toast.info(%{title: "Update Leruaite", content: "existe um leruaite que precisa ser atualizado aqui !"}))}
  end
end
