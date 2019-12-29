defmodule SimpleNestedResources.Repo do
  use Ecto.Repo,
    otp_app: :simple_nested_resources,
    adapter: Ecto.Adapters.Postgres
end
