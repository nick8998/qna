require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  describe 'DELETE#delete_file' do
    context 'Author' do
      let(:user) { create(:user) }
      let!(:question) { create(:question, author: user) }

      let(:answer) { create(:answer, question: question, author: user) }
      before { login(user) }

      it 'deletes file from question' do
        file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
        expect { post :create, params: { question: attributes_for(:question), params: { author_id: user.id }, post: { image: file } } }.to change(ActiveStorage::Attachment, :count).by(1)
        delete :delete_file, params: { attachment_id: question }
        expect(question.files).to eq nil
      end
    end
  end
end
