class Shop < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, :slug, presence: true
  validates_uniqueness_of :name

  def display_name
    name
  end

  def slug
    name.parameterize
  end

  def to_param
    slug
  end

  def self.add_slugs
    update(slug: slug(name))
  end
end
