defmodule SimpleNestedResources.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :content, :string
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

  end
end
