require 'rails_helper'

RSpec.describe 'Listing people', type: :feature do
  before do
    FactoryBot.create(
      :person,
      name: 'Foo Bar',
      phone_number: 'Biz',
      email: 'Baz'
    )
  end

  scenario 'with valid users' do
    visit people_path

    aggregate_failures do
      expect(page).to have_content('Foo Bar')
      expect(page).to have_content('Baz')
    end
  end

  scenario 'with more users than allowed in view' do
    people_list = FactoryBot.create_list(:person, 11)
    last_record = people_list.last
    last_record.update(name: 'Jane Doe', email: 'jane@doe.com')

    visit people_path

    expect(page).to_not have_content('Jane Doe')

    click_on 'Next'

    expect(page).to have_content('Jane Doe')
  end

  scenario 'New person', type: :feature do
    visit new_person_path

    expect(page).to have_field :person_name
  end
end
