defmodule DocsUsers.V1.User do
  use DocsUsers.Web, :model

  schema "users" do
    field :uuid, Ecto.UUID
    field :name, :string
    field :email, :string
    field :password, :string
    field :active, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uuid, :name, :email, :password, :active])
    |> validate_required([:uuid, :name, :email, :password, :active])
  end
end
