defmodule AlchemistWeb.Live.Component.Toast do
  use Phoenix.LiveComponent

  # prop title, :string
  # prop content, :string
  # prop duration, :string, time in milliseconds
  # prop position, :string, options: ["top-right", "top-left", "bottom-right", "bottom-left"]
  # prop type, :string, options: ["info", "success", "warning", "error"]

  def mount(_assigns, socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    {:ok,
      socket
      |> assign(assigns)
    }
  end

  def render(assigns) do
      assigns
      |> assign_new(:title, fn -> nil end)
      |> assign_new(:content, fn -> nil end)
      |> assign_new(:duration, fn -> "3000" end)
      |> assign_new(:position, fn -> "top-right" end)
      |> assign_new(:type, fn -> "info" end)
      |> assign_new(:icon, fn -> toast_icon(assigns) end)
      |> assign_new(:classes, fn -> toast_classes(assigns) end)
      |> toast()
  end

  def toast(assigns) do
    ~L"""
    <div id="wrappertoast" phx-hook="Toast"
    x-data="noticesHandler()"
    class="<%= toast_position(@position) %>"
    @notice.window="add($event.detail)"
    style="pointer-events:none">
      <template x-for="notice of notices" :key="notice.id">
        <div id="toast"
        x-show="visible.includes(notice)"
        x-transition:enter="transition ease-in duration-200"
        x-transition:enter-start="transform opacity-0 translate-y-2"
        x-transition:enter-end="transform opacity-100"
        x-transition:leave="transition ease-out duration-500"
        x-transition:leave-start="transform translate-x-0 opacity-100"
        x-transition:leave-end="transform translate-x-full opacity-0"
        @click="remove(notice.id)"
        style="pointer-events:all"
        class="<%= @classes.toast %>"  role="toast">
          <%= @icon %>
          <div class="<%= @classes.wrapper_content %>">
            <span class="<%= @classes.title %>"><%= @title %></span>
            <div class="<%= @classes.content_text %>"><%= @content %></div>
            <div class="<%= @classes.content_divider %>"></div>
          </div>

          <button type="button" class="<%= @classes.close_button %>" data-dismiss-target="#alert-border-1" aria-label="Close">
            <span class="sr-only">Dismiss</span>
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
          </button>

        </div>
      </template>
    </div>
    <script>
    function noticesHandler() {
      return {
        notices: [],
        visible: [],
        add(notice) {
          notice.id = Date.now()
          this.notices.push(notice)
          this.fire(notice.id)
        },

        fire(id) {
          this.visible.push(this.notices.find(notice => notice.id == id))
          const timeShown = 2000 * this.visible.length
          setTimeout(() => {
            this.remove(id)
            }, timeShown)
        },

        remove(id) {
          const notice = this.visible.find(notice => notice.id == id)
          const index = this.visible.indexOf(notice)
          this.visible.splice(index, 1)
        },
      }
    }
    </script>
    """
  end

  defp toast_classes(%{type: type}) do
    case type do
      "info" ->
        %{
          toast:
            "mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-blue-700 rounded-md shadow text-sm bg-blue-100 dark:bg-blue-200 dark:text-blue-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold dark:text-white text-blue-900",
          content_text: "mb-2 text-sm font-normal text-blue-700 dark:text-blue-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-blue-100 dark:bg-blue-200 text-blue-500 rounded-lg focus:ring-2 focus:ring-blue-400 p-1.5 hover:bg-blue-200 dark:hover:bg-blue-300 inline-flex h-8 w-8"
        }

      "success" ->
        %{
          toast:
            "mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-green-700 rounded-md shadow text-sm bg-green-100 dark:bg-green-200 dark:text-green-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold dark:text-white text-green-900",
          content_text: "mb-2 text-sm font-normal text-green-700 dark:text-green-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-green-100 dark:bg-green-200 text-green-500 rounded-lg focus:ring-2 focus:ring-green-400 p-1.5 hover:bg-green-200 dark:hover:bg-green-300 inline-flex h-8 w-8"
        }

      "warning" ->
        %{
          toast:
            "mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-yellow-700 rounded-md shadow text-sm bg-yellow-100 dark:bg-yellow-200 dark:text-yellow-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold dark:text-white text-yellow-900",
          content_text: "mb-2 text-sm font-normal text-yellow-700 dark:text-yellow-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-yellow-100 dark:bg-yellow-200 text-yellow-500 rounded-lg focus:ring-2 focus:ring-yellow-400 p-1.5 hover:bg-yellow-200 dark:hover:bg-yellow-300 inline-flex h-8 w-8"
        }

      "error" ->
        %{
          toast:
            "mb-2 mt-2 ml-4 mr-4 flex items-center w-full max-w-xs p-4 space-x-4 text-red-700 rounded-md shadow text-sm bg-red-100 dark:bg-red-200 dark:text-red-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold dark:text-white text-red-900",
          content_text: "mb-2 text-sm font-normal text-red-700 dark:text-red-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-red-100 dark:bg-red-200 text-red-500 rounded-lg focus:ring-2 focus:ring-red-400 p-1.5 hover:bg-red-200 dark:hover:bg-red-300 inline-flex h-8 w-8"
        }

      _ ->
        %{
          toast:
            "mb-4 mr-6 flex items-center w-full max-w-xs p-4 space-x-4 text-blue-700 rounded-md shadow text-sm bg-blue-100 dark:bg-blue-200 dark:text-blue-800",
          wrapper_content: "ml-3 text-sm font-normal",
          title: "mb-1 text-sm font-semibold dark:text-white text-blue-900",
          content_text: "mb-2 text-sm font-normal text-blue-700 dark:text-blue-800",
          content_divider: "mb-2 text-sm font-normal",
          close_button:
            "ml-auto -mx-1.5 -my-1.5 bg-blue-100 dark:bg-blue-200 text-blue-500 rounded-lg focus:ring-2 focus:ring-blue-400 p-1.5 hover:bg-blue-200 dark:hover:bg-blue-300 inline-flex h-8 w-8"
        }
    end
  end

  defp toast_position("top-right"), do: "fixed inset-0 flex flex-col-reverse items-end justify-end h-screen w-screen"
  defp toast_position("middle-right"), do: "fixed inset-0 flex flex-col-reverse items-end justify-start h-screen w-screen"
  defp toast_position("top-left"), do: "fixed inset-0 flex flex-col-reverse items-start justify-end h-screen w-screen"
  defp toast_position("middle-left"), do: "fixed inset-0 flex flex-col-reverse items-start justify-start h-screen w-screen"

  defp toast_icon(%{type: "info"}), do: "💁"
  defp toast_icon(%{type: "success"}), do: "👌"
  defp toast_icon(%{type: "warning"}), do: "🔥"
  defp toast_icon(%{type: "error"}), do: "😵"
  defp toast_icon(_), do: "💅"
end
