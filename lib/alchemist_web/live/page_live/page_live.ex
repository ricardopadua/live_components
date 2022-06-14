defmodule AlchemistWeb.PageLive do
  use Phoenix.LiveView

  alias AlchemistWeb.Live.Component.Toast

  def mount(_session, socket) do
    {:ok, assign(socket, :val, 0)}
  end
end
