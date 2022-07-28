# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  it { is_expected.to have_many :people }

  describe '.search_by_name' do
    let!(:company) { create(:company, name: 'Acme, Inc') }

    it 'performs case-insensitive partial match of name' do
      result = described_class.search_by_name('CmE')
      expect(result.first.name).to eq('Acme, Inc')
    end
  end
end
