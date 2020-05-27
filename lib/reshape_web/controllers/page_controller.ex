defmodule ReshapeWeb.PageController do
  use ReshapeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
