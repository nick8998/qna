class User::RewardsController < User::BaseController
  before_action :set_rewards, only: %i[index]

  def index; end

  private 

  def set_rewards
    @rewards = current_user.rewards
  end
end
