module Commentable
  extend ActiveSupport::Concern

  include RenderJson

  included do
    after_action :publish_commentable, only: %i[create_comment]
  end

  def create_comment
    @comment = commentable.comments.new(comment_params.merge(user: current_user))
    if @comment.save
      render_json_comment
    end
  end


  def render_json_comment
    respond_to do |format|
      format.json { render_json(@comment) }
    end
  end

  private

  def commentable
    controller_name.classify.constantize.find(params[:id])
  end

  def comment_params
    params.require(:commentable).permit(:body)
  end

  def publish_commentable
    gon.commentable_type = commentable.class.name.pluralize.downcase
    gon.commentable_id = @comment.commentable_id
    return if commentable.errors.any?
    ActionCable.server.broadcast("/questions/#{params[:id]}/create_comment", { comment: @comment } ) 
  end

end