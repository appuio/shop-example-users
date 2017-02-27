defmodule DocsUsers.V1.UserController do
  use DocsUsers.Web, :controller

  alias DocsUsers.V1.User

  def login(conn, %{"email" => email, "password" => password}) do
    json conn, %{
      success: true
    }
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        json conn, %{
          success: true
        }
      {:error, changeset} ->
        json conn, %{
          success: false
        }
    end
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
