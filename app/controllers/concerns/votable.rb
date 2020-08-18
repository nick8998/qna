module Votable
  extend ActiveSupport::Concern

  def vote_up
    if model_klass.author_exist?(current_user)
      model_klass.create_positive_vote(current_user)
    end
    render_json_voting
  end


  def vote_down
    if model_klass.author_exist?(current_user)
      model_klass.create_negative_vote(current_user)
    end
    render_json_voting
  end

  def vote_cancel
    model_klass.cancel(current_user)
    render_json_voting
  end

  def render_json_voting
    respond_to do |format|
      if model_klass.vote.persisted?
        format.json { render_json(model_klass.vote) }
      else
        format.json { render_errors(model_klass.vote) }
      end
    end
  end

  def render_errors(item)
    render json: item.errors.full_messages, status: :unprocessable_entity
  end

  def render_json(item)
    render json: item
  end

  private

  def model_klass
    controller_name.classify.constantize.find(params[:id])
  end

end