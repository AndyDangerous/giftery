defmodule Giftery.Repo.Migrations.CreateGifts do
  use Ecto.Migration

  def change do
    create table(:gifts) do
      add :name, :string
      add :url, :string
      add :notes, :string
      add :available, :boolean, default: false, null: false

      timestamps()
    end

  end
end
