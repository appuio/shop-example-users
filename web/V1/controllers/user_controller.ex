defmodule DocsUsers.V1.UserController do
  use DocsUsers.Web, :controller

  alias DocsUsers.V1.User
  alias Comeonin.Bcrypt

  # TODO: remove this debugging function
  def index(conn, _) do
    users = Repo.all(User) # fetch all the users from the db
      # |> Enum.filter(fn user -> user.active end) # access the atom with .active
      # |> Enum.map(fn user -> Map.drop(user, [:password, :id, :active]) end) # drop unwanted keys
      # |> Enum.filter_map(&(&1.active), &(Map.drop(&1, [:password, :id, :active])))
      |> Enum.filter_map(
        fn user -> user.active end, # filter step
        fn user -> Map.drop(user, [:password, :id, :active]) end # map step
      )
      
    json conn, %{
      success: true,
      data: users
    }
  end

  # TODO: use when: is_email or similar
  def login(conn, %{"email" => email, "password" => password}) do
    # TODO: use guardian & guardian db?

    # check if the given user exists and whether passwords match
    with %User{id: id, uuid: uuid, email: email, password: hash, active: true} <- Repo.get_by(User, email: email), 
         true <- Bcrypt.checkpw(password, hash) do

      # return a JSON response with UUID and JWT
      return_data(conn, %{
        id: id,
        uuid: uuid,
        token: "JWT"
      })

    else

      # the user does exist but is inactive, return a failure message
      %User{email: email, password: password, active: false} -> return_message(conn, "ACCOUNT_INACTIVE")
        
      # the user doesn't exist, return a failure message
      _ -> return_message(conn, "LOGIN_INVALID")

    end 
  end

  def register(conn, %{"name" => name, "email" => email, "password" => password}) do
    # generate a new user using the model
    changeset = User.changeset(%User{}, %{
      # generate a UUID for the new user
      :uuid => Ecto.UUID.generate,
      # extract request data
      :name => name,
      :email => email,
      :password => Bcrypt.hashpwsalt(password),
      # the new user should be inactive by default
      :active => false 
    })

    # add the new user to the database
    case Repo.insert(changeset) do
      {:ok, user} ->
        # the user was successfully added
        # return a successful JSON response
        return_data(conn, %{
          id: user.id,
          uuid: user.uuid,
          token: "JWT"
        })

      {:error, changeset} ->
        # the user could not be created
        # return a failure JSON response
        return_error(conn, %{
          message: "INVALID_BODY",
          errors: changeset.errors
        })
    end
  end
  
  def login(conn, _) do
    invalid conn
  end

  def register(conn, _) do
    invalid conn
  end

  # TODO: implement using UUID
  def read(conn, %{"uuid" => uuid}) do
    user = Repo.get!(User, uuid)

    json conn, %{
      success: true
    }
  end

  # TODO: implement using UUID
  def update(conn, %{"uuid" => uuid, "user" => user_params}) do
    user = Repo.get!(User, uuid)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        json conn, %{
          success: true
        }
      {:error, changeset} ->
        json conn, %{
          success: false
        }
    end
  end

  defp invalid(conn) do
    return_message(conn, "INVALID_BODY")
  end

  defp return_data(conn, data_map) do
    json conn, %{
      success: true,
      data: data_map
    }
  end

  defp return_error(conn, error_map) do
    json conn, %{
      success: false,
      error: error_map
    }
  end

  defp return_message(conn, message_string) do
    return_error(conn, %{
      message: message_string
    })
  end

end
