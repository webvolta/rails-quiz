require "rails_helper"

describe "people/index.html.slim" do
  let(:company) { Company.create(name: "Default Company") }
  let(:first_person) { Person.create(name: "John Doe", email: "john@doe.com.br", phone_number: "Foo", company: company) }
  let(:second_person) { Person.create(name: "Jane Doe", email: "jane@doe.com.br", phone_number: "Bar", company: company) }
  it "Displays the users" do
    assign(:people, [first_person, second_person])
    render

    expect(rendered).to match(/John/)            # name (John)
    expect(rendered).to match(/Foo/)             # phone number
    expect(rendered).to match(/Jane/)            # name (Jane)
    expect(rendered).to match(/Bar/)             # phone number
    expect(rendered).to match(/Default Company/) # company name
  end
end
