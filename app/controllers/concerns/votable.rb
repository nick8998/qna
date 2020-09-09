module Votable
  extend ActiveSupport::Concern

  include RenderJson
  
  def vote_up
    votable.create_positive_vote(current_user)
    render_json_voting
  end


  def vote_down
    votable.create_negative_vote(current_user)
    render_json_voting
  end

  def vote_cancel
    votable.cancel(current_user)
    render_json_voting
  end

  def render_json_voting
    respond_to do |format|
      format.json { render_json(votable.votes) }
    end
  end

  private

  def votable
    controller_name.classify.constantize.find(params[:id])
  end

end