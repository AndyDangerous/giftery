defmodule GifteryWeb.CMS.GiftView do
  use GifteryWeb, :view

  alias Giftery.CMS

  def author_name(%CMS.Gift{author: author}) do
    author.user.name
  end
end
