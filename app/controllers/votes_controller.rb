class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_vote

  def vote_up
    if @vote.question.author_id != current_user.id || @vote.votes_users.find_by(user_id: current_user.id).nil?
      @vote.update_attribute(:votes_up, @vote.votes_up + 1)
      @vote.users << current_user
      @vote.votes_users.find_by(user_id: current_user.id).update_attribute(:voted, true)
    end
    respond_to do |format|
      if @vote.persisted?
        format.json { render json: @vote }
      else
        format.json { render json: @vote.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def vote_down
    if @vote.question.author_id != current_user.id || @vote.votes_users.find_by(user_id: current_user.id).nil?
      @vote.update_attribute(:votes_down, @vote.votes_down + 1)
      @vote.users << current_user
      @vote.votes_users.find_by(user_id: current_user.id).update_attribute(:voted, false)
    end
  end

  def vote_cancel
    if @vote.votes_users.find_by(user_id: current_user.id).present?
      if @vote.votes_users.find_by(user_id: current_user.id).voted
        @vote.update_attribute(:votes_up, @vote.votes_up - 1)
      else
        @vote.update_attribute(:votes_down, @vote.votes_down - 1)
      end
      @vote.votes_users.find_by(user_id: current_user.id).destroy
    end
  end

  private

  def find_vote
    @vote = Vote.find(params[:id])
  end
end
