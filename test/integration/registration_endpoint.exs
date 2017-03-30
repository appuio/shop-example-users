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

    # verify that user has been added to db
    user = Repo.get_by(User, email: "tester@gmail.com")
    assert user
    assert user.name == "Tester"
    assert user.id > 0
    assert user.uuid # TODO: verify the uuid
    assert Comeonin.Bcrypt.checkpw("abcd", user.password)
    refute user.active
    
    # verify that registration returns correct data
    assert json_response(conn, 201) == %{
      "success" => true,
      "data" => %{
        "name" => "Tester",
        "email" => "tester@gmail.com"
      }
    }
  end

  test "registration with existent email" do
    # insert the record into the database
    Repo.insert! %User{
      id: 1,
      uuid: "1b206337-bd9f-495b-992b-5386ad14d10f",
      name: "Tester",
      email: "tester@gmail.com",
      password: Comeonin.Bcrypt.hashpwsalt("abcd"),
      active: true
    }
    
    # POST a valid body
    conn = post build_conn(), "/api/v1/users", %{
      name: "Tester",
      email: "tester@gmail.com",
      password: "abcd"
    }

    # verify that registration fails
    assert json_response(conn, 200) == %{
      "success" => false,
      "error" => %{
        "message" => "INVALID_BODY"
      }
    }
  end

end
