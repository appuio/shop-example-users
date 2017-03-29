defmodule LoginEndpoint do
  use DocsUsers.ConnCase

  alias DocsUsers.V1.User

  # setup the connections
  setup do
    conn = build_conn()
      |> put_req_header("accept", "application/json")
      |> put_req_header("content-type", "application/json")
    {:ok, conn: conn}
  end

  test "logging in with invalid body" do
    # POST an empty body
    conn = post build_conn(), "/api/v1/users/login", %{}

    # make sure that login was denied and body marked as invalid
    assert json_response(conn, 200) == %{
      "success" => false,
      "error" => %{
        "message" => "INVALID_BODY"
      }
    }
  end

  test "logging in with inexistent account" do
    # POST login credentials
    conn = post build_conn(), "/api/v1/users/login", %{email: "tester@gmail.com", password: "abcd"}

    # make sure that login was denied
    assert json_response(conn, 200) == %{
      "success" => false,
      "error" => %{
        "message" => "LOGIN_INVALID"
      }
    }
  end

  test "logging in with inactive account" do
    # insert inactive account in test database
    Repo.insert! %User{email: "tester@gmail.com", password: "abcd", active: false}

    #POST login credentials
    conn = post build_conn(), "/api/v1/users/login", %{email: "tester@gmail.com", password: "abcd"}

    # make sure that the account was denied as inactive
    assert json_response(conn, 200) == %{
      "success" => false,
      "error" => %{
        "message" => "ACCOUNT_INACTIVE"
      }
    }
  end

  test "successful login" do
    # insert active account in test database
    Repo.insert! %User{
      id: 1,
      uuid: "1b206337-bd9f-495b-992b-5386ad14d10f",
      name: "Tester",
      email: "tester@gmail.com",
      password: Comeonin.Bcrypt.hashpwsalt("abcd"),
      active: true
    }

    # POST login credentials
    conn = post build_conn(), "/api/v1/users/login", %{email: "tester@gmail.com", password: "abcd"}

    # make sure that the login was successful
    assert json_response(conn, 200) == %{
      "success" => true,
      "data" => %{
        "name" => "Tester",
        "email" => "tester@gmail.com",
        "token" => "abcd" # there has to be some way to verify the token here
      }
    }
  end
end
