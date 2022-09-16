require 'rails_helper'

describe 'GET api/people', type: :request do
  before do
    @people = FactoryBot.create_list(:person, 21)
    @people = @people.sort_by(&:name)
  end

  it 'should return a list of people sorted by name using default paging' do
    expected_people = @people.take(10)

    get "/api/people"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(10)
    expect(expected_people.first.id).to eq(json.first[:id])
    expect(expected_people.last.id).to eq(json.last[:id])
  end

  it 'should return a list of people sorted by name using the paging params' do
    expected_people = @people.slice(5, 5)

    get "/api/people?page=2&per_page=5"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(5)
    expect(expected_people.first.id).to eq(json.first[:id])
    expect(expected_people.last.id).to eq(json.last[:id])
  end

  it 'should return a the last person on the last page' do
    expected_person = @people.last

    get "/api/people?page=3&per_page=10"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(1)
    expect(expected_person.id).to eq(json.first[:id])
  end

  it 'should return a list of people sorted by name using the email filter' do
    random_people = @people.shuffle
    expected_people = [random_people.first, random_people.last].sort_by(&:name)
    expected_people.each { |person| person.update_column(:email, 'foo@bar.com') }

    get "/api/people?email=foo@bar.com"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(2)
    expect(expected_people.first.id).to eq(json.first[:id])
    expect(expected_people.last.id).to eq(json.last[:id])
  end

  it 'should handle requests beyond the max page' do
    get "/api/people?page=99&per_page=5"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(0)
    expect([]).to eq(json)
  end

  it 'should ignore a bogus page value' do
    expected_people = @people.take(10)

    get "/api/people?page=foo&per_page=10"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(10)
    expect(expected_people.first.id).to eq(json.first[:id])
    expect(expected_people.last.id).to eq(json.last[:id])
  end

  it 'should ignore a bogus per page value' do
    expected_people = @people.take(10)

    get "/api/people?page=1&per_page=foo"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to have_http_status(200)
    expect(json.size).to eq(10)
    expect(expected_people.first.id).to eq(json.first[:id])
    expect(expected_people.last.id).to eq(json.last[:id])
  end  
end
