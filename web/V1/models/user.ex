defmodule DocsUsers.V1.User do
  use DocsUsers.Web, :model

  # we need to define that poison should encode everything except __meta__
  # https://github.com/elixir-ecto/ecto/issues/840
  @derive {Poison.Encoder, except: [:__meta__]}
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
    |> unique_constraint(:email)
    |> validate_required([:uuid, :name, :email, :password, :active])
    |> validate_length(:name, max: 255)
    |> validate_length(:email, max: 255)
  end
end
