defmodule RegistrationEndpoint do
  use DocsUsers.ConnCase

  alias DocsUsers.V1.User

  # setup the connections
  setup do
    conn = build_conn()
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
    {:ok, conn: conn}
  end

end
