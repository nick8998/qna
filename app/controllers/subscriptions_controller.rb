class SubscriptionsController < ApplicationController

  before_action :set_question, only: %i[create]
  authorize_resource

  def create
    if can?(:create, Subscription)
      current_user.subscriptions.create(question: @question)
    end
    redirect_to @question
  end

  def destroy
    Subscription.find_by(params[:id]).destroy
    redirect_to root_path
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
