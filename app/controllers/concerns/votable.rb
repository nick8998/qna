module Votable
  extend ActiveSupport::Concern

  include RenderJson

  def vote_up
    if !current_user.author_of?(object_name)
      object_name.create_positive_vote(current_user)
    end
    render_json_voting
  end


  def vote_down
    if !current_user.author_of?(object_name)
      object_name.create_negative_vote(current_user)
    end
    render_json_voting
  end

  def vote_cancel
    object_name.cancel(current_user)
    render_json_voting
  end

  def render_json_voting
    respond_to do |format|
      format.json { render_json(object_name.votes) }
    end
  end

  private

  def object_name
    controller_name.classify.constantize.find(params[:id])
  end

end