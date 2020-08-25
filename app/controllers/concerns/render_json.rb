module RenderJson
  extend ActiveSupport::Concern

  def render_errors(item)
    render json: item.errors.full_messages, status: :unprocessable_entity
  end

  def render_json(item)
    render json: item
  end


end