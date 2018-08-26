class Shop < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true
  validates_uniqueness_of :name

  def display_name
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
