require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let!(:question) { create :question, author: other }
    it { should be_able_to :read, :all }
    it { should_not be_able_to :manage, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, create(:question, author: user), user: user}
    it { should_not be_able_to :update, create(:question, author: other), user: user}
    it { should be_able_to :update, create(:answer, author: user, question: question), user: user}
    it { should_not be_able_to :update, create(:answer, author: other, question: question), user: user}
    it { should be_able_to :update, create(:comment, user: user, commentable: question), user: user}
    it { should_not be_able_to :update, create(:comment, user: other, commentable: question), user: user}

    it { should be_able_to :vote_up, create(:vote, user: user, votable: question), user: user }
    it { should be_able_to :vote_down, create(:vote, user: user, votable: question), user: user }
    it { should be_able_to :vote_cancel, create(:vote, user: user, votable: question), user: user }
    #выдает ошибку, но ничего конкретного не написано
=begin
  
Failure/Error: it { should be_able_to :update_best, create(:answer, author: user, question: question), user: user }
       expected to be able to :update_best #<Answer id: 1, body: "Answer body 3", created_at: "2020-09-07 11:09:41", updated_at: "2020-09-07 11:09:41", question_id: 1, author_id: 2, best: false> {:user=>#<User id: 2, created_at: "2020-09-07 11:09:41", updated_at: "2020-09-07 11:09:41", email: "user31@test.com", admin: nil>}

  
=end
    it { should be_able_to :update_best, create(:answer, author: user, question: question), user: user }
  end


end