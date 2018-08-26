class Book < ApplicationRecord
  belongs_to :author
  belongs_to :shop

  validates :title, :author, :shop, presence: true

  def to_param
  "#{id}-#{title.parameterize}"
  end
end
