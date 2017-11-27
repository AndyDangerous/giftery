defmodule Giftery.Repo.Migrations.CreateGifts do
  use Ecto.Migration

  def change do
    create table(:gifts) do
      add :name, :string
      add :url, :string
      add :notes, :string
      add :available, :boolean, default: false, null: false
      add :author_id, references(:authors, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:gifts, [:author_id])
  end
end
