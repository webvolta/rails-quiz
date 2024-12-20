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

  scenario 'New person', type: :feature do
    visit new_person_path

    expect(page).to have_field :person_name
  end

  scenario 'New person with errors', type: :feature do
    visit new_person_path

    fill_in :person_name, with: 'John Doe'

    click_on 'Create Person'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Phone number can't be blank")
  end
end
