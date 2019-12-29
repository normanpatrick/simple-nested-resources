# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :simple_nested_resources,
  ecto_repos: [SimpleNestedResources.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :simple_nested_resources, SimpleNestedResourcesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "71gvmuwG4wbyZmQ0LlTveg+LWcmToqNCoCBGNNgfZi9sI06UbsWt2dcaP5zgNL11",
  render_errors: [view: SimpleNestedResourcesWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SimpleNestedResources.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
