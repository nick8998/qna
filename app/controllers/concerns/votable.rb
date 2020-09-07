module Votable
  extend ActiveSupport::Concern

  include RenderJson

  included do
    authorize_resource
  end
  
  def vote_up
    if !current_user.author_of?(votable)
      votable.create_positive_vote(current_user)
    end
    render_json_voting
  end


  def vote_down
    if !current_user.author_of?(votable)
      votable.create_negative_vote(current_user)
    end
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