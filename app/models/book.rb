class Book < ApplicationRecord
  belongs_to :author
  belongs_to :shop

  validates :title, :author, :shop, presence: true
end
