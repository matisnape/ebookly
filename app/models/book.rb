class Book < ApplicationRecord
  belongs_to :author
  belongs_to :shop

  validates :title, :author, :shop, presence: true

  def shop_name
    shop.display_name
  end

  def author_name
    author.display_name
  end

  def to_param
  "#{id}-#{title.parameterize}"
  end
end
