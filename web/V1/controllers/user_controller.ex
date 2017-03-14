defmodule DocsUsers.V1.UserController do
  use DocsUsers.Web, :controller

  alias DocsUsers.V1.User

  # TODO: remove this, as we won't need to index users
  def index(conn, _) do
    users = Repo.all(User)
      |> Enum.map(fn user -> Map.delete(user, :password) end)

    json conn, %{
      success: true,
      data: users
    }
  end

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
        %{:id => id} = user

        # the user was successfully added
        # return a successful JSON response
        json conn, %{
          success: true,
          id: id,
          request: request
        }

      {:error, changeset} ->
        # the user could not be created
        # return a failure JSON response
        json conn, %{
          success: false,
          request: request,
          errors: changeset.errors
        }
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    json conn, %{
      success: true
    }
  end

  def read(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    json conn, %{
      success: true
    }
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
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

# case Repo.insert(changeset) do
#      {:ok, _user} ->
#        json conn, %{
#          success: true
#        }
#      {:error, changeset} ->
#        json conn, %{
#          success: false
#       }
#    end
