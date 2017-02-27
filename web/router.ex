defmodule DocsUsers.Router do
  use DocsUsers.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", DocsUsers.V1 do
    # use the api pipeline
    pipe_through :api

    # login via email/password, return a JWT
    post "/users/login", UserController, :login

    # registration
    post "/users", UserController, :create

    # get own user data
    get "/users/:id", UserController, :read

    # edit own user data
    put "/users/:id", UserController, :update
  end
end
