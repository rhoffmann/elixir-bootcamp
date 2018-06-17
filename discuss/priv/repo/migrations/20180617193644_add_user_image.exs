defmodule Discuss.Repo.Migrations.AddUserImage do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :image_url, :string
    end
  end
end
