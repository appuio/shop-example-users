use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :docs_users, DocsUsers.Endpoint,
  secret_key_base: "qUp+rTegsJxtUdhjmepJSQErXT3cdPkgIkj9iuz3ewts2mr26bIeOt60t/XQMZKD"

# Configure your database
config :docs_users, DocsUsers.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "secret",
  database: "postgres",
  hostname: "users-db",
  pool_size: 20
