class CompanySerializer < ActiveModel::Serializer
  has_many :people

  attributes :id, :name
end