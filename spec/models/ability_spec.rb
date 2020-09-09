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
    it { should be_able_to :create, Link }
    it { should be_able_to :create_comment, Answer }
    it { should be_able_to :create_comment, Question }
    it { should be_able_to :destroy, Question }
    it { should be_able_to :destroy, Answer }
    it { should be_able_to :destroy, Link }
    it { should be_able_to :destroy, Comment }

    it { should be_able_to :update, create(:question, author: user), user: user}
    it { should_not be_able_to :update, create(:question, author: other), user: user}

    it { should be_able_to :update, create(:answer, author: user, question: question), user: user}
    it { should_not be_able_to :update, create(:answer, author: other, question: question), user: user}

    it { should be_able_to :update, create(:comment, user: user, commentable: question), user: user}
    it { should_not be_able_to :update, create(:comment, user: other, commentable: question), user: user}

    it { should be_able_to :vote_up, create(:answer, author: other, question: question), user: user }
    it { should_not be_able_to :vote_up, create(:answer, author: user, question: question), user: user }

    it { should be_able_to :vote_down, create(:answer, author: other, question: question), user: user }
    it { should_not be_able_to :vote_down, create(:answer, author: user, question: question), user: user }

    it { should be_able_to :vote_cancel, create(:answer, author: other, question: question), user: user }
    it { should_not be_able_to :vote_cancel, create(:answer, author: user, question: question), user: user }

    it { should be_able_to :update_best, Answer, user: other }

  end


end