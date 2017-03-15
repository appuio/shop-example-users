defmodule DocsUsers.Repo.Migrations.AddUniqueToEmail do
  use Ecto.Migration

  def change do
    # add uniqueness constraint on the email address
    create unique_index(:users, [:email])
  end
end
