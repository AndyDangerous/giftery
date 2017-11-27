defmodule Giftery.CMS do
  @moduledoc """
  The CMS context.
  """

  import Ecto.Query, warn: false
  alias Giftery.Repo
  alias Giftery.CMS.{Page, Author, Gift}
  alias Giftery.Accounts

  def inc_page_views(%Page{} = page) do
    {1, [%Page{views: views}]} =
      Repo.update_all(from(p in Page, where: p.id == ^page.id),
      [inc: [views: 1]], returning: [:views])

    put_in(page.views, views)
  end

  def ensure_author_exists(%Accounts.User{} = user) do
    %Author{user_id: user.id}
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.unique_constraint(:user_id)
    |> Repo.insert()
    |> handle_existing_author()
  end

  defp handle_existing_author({:ok, author}), do: author
  defp handle_existing_author({:error, changeset}) do
    Repo.get_by!(Author, user_id: changeset.data.user_id)
  end

  @doc """
  Returns the list of pages.

  ## Examples

      iex> list_pages()
      [%Page{}, ...]

  """
  def list_pages do
    Page
    |> Repo.all()
    |> Repo.preload(author: [user: :credential])
  end

  @doc """
  Gets a single page.

  Raises `Ecto.NoResultsError` if the Page does not exist.

  ## Examples

      iex> get_page!(123)
      %Page{}

      iex> get_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_page!(id) do
    Page
    |> Repo.get(id)
    |> Repo.preload(author: [user: :credential])
  end

  @doc """
  Creates a page.

  ## Examples

      iex> create_page(%{field: value})
      {:ok, %Page{}}

      iex> create_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_page(%Author{} = author, attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Ecto.Changeset.put_change(:author_id, author.id)
    |> Repo.insert()
  end

  @doc """
  Updates a page.

  ## Examples

      iex> update_page(page, %{field: new_value})
      {:ok, %Page{}}

      iex> update_page(page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Page.

  ## Examples

      iex> delete_page(page)
      {:ok, %Page{}}

      iex> delete_page(page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking page changes.

  ## Examples

      iex> change_page(page)
      %Ecto.Changeset{source: %Page{}}

  """
  def change_page(%Page{} = page) do
    Page.changeset(page, %{})
  end

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list_authors()
      [%Author{}, ...]

  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Gets a single author.

  Raises `Ecto.NoResultsError` if the Author does not exist.

  ## Examples

      iex> get_author!(123)
      %Author{}

      iex> get_author!(456)
      ** (Ecto.NoResultsError)

  """
  def get_author!(id) do
    Author
    |> Repo.get!(id)
    |> Repo.preload(user: :credential)
  end

  @doc """
  Creates a author.

  ## Examples

      iex> create_author(%{field: value})
      {:ok, %Author{}}

      iex> create_author(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a author.

  ## Examples

      iex> update_author(author, %{field: new_value})
      {:ok, %Author{}}

      iex> update_author(author, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Author.

  ## Examples

      iex> delete_author(author)
      {:ok, %Author{}}

      iex> delete_author(author)
      {:error, %Ecto.Changeset{}}

  """
  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking author changes.

  ## Examples

      iex> change_author(author)
      %Ecto.Changeset{source: %Author{}}

  """
  def change_author(%Author{} = author) do
    Author.changeset(author, %{})
  end

  @doc """
  Returns the list of gifts.

  ## Examples

      iex> list_gifts()
      [%Gift{}, ...]

  """
  def list_gifts do
    Repo.all(Gift)
  end

  @doc """
  Gets a single gift.

  Raises `Ecto.NoResultsError` if the Gift does not exist.

  ## Examples

      iex> get_gift!(123)
      %Gift{}

      iex> get_gift!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gift!(id), do: Repo.get!(Gift, id)

  @doc """
  Creates a gift.

  ## Examples

      iex> create_gift(%{field: value})
      {:ok, %Gift{}}

      iex> create_gift(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gift(attrs \\ %{}) do
    %Gift{}
    |> Gift.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gift.

  ## Examples

      iex> update_gift(gift, %{field: new_value})
      {:ok, %Gift{}}

      iex> update_gift(gift, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gift(%Gift{} = gift, attrs) do
    gift
    |> Gift.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Gift.

  ## Examples

      iex> delete_gift(gift)
      {:ok, %Gift{}}

      iex> delete_gift(gift)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gift(%Gift{} = gift) do
    Repo.delete(gift)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gift changes.

  ## Examples

      iex> change_gift(gift)
      %Ecto.Changeset{source: %Gift{}}

  """
  def change_gift(%Gift{} = gift) do
    Gift.changeset(gift, %{})
  end
end
