require 'rails_helper'

RSpec.shared_examples 'votable_model' do
  let(:model) { described_class }
  let(:author) { create(:user) }
  let(:user) { create(:user) }

  describe '#author_exist?' do
    it 'return false' do
      new_model = create(model.to_s.underscore.to_sym, author: author)
      new_model.build_vote.save
      expect(new_model).not_to be_author_exist(author)
    end
    it 'return true' do
      new_model = create(model.to_s.underscore.to_sym, author: author)
      new_model.build_vote.save
      expect(new_model).to be_author_exist(user)
    end
  end
end

RSpec.describe Question do
  it_behaves_like 'votable_model'
end
