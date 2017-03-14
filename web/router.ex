defmodule DocsUsers.Router do
  use DocsUsers.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", DocsUsers.V1 do
    # use the api pipeline
    pipe_through :api

    # get an index of all users in the database
    get "/users", UserController, :index

    # login via email/password, returns a JWT
    post "/users/login", UserController, :login

    # register a new user
    post "/users", UserController, :register

    # get user data
    get "/users/:id", UserController, :read

    # edit user data
    put "/users/:id", UserController, :update
  end
end
