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

  def self.search_by_name(name)
    self.where('name LIKE ?', '%' + self.sanitize_sql_like(name) + '%')
  end
end
