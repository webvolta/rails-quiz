# app/serializers/person_serializer.rb
class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_number, :company_name

  def company_name
    object.company&.name
  end
end
