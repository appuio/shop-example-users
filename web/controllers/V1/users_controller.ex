defmodule DocsUsers.V1.UsersController do
  use DocsUsers.Web, :controller

  def read(conn, %{"id" => id}) do
    json conn, []
  end
end