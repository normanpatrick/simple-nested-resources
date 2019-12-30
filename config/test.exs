use Mix.Config

# Configure your database
config :simple_nested_resources, SimpleNestedResources.Repo,
  username: "nbp",
  password: "",
  database: "simple_nested_resources_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :simple_nested_resources, SimpleNestedResourcesWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
