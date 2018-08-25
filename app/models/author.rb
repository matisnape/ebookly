class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :first_name, :last_name, presence: true

  def display_author
    "#{last_name}, #{first_name}"
  end
end
