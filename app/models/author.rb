class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :first_name, :last_name, presence: true

  def display_name
    "#{last_name}, #{first_name}"
  end

  def to_param
    "#{id}-#{display_name.parameterize}"
  end
end
