require "rails_helper"

describe "people/index.html.slim" do
  it "displays the users in a table" do
    # Setup test data
    company = FactoryBot.create(:company, name: "Test Company")
    people = FactoryBot.create_list(:person, 12, company: company)

    # Assign instance variable used in the view
    assign(:people, Kaminari.paginate_array(people).page(1).per(10))

    # Render the view
    render

    # Check for table headers
    expect(rendered).to have_selector("table.table thead tr th", text: "ID")
    expect(rendered).to have_selector("table.table thead tr th", text: "Name")
    expect(rendered).to have_selector("table.table thead tr th", text: "Phone number")
    expect(rendered).to have_selector("table.table thead tr th", text: "Email address")
    expect(rendered).to have_selector("table.table thead tr th", text: "Company")

    # Check for table rows
    people.first(10).each do |person|
      expect(rendered).to have_selector("table.table tbody tr th", text: person.id.to_s)
      expect(rendered).to have_selector("table.table tbody tr td", text: person.name)
      expect(rendered).to have_selector("table.table tbody tr td", text: person.phone_number)
      expect(rendered).to have_selector("table.table tbody tr td", text: person.email)
      expect(rendered).to have_selector("table.table tbody tr td", text: company.name)
    end

    # Check for pagination
    expect(rendered).to have_selector(".pagination")
  end
end
