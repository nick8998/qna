require 'rails_helper'

describe 'Question API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                    "ACCEPT" => "application/json" } }

  let(:api_path) { '/api/v1/questions/1' }

  it_behaves_like "API Authorizable" do
    let(:method) { :get }
  end

  context 'authorized' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token) }
    let!(:question) { create(:question, author: user) }
    let(:question_response) { json['question'] }

    context 'questions#show' do
      before { get '/api/v1/questions/1', params: { access_token: access_token.token }, headers: headers }
      it 'returns 200 status' do
        expect(response).to be_successful
      end
      it 'returns all public fields' do
        %w[id title body created_at updated_at links files comments votes].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end
    end

    context 'questions#destroy' do
      before { delete '/api/v1/questions/1', params: { access_token: access_token.token }.to_json, headers: headers }
      it 'returns 200 status' do
        expect(response).to be_successful
        expect(user.authored_questions.count).to eq 0
      end
    end

    context 'questions#update' do
      before { patch '/api/v1/questions/1', params: { access_token: access_token.token, question: { title: 'new title', body: 'new body' } }.to_json, headers: headers }
      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns updated public fields' do
        expect(question_response['title']).to eq 'new title'
        expect(question_response['body']).to eq 'new body'
      end
    end

    context 'questions#create' do
      before { post '/api/v1/questions', params: { access_token: access_token.token, question: attributes_for(:question), params: { author_id: user.id }  }.to_json, headers: headers }
      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'creates new question' do
        expect(question_response['id']).to eq 2
      end
    end
  end
end