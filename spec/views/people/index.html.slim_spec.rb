require 'rails_helper'

RSpec.describe 'people/index' do
  let(:company) { instance_double(Company, name: 'test inc') }

  let(:person) do
    instance_double(Person,
                    id: 1,
                    name: 'test',
                    phone_number: '999-999-9999',
                    email: 'test@example.com',
                    company: company
                   )
  end

  it 'displays a table of users' do
    assign(:people, [person])

    render

    expect(rendered).to match(/1/)
    expect(rendered).to match(/test/)
    expect(rendered).to match(/999-999-9999/)
    expect(rendered).to match(/test@example.com/)
    expect(rendered).to match(/test inc/)
  end
end
