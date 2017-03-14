defmodule DocsUsers.V1.UserController do
  use DocsUsers.Web, :controller

  alias DocsUsers.V1.User

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

  # TODO: generate real JWT token if login is valid
  def login(conn, %{"email" => email, "password" => password}) do
    # TODO: validate inputs
    # TODO: check if credentials match
    # TODO: generate a token if match, else throw
    # TODO: use guardian db to save the token in the DB
    json conn, %{
      success: true,
      data: %{
        uuid: "abcd",
        name: "Roland",
        token: "JWT"
      }
    }
  end

  # TODO
  def register(conn, request) do
    # generate a new user using the model
    changeset = User.changeset(%User{}, %{
      # generate a UUID for the new user
      :uuid => Ecto.UUID.generate,
      # extract request data
      :name => request["name"],
      :email => request["email"],
      :password => request["password"],
      # the new user should be inactive by default
      :active => false 
    })

    # add the new user to the database
    case Repo.insert(changeset) do
      {:ok, user} ->
        # extract the id from the newly created user
        # TODO: can we optimize this? step necessary?
        %{:uuid => uuid} = user

        # the user was successfully added
        # return a successful JSON response
        json conn, %{
          success: true,
          uuid: uuid,
          # TODO: remove debug output
          request: request
        }

      {:error, changeset} ->
        # the user could not be created
        # return a failure JSON response
        json conn, %{
          success: false,
          # TODO: remove debug output
          request: request,
          errors: changeset.errors
        }
    end
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

end
