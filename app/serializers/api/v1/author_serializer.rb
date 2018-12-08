class Api::V1::AuthorSerializer < Api::V1::BaseSerializer
  attributes :id, :first_name, :last_name, :created_at, :updated_at

  has_many :books
end
