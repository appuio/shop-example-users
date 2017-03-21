defmodule DocsUsers.ReleaseTasks do

  @start_apps [
    :postgrex,
    :ecto
  ]

  def seed do
    IO.puts "Loading DocsUsers.."
    # Load the code for users, but don't start it
    :ok = Application.load(:docs_users)

    IO.puts "Starting dependencies.."
    # Start apps necessary for executing migrations
    Enum.each(@start_apps, &Application.ensure_all_started/1)

    # Start the Repo(s)
    IO.puts "Starting repos.."
    DocsUsers.Repo.start_link(pool_size: 1)

    # Run migrations
    run_migrations_for(:docs_users)

    # Signal shutdown
    IO.puts "Success!"
    # :init.stop()
  end

  def priv_dir(app), do: "#{:code.priv_dir(app)}"

  defp run_migrations_for(app) do
    IO.puts "Running migrations for #{app}"
    Ecto.Migrator.run(DocsUsers.Repo, migrations_path(app), :up, all: true)
  end

  defp migrations_path(app), do: Path.join([priv_dir(app), "repo", "migrations"])
  defp seed_path(app), do: Path.join([priv_dir(app), "repo", "seeds.exs"])

end
