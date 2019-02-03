class Book < ApplicationRecord
  belongs_to :author
  belongs_to :shop
  accepts_nested_attributes_for :author, reject_if: :all_blank

  validates :title, :shop, presence: true

  def shop_name
    shop.display_name
  end

  def author_name
    author.display_name
  end

  def to_param
  "#{id}-#{title.parameterize}"
  end

  def test(attributes)
    attributes["author_id"].blank?
  end

end
