require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  describe 'DELETE#delete_file' do
    context 'Author' do
      let(:user) { create(:user) }
      let!(:question) { create(:question, author: user) }

      let(:answer) { create(:answer, question: question, author: user) }
      before { login(user) }

      it 'deletes file from question' do
        question.files.attach(create_file_blob)
        question.files.attach(create_file_blob(filename: "image1.jpg"))
        expect{ delete :destroy, params: { id: 1 }, format: :js }.to change(question.files, :count).by(-1)
      end

      it 'deletes file from answer' do
        answer.files.attach(create_file_blob)
        answer.files.attach(create_file_blob(filename: "image1.jpg"))
        expect{ delete :destroy, params: { id: 1 }, format: :js }.to change(answer.files, :count).by(-1)
      end
    end
    context 'Not author' do
      let(:user) { create(:user) }
      let(:user1) { create(:user) }
      let!(:question) { create(:question, author: user) }

      let(:answer) { create(:answer, question: question, author: user) }
      before { login(user1) }

      it 'deletes file from question' do
        question.files.attach(create_file_blob)
        question.files.attach(create_file_blob(filename: "image1.jpg"))
        expect{ delete :destroy, params: { id: 1 }, format: :js }.not_to change(question.files, :count)
      end

      it 'deletes file from answer' do
        answer.files.attach(create_file_blob)
        answer.files.attach(create_file_blob(filename: "image1.jpg"))
        expect{ delete :destroy, params: { id: 1 }, format: :js }.not_to change(answer.files, :count)
      end
    end
  end
end
