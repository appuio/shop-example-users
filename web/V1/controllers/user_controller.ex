defmodule DocsUsers.V1.UserController do
  use DocsUsers.Web, :controller

  alias DocsUsers.V1.User

  def login(conn, %{"email" => email, "password" => password}) do

    # check if the given user exists and whether passwords match
    with user = %User{id: _, uuid: _, email: _, password: _, active: true} <- Repo.get_by(User, email: email), 
         true <- Comeonin.Bcrypt.checkpw(password, user.password) do
      
      # generate a JWT
      new_conn = Guardian.Plug.api_sign_in(conn, user)
      jwt = Guardian.Plug.current_token(new_conn)
      {:ok, claims} = Guardian.Plug.claims(new_conn) # TODO: catch failures?
      exp = Map.get(claims, "exp")
      
      # return a JSON response with UUID and JWT
      new_conn
      |> put_status(200)
      |> put_resp_header("authorization", "Bearer #{jwt}")
      |> put_resp_header("x-expires", to_string(exp))
      |> put_data %{
          name: user.name,
          email: user.email,
          token: jwt
      }

    else

      # the user does exist but is inactive, return a failure message
      %User{email: email, password: password, active: false} ->

        # call dummy_checkpw to slow down attacks
        # one should not be able to easily guess valid usernames
        Comeonin.Bcrypt.dummy_checkpw

        conn 
        |> put_status(200)
        |> put_message "ACCOUNT_INACTIVE"
        
      # the user doesn't exist, return a failure message
      _ -> 

        # call dummy_checkpw to slow down attacks
        # one should not be able to easily guess valid usernames
        Comeonin.Bcrypt.dummy_checkpw

        conn
        |> put_status(200)
        |> put_message "LOGIN_INVALID"

    end

  end
  def login(conn, _), do: invalid conn
  
  def register(conn, %{"name" => name, "email" => email, "password" => password}) do

    # generate a new user using the model
    changeset = User.changeset(%User{}, %{
      # generate a UUID for the new user
      :uuid => Ecto.UUID.generate,
      # extract request data
      :name => name,
      :email => email,
      :password => Comeonin.Bcrypt.hashpwsalt(password),
      # the new user should be inactive by default
      :active => false 
    })

    # add the new user to the database
    case Repo.insert(changeset) do

      {:ok, user} ->
        # the user was successfully added
        # return a successful JSON response
        conn
        |> put_status(201)
        |> put_data %{
          name: user.name,
          email: user.email
        }

      {:error, changeset} ->
        # the user could not be created
        # return a failure JSON response
        conn
        |> put_status(200)
        |> put_error %{
          message: "INVALID_BODY",
          # errors: changeset.errors
        }

    end

  end
  def register(conn, _), do: invalid conn

  def logout(conn, _) do

    # get the current token from the request header
    jwt = Guardian.Plug.current_token(conn)

    # try extracting claims from the header
    # will only work if it is still valid
    case Guardian.Plug.claims(conn) do

      {:ok, claims} ->
        # revoke the token when logging out
        # this will also remove it from the db and make it unusable
        Guardian.revoke!(jwt, claims)

        conn
        |> put_status(200)
        |> json %{
          success: true
        }

      {:error, _} ->

        conn
        |> put_status(401)
        |> put_message "ALREADY_LOGGED_OUT"

    end

  end

  defp invalid(conn) do
    put_message(conn, "INVALID_BODY")
  end

  defp put_data(conn, data_map) do
    json conn, %{
      success: true,
      data: data_map
    }
  end

  defp put_error(conn, error_map) do
    json conn, %{
      success: false,
      error: error_map
    }
  end

  defp put_message(conn, message_string) do
    put_error(conn, %{
      message: message_string
    })
  end

end

