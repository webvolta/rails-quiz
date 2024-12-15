require "rails_helper"

describe "companies/index.html.slim" do
  let!(:company1) { FactoryBot.create(:company, name: "Company One", created_at: Time.zone.parse("2023-01-01")) }
  let!(:company2) { FactoryBot.create(:company, name: "Company Two", created_at: Time.zone.parse("2023-01-02")) }

  it "displays the companies in a table" do
    assign(:companies, Kaminari.paginate_array([company1, company2]).page(1).per(10))

    render

    # Check table headers
    expect(rendered).to have_selector("table.table thead tr th", text: "ID")
    expect(rendered).to have_selector("table.table thead tr th", text: "Name")
    expect(rendered).to have_selector("table.table thead tr th", text: "Created At")
    expect(rendered).to have_selector("table.table thead tr th", text: "Actions")

    # Check rows for companies
    expect(rendered).to have_selector("table.table tbody tr th", text: company1.id.to_s)
    expect(rendered).to have_selector("table.table tbody tr td", text: company1.name)
    expect(rendered).to have_selector("table.table tbody tr td", text: company1.created_at.strftime("%m/%d/%Y"))
    expect(rendered).to have_link("Edit", href: edit_company_path(company1))

    expect(rendered).to have_selector("table.table tbody tr th", text: company2.id.to_s)
    expect(rendered).to have_selector("table.table tbody tr td", text: company2.name)
    expect(rendered).to have_selector("table.table tbody tr td", text: company2.created_at.strftime("%m/%d/%Y"))
    expect(rendered).to have_link("Edit", href: edit_company_path(company2))
  end

  it "displays a link to create a new company" do
    assign(:companies, Kaminari.paginate_array([company1, company2]).page(1).per(10))

    render
    expect(rendered).to have_link("New Company", href: new_company_path)
  end
end
