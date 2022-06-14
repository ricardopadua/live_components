defmodule AlchemistWeb.PageController do
  use AlchemistWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
