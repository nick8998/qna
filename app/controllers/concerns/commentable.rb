module Commentable
  extend ActiveSupport::Concern

  include RenderJson

  included do
    after_action :publish_commentable, only: %i[create_comment]
  end

  def create_comment
    @comment = commentable.comments.new(comment_params.merge(user: current_user))
    #тут рендерится дважды, один раз через канал, другой через json. Не очень понимаю, как это исправить.
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
    comment_class = commentable.class.name.pluralize.downcase
    return if commentable.errors.any?
    ActionCable.server.broadcast("/#{comment_class}/#{params[:id]}/create_comment", { comment: @comment } )  
  end

end