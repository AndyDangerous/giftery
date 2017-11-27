defmodule Giftery.CMS.Author do
  use Ecto.Schema
  import Ecto.Changeset
  alias Giftery.CMS.{Author, Page, Gift}


  schema "authors" do
    field :bio, :string
    field :genre, :string
    field :role, :string

    has_many :pages, Page
    has_many :gifts, Gift
    belongs_to :user, Giftery.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Author{} = author, attrs) do
    author
    |> cast(attrs, [:bio, :role, :genre])
    |> validate_required([:bio, :role, :genre])
    |> unique_constraint(:user_id)
  end
end
