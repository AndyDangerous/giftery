defmodule GifteryWeb.CMS.PageView do
  use GifteryWeb, :view

  alias Giftery.CMS

  def author_name(%CMS.Page{author: author}) do
    author.user.name
  end
end
