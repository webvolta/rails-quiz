require 'rails_helper'

describe 'api/companies', type: :request do
  before do
    @companies = FactoryBot.create_list(:company, 21)
    @companies = @companies.sort_by(&:name)
  end

  it 'should return a list of companies sorted by name using default paging' do
    expected_companies = @companies.take(10)

    get "/api/companies"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(10)
    expect(expected_companies.first.id).to eq(json.first[:id])
    expect(expected_companies.last.id).to eq(json.last[:id])
  end

  it 'should return a list of companies sorted by name using the paging params' do
    expected_companies = @companies.slice(5, 5)

    get "/api/companies?page=2&per_page=5"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(5)
    expect(expected_companies.first.id).to eq(json.first[:id])
    expect(expected_companies.last.id).to eq(json.last[:id])
  end

  it 'should return a the last company on the last page' do
    expected_company = @companies.last

    get "/api/companies?page=3&per_page=10"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(1)
    expect(expected_company.id).to eq(json.first[:id])
  end

  it 'should return a list of companies sorted by name using the name filter' do
    company1 = @companies.first
    company2 = @companies.last
    company1.update_column(:name, 'We Make Widgets Corp')
    company2.update_column(:name, 'ABC WIDGETS INC')

    get "/api/companies?name=wIDgetS"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(2)
    expect(company2.id).to eq(json.first[:id])
    expect(company1.id).to eq(json.last[:id])
  end

  it 'should handle requests beyond the max page' do
    get "/api/companies?page=99&per_page=5"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(0)
    expect([]).to eq(json)
  end

  it 'should ignore a bogus page value' do
    expected_companies = @companies.take(10)

    get "/api/companies?page=foo&per_page=10"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(10)
    expect(expected_companies.first.id).to eq(json.first[:id])
    expect(expected_companies.last.id).to eq(json.last[:id])
  end

  it 'should ignore a bogus per page value' do
    expected_companies = @companies.take(10)

    get "/api/companies?page=1&per_page=foo"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(10)
    expect(expected_companies.first.id).to eq(json.first[:id])
    expect(expected_companies.last.id).to eq(json.last[:id])
  end
end
