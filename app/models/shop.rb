class Shop < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true

  def display_name
    name
  end
end
