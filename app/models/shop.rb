class Shop < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true

  def display_shop
    name
  end
end
