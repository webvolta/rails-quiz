# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ApplicationRecord
  has_many :people

  scope :by_name_like, ->(name) {
    # NOTE: this can get dicey w/r/t bypassing indexes depending on the DB, but keeping things simple for now
    where("lower(companies.name) like :name", name: "%#{name.downcase}%")
  }
end
