require 'rails_helper'

describe 'Answer API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                    "ACCEPT" => "application/json" } }

  let(:api_path) { '/api/v1/answers/1' }

  it_behaves_like "API Authorizable" do
    let(:method) { :get }
  end

  context 'authorized' do
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token) }
    let!(:question) { create(:question, author: user) }
    let(:answer_response) { json['answer'] }
    let!(:answer) { create(:answer, question: question, author: user) }
    context 'answers#show' do
      before { get '/api/v1/answers/1', params: { access_token: access_token.token }, headers: headers }
      it 'returns 200 status' do
        expect(response).to be_successful
      end
      it 'returns all public fields' do
        %w[id body created_at updated_at links files comments votes].each do |attr|
          expect(answer_response[attr]).to eq answer.send(attr).as_json
        end
      end
    end

    context 'answers#destroy' do
      before { delete '/api/v1/answers/1', params: { access_token: access_token.token }.to_json, headers: headers }
      it 'returns 200 status' do
        expect(response).to be_successful
        expect(user.authored_answers.count).to eq 0
      end
    end

    context 'answers#update' do
      before { patch '/api/v1/answers/1', params: { access_token: access_token.token, answer: { body: 'new body' } }.to_json, headers: headers }
      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns updated public fields' do
        expect(answer_response['body']).to eq 'new body'
      end
    end

    context 'answers#create' do
      before { post "/api/v1/questions/#{question.id}/answers", params: { access_token: access_token.token, answer: attributes_for(:answer), params: { author_id: user.id }  }.to_json, headers: headers }
      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'creates new answer' do
        expect(answer_response['id']).to eq 2
      end
    end
  end
end