module Commentable
  extend ActiveSupport::Concern

  include RenderJson

  def create_comment
    @comment = commentable.comments.new(comment_params.merge(user: current_user))
    @comment.save!
    render_json_comment
  end


  def render_json_comment
    respond_to do |format|
      format.json { render_json(commentable.comments.last) }
    end
  end

  private

  def commentable
    controller_name.classify.constantize.find(params[:id])
  end

  def comment_params
    params.require(:commentable).permit(:body)
  end

end