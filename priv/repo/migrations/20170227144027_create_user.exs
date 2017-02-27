defmodule DocsUsers.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uuid, :uuid
      add :name, :string
      add :email, :string
      add :password, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
