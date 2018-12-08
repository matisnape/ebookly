class Api::V1::ShopSerializer < Api::V1::BaseSerializer
  attributes :id, :name, :created_at, :updated_at

  has_many :books
end
