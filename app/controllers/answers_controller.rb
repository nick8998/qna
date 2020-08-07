  class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[destroy update update_best]
  before_action :find_question, only: %i[create]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.update(author_id: current_user.id)
  end

  def update
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
      flash[:notice] = "You answer was updated"
    else
      flash[:alert] = "You can't update answer"
    end
  end

  def update_best 
    @question = @answer.question 
    if current_user.author_of?(@question)
      @answer.choose_best
      flash[:notice] = "This answer is best"
    else
      flash[:alert] = "You can't choose best answer"
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @question = @answer.question
      @answer.destroy
      flash[:notice] = "Answer was deleted"
    else
      flash[:alert] = "You can't delete answer"
    end
  end

  private 

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [])    
  end
end
