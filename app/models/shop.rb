class Shop < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, :slug, presence: true
  validates_uniqueness_of :name, { message: "Name is already taken" }
  validate :uniqueness_of_slug

  before_validation :to_slug

  def display_name
    name
  end

  def to_slug
    self.slug = name&.parameterize
  end
  alias_method :to_param, :to_slug

  def uniqueness_of_slug
    if name and Shop.exists?(slug: to_slug)
      errors.add(:name, 'is not unique enough. Maybe this shop already exists?')
    end
  end
end
