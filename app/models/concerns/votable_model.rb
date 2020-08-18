module VotableModel
  extend ActiveSupport::Concern

  def author_exist?(user)
    vote.votable.author_id != user.id && find_user(user).nil?
  end

  def create_positive_vote(user)
    update_vote(vote.value+1)
    add_user(user)
    find_user(user).update_attribute(:voted, true)
  end

  def create_negative_vote(user)
    update_vote(vote.value-1)
    add_user(user)
    find_user(user).update_attribute(:voted, false)
  end

  def add_user(user)
    vote.users << user
  end

  def cancel(user)
    if find_user(user).present?
      if find_user(user).voted
        update_vote(vote.value - 1)
      else
        update_vote(vote.value + 1)
      end
      find_user(user).destroy
    end
  end

  def find_user(user)
    vote.votes_users.find_by(user_id: user.id)
  end

  def update_vote(act)
    vote.update_attribute(:value, act)
  end

 
  
end