module Votable
  extend ActiveSupport::Concern

  def render_json_voting
    respond_to do |format|
      if @vote.persisted?
        format.json { render_json(@vote) }
      else
        format.json { render_errors(@vote) }
      end
    end
  end

  def render_errors(item)
    render json: item.errors.full_messages, status: :unprocessable_entity
  end

  def render_json(item)
    render json: @vote
  end

  def author_exist?
    @vote.votable.author_id != current_user.id && @vote.votes_users.find_by(user_id: current_user.id).nil?
  end

  def update_and_add_user(votes = :votes_up, vote = @vote.votes_up, bool = true)
    @vote.update_attribute(votes, vote + 1)
    @vote.users << current_user
    @vote.votes_users.find_by(user_id: current_user.id).update_attribute(:voted, bool)
  end

  def cancel
    if @vote.votes_users.find_by(user_id: current_user.id).present?
      if @vote.votes_users.find_by(user_id: current_user.id).voted
        @vote.update_attribute(:votes_up, @vote.votes_up - 1)
      else
        @vote.update_attribute(:votes_down, @vote.votes_down - 1)
      end
      @vote.votes_users.find_by(user_id: current_user.id).destroy
    end
  end


end