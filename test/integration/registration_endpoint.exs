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

  test "registration with invalid body" do
    # POST an empty body
    conn = post build_conn(), "/api/v1/users", %{}

    # make sure that registration was denied and body marked as invalid
    assert json_response(conn, 200) == %{
      "success" => false,
      "error" => %{
        "message" => "INVALID_BODY"
      }
    }
  end

  test "registration with valid body" do
    # POST a valid body
    conn = post build_conn(), "/api/v1/users", %{
      name: "Tester",
      email: "tester@gmail.com",
      password: "abcd"
    }

    # TODO: verify that user has been added to db
    # TODO: verify that pw was hashed correctly
    # TODO: verify that user was set to inactive
    # TODO: verify that registration returns correct data
  end

end
