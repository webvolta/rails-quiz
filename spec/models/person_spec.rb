# == Schema Information
#
# Table name: people
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  phone :string           not null
#  email        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#

require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to belong_to(:company).optional }
end
