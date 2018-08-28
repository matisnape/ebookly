class Shop < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, :slug, presence: true
  validates_uniqueness_of :name, :slug

  before_validation :to_slug

  def display_name
    name
  end

  def to_slug
    self.slug = name&.parameterize
  end
  alias_method :to_param, :to_slug
end
