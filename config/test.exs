use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :docs_users, DocsUsers.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :docs_users, DocsUsers.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DB_USERNAME"),
  password: System.get_env("DB_PASSWORD"),
  database: System.get_env("DB_DATABASE"),
  hostname: System.get_env("DB_HOSTNAME"),
  pool: Ecto.Adapters.SQL.Sandbox
