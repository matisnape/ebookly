class Shop < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, :slug, presence: true
  validates_uniqueness_of :name, { message: "Name is already taken" }
  validate :uniqueness_of_slug

  before_validation :to_slug

  scope :ordered_by_created_at, -> { order(created_at: :desc) }

  def display_name
    name
  end

  def to_slug
    self.slug = name&.parameterize
  end
  alias_method :to_param, :to_slug

  def uniqueness_of_slug
    if slug_exists?
      errors.add(:name, 'is not unique enough. Maybe this shop already exists?')
    end
  end

  private

  def slug_exists?
    name && Shop.where.not(id: id).exists?(slug: to_slug)
  end
end
