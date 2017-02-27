defmodule DocsUsers.PageController do
  use DocsUsers.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
