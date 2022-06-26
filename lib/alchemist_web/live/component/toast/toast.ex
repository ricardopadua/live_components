defmodule AlchemistWeb.Live.Component.Toast do
  use Phoenix.LiveComponent

  alias Heroicons.Solid, as: Icon

  # prop title, :string
  # prop content, :string
  # prop duration, :string, time in milliseconds
  # prop position, :string, options: ["top-right", "top-left", "bottom-right", "bottom-left"]
  # prop type, :string, options: ["info", "success", "warning", "error"]

  defmodule Message do
    defstruct id: 1, title: "", content: "", type: "info", icon: "", classes: "", visible: false
  end

  def types() do
    %{
      title: nil,
      content: nil,
      type: "info"
    }
  end

  def mount(socket) do
    IO.inspect(socket, label: "mount => socket")
    socket =
      socket
      |> assign(:title, nil)
      |> assign(:content, nil)
      |> assign(:duration, "3000")
      |> assign(:position, "top-right")
      |> assign(:type, "info")
      |> assign(:icon, nil)
      |> assign(:messages, [])
      |> assign(:visible, false)
      |> assign(:classes, toast_classes(%{type: "info"}))

    {:ok, socket}
  end

  def update(assings, socket) do
    {:ok, socket |> assign(:messages, assings.messages)}

  end

  def render(assigns) do
    ~L"""
    <div id="toast"
    class="<%= toast_position(@position) %>"
    @notice.window="add($event.detail)"
    style="pointer-events:none">
      <%= for message <- @messages do %>
        <div id="<%= message.id %>"
        x-show="<%= message.visible %>"
        x-transition:enter="transition ease-in duration-200"
        x-transition:enter-start="transform opacity-0 translate-y-2"
        x-transition:enter-end="transform opacity-100"
        x-transition:leave="transition ease-out duration-500"
        x-transition:leave-start="transform translate-x-0 opacity-100"
        x-transition:leave-end="transform translate-x-full opacity-0"
        style="pointer-events:all"
        class="<%= message.classes.toast %>"  role="toast">
        <%= message.icon %>
          <div class="<%= @classes.wrapper_content %>">
            <span class="<%= message.classes.title %>"><%= message.title %></span>
            <div class="<%= message.classes.content_text %>"><%= message.content %></div>
            <div class="<%= message.classes.content_divider %>"></div>
          </div>

          <button id="remove_<%= message.id %>" type="button" phx-click="remove" class="<%= message.classes.close_button %>" data-dismiss-target="#alert-border-1" aria-label="Close">
            <span class="sr-only">Dismiss</span>
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
          </button>

        </div>
        <% end %>

    </div>
    """
  end

  defp toast_classes(%{type: type}) do
    case type do
      "info" ->
        %{
          toast:
            "border-l-4 border-blue-600 mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-blue-700 rounded-md shadow-md text-sm bg-blue-100 dark:bg-blue-200 dark:text-blue-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold text-blue-700 dark:text-blue-800",
          content_text: "mb-2 text-sm font-normal text-blue-700 dark:text-blue-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-blue-100 dark:bg-blue-200 text-blue-500 rounded-lg focus:ring-2 focus:ring-blue-400 p-1.5 hover:bg-blue-200 dark:hover:bg-blue-300 inline-flex h-8 w-8"
        }

      "success" ->
        %{
          toast:
            "border-l-4 border-green-400 mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-green-700 rounded-md shadow-md text-sm bg-green-100 dark:bg-green-200 dark:text-green-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold text-green-700 dark:text-green-800",
          content_text: "mb-2 text-sm font-normal text-green-700 dark:text-green-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-green-100 dark:bg-green-200 text-green-500 rounded-lg focus:ring-2 focus:ring-green-400 p-1.5 hover:bg-green-200 dark:hover:bg-green-300 inline-flex h-8 w-8"
        }

      "warning" ->
        %{
          toast:
            "border-l-4 border-yellow-400 mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-yellow-700 rounded-md shadow-md text-sm bg-yellow-100 dark:bg-yellow-200 dark:text-yellow-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold text-yellow-700 dark:text-yellow-800",
          content_text: "mb-2 text-sm font-normal text-yellow-700 dark:text-yellow-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-yellow-100 dark:bg-yellow-200 text-yellow-500 rounded-lg focus:ring-2 focus:ring-yellow-400 p-1.5 hover:bg-yellow-200 dark:hover:bg-yellow-300 inline-flex h-8 w-8"
        }

      "error" ->
        %{
          toast:
            "border-l-4 border-red-600 mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-red-700 rounded-md shadow-md text-sm bg-red-100 dark:bg-red-200 dark:text-red-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold text-red-700 dark:text-red-800",
          content_text: "mb-2 text-sm font-normal text-red-700 dark:text-red-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-red-100 dark:bg-red-200 text-red-500 rounded-lg focus:ring-2 focus:ring-red-400 p-1.5 hover:bg-red-200 dark:hover:bg-red-300 inline-flex h-8 w-8"
        }

      _ ->
        %{
          toast:
            "border-l-4 border-gray-400 mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-white-700 rounded-md shadow-md text-sm bg-white-100 dark:bg-white-200 dark:text-white-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold text-gray-700 dark:text-gray-800",
          content_text: "mb-2 text-sm font-normal text-gray-500 dark:text-gray-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-200 dark:hover:bg-gray-700 inline-flex h-8 w-8"
        }
    end
  end

  defp toast_position("top-left"),
    do: "fixed inset-0 flex flex-col-reverse items-start justify-end h-screen w-screen"

  defp toast_position("top-center"),
    do: "fixed inset-0 flex flex-col-reverse items-center justify-end h-screen w-screen"

  defp toast_position("top-right"),
    do: "fixed inset-0 flex flex-col-reverse items-end justify-end h-screen w-screen"

  defp toast_position("middle-left"),
    do: "fixed inset-0 flex flex-col-reverse items-start justify-start h-screen w-screen"

  defp toast_position("middle-center"),
    do: "fixed inset-0 flex flex-col-reverse items-center justify-start h-screen w-screen"

  defp toast_position("middle-right"),
    do: "fixed inset-0 flex flex-col-reverse items-end justify-start h-screen w-screen"

  defp toast_icon(%{type: "info"}),
    do: Icon.information_circle(%{class: "h-12 w-12 text-blue-600"})

  defp toast_icon(%{type: "success"}), do: Icon.check_circle(%{class: "h-12 w-12 text-green-400"})

  defp toast_icon(%{type: "warning"}),
    do: Icon.exclamation_circle(%{class: "h-12 w-12 text-yellow-400"})

  defp toast_icon(%{type: "error"}), do: Icon.x_circle(%{class: "h-12 w-12 text-red-600"})

  def handle_event("remove", socket) do
    {:noreply, socket}
  end

  def info(%{title: title, content: content}) do
    %Message{
      id: 1,
      title: title,
      content: content,
      visible: true,
      icon: toast_icon(%{type: "info"}),
      classes: toast_classes(%{type: "info"})
    }
  end

  def success(%{title: title, content: content}) do
    %Message{
      id: 1,
      title: title,
      content: content,
      visible: true,
      icon: toast_icon(%{type: "success"}),
      classes: toast_classes(%{type: "success"})
    }
  end

  def warning(%{title: title, content: content}) do
    %Message{
      id: 1,
      title: title,
      content: content,
      visible: true,
      icon: toast_icon(%{type: "warning"}),
      classes: toast_classes(%{type: "warning"})
    }
  end

  def error(%{title: title, content: content}) do
    %Message{
      id: 1,
      title: title,
      content: content,
      visible: true,
      icon: toast_icon(%{type: "error"}),
      classes: toast_classes(%{type: "error"})
    }
  end
end
