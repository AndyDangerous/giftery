# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :giftery,
  ecto_repos: [Giftery.Repo]

# Configures the endpoint
config :giftery, GifteryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m9LeFe5g4VxtgtIjDG/9k15RGOAQ5VZAdfrCWV9c36K/G3VERCM1UTDVE166J0xa",
  render_errors: [view: GifteryWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Giftery.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
