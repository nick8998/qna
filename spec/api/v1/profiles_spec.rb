require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                    "ACCEPT" => "application/json" } }

  let(:api_path) { '/api/v1/profiles/me' }

  it_behaves_like "API Authorizable" do
    let(:method) { :get }
  end

  let(:me) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: me.id) }
  let!(:users) { create_list(:user, 3) }

  context 'authorized' do
    before { get '/api/v1/profiles/me', params: { access_token: access_token.token }, headers: headers }
    it 'returns 200 status' do
      expect(response).to be_successful
    end
    it 'returns all public fields' do
      %w[id email admin created_at updated_at].each do |attr|
        expect(json['user'][attr]).to eq me.send(attr).as_json
      end
    end
    it 'does not return private fields' do
      %w[password encrypted_password].each do |attr|
        expect(json['user']).to_not have_key(attr)
      end
    end
  end

  context 'other_profiles' do
    before { get '/api/v1/profiles/other_profiles', params: { access_token: access_token.token }, headers: headers }
    let(:user) { users.last }
    let(:users_response) { json['users'].last }
    it 'returns list of answers' do
      expect(json['users'].size).to eq 3
    end
    it 'returns all public fields' do
      %w[id email admin created_at updated_at].each do |attr|
        expect(users_response[attr]).to eq user.send(attr).as_json
      end
    end
  end
end