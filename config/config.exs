# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :docs_users,
  ecto_repos: [DocsUsers.Repo]

# Configures the endpoint
config :docs_users, DocsUsers.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "<REPLACE_THIS>",
  render_errors: [view: DocsUsers.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DocsUsers.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian for authentication
config :guardian, Guardian,
  hooks: GuardianDb,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "docs_users",
  ttl: { 14, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "<REPLACE_THIS>",
  serializer: DocsUsers.V1.GuardianSerializer

config :guardian_db, GuardianDb,
  repo: DocsUsers.Repo

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
