module VotableModel
  extend ActiveSupport::Concern

  def create_positive_vote(user)
    votes.create!(value: 1, user: user) if votes.find_by(user: user).nil?
  end

  def create_negative_vote(user)
    votes.create!(value: -1, user: user) if votes.find_by(user: user).nil?
  end

  def cancel(user)
    if find_user(user).present?
      find_user(user).destroy
    end
  end

  def votes_sum
    votes.sum(:value)
  end

  private

  def find_user(user)
    votes.find_by(user: user)
  end
end