class Book < ApplicationRecord
  include PgSearch

  belongs_to :author
  belongs_to :shop
  accepts_nested_attributes_for :author, reject_if: :all_blank

  validates :title, :shop, presence: true

  pg_search_scope :search_by_title, against: [:title], using: {
    tsearch: { any_word: true, prefix: true }
  }

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
