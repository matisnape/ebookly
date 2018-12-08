class Api::V1::BookSerializer < Api::V1::BaseSerializer
  attributes :id, :title, :created_at, :updated_at

  belongs_to :author
  belongs_to :shop
end
