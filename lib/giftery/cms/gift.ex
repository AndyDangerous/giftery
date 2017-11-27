defmodule Giftery.CMS.Gift do
  use Ecto.Schema
  import Ecto.Changeset
  alias Giftery.CMS.Gift


  schema "gifts" do
    field :available, :boolean, default: false
    field :name, :string
    field :notes, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Gift{} = gift, attrs) do
    gift
    |> cast(attrs, [:name, :url, :notes, :available])
    |> validate_required([:name, :url, :notes, :available])
  end
end
