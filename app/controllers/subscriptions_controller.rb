class SubscriptionsController < ApplicationController

  before_action :set_question, only: %i[create destroy]
  authorize_resource

  def create
    if @question.subscriptions.find_by(user_id: current_user.id).nil?
      subscriber = Subscription.new(question: @question, user: current_user)
      subscriber.save!
      redirect_to @question
    else
      redirect_to @question
    end
  end

  def destroy
    Subscription.find_by(params[:id]).destroy
    redirect_to @question
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end
end
