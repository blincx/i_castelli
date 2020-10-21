# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ic,
  ecto_repos: [Ic.Repo]

# Configures the endpoint
config :ic, IcWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VA/TrofJ46sc5JEh3YegZLiLFdLPgBRr4LjEPgup0/e2jY2quDibVXqvbJxpBIUu",
  render_errors: [view: IcWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ic.PubSub,
  live_view: [signing_salt: "RZV9ySv9"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
