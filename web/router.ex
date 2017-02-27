defmodule DocsUsers.Router do
  use DocsUsers.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", DocsUsers.V1 do
    # use the api pipeline
    pipe_through :api

    # login via email/password, return a JWT
    post "/users/login", UsersController, :login

    # registration
    post "/users", UsersController, :create

    # get own user data
    get "/users/:id", UsersController, :read

    # edit own user data
    put "/users/:id", UsersController, :update
  end
end
