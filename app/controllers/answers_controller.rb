class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[destroy update]
  before_action :find_question, only: %i[create]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.update(author_id: current_user.id)
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = "Answer was destroyed"
    else
      flash[:alert] = "You can't destroy answer"
    end

    redirect_to @answer.question
  end

  private 

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)    
  end
end
