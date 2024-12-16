RSpec.describe Api::PeopleController, type: :controller do
  describe 'GET /api/people' do
    let!(:people) { create_list(:person, 25) }

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns paginated results' do
      get :index, params: { page: 1, per_page: 10 }
      json = JSON.parse(response.body)
      expect(json['meta']['current_page']).to eq(1)
      expect(json['meta']['total_pages']).to eq(3)
      expect(json['data'].size).to eq(10)
    end

    it 'returns filtered results by email' do
      create(:person, email: 'test@example.com')
      get :index, params: { email: 'test@example.com' }
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(1)
      expect(json['data'][0]['email']).to eq('test@example.com')
    end

    it 'returns an empty array if no people match the email filter' do
      get :index, params: { email: 'nonexistent@example.com' }
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(0)
    end
  end
end
