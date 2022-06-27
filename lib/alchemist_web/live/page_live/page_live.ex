defmodule AlchemistWeb.PageLive do
  use Phoenix.LiveView

  alias AlchemistWeb.Live.Component.Toast

  def mount(_session, _params, socket) do
    socket =
      socket
      |> assign(messages: [])

    {:ok, socket}
  end

  def handle_event("add_toast", _params, socket) do
    message_info =
      Toast.info(%{
        title: "Update Leruaite",
        content: "existe um leruaite que precisa ser atualizado aqui !"
      })

    message_success =
      Toast.success(%{
        title: "Update Leruaite",
        content: "existe um leruaite que precisa ser atualizado aqui !"
      })

    message_warning =
      Toast.warning(%{
        title: "Update Leruaite",
        content: "existe um leruaite que precisa ser atualizado aqui !"
      })

    message_error =
      Toast.error(%{
        title: "Update Leruaite",
        content: "existe um leruaite que precisa ser atualizado aqui !"
      })

      list = [message_info, message_success, message_warning, message_error]
      message = Enum.random(list)

    {:noreply,
     socket |> assign(:messages, [message])}
  end
end
