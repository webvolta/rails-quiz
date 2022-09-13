class PersonSerializer < ActiveModel::Serializer
  belongs_to :company, optional: true

  attributes :id, :name, :phone_number, :email
end