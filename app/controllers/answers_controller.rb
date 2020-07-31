class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[destroy update update_best]
  before_action :find_question, only: %i[create]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.update(author_id: current_user.id)
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def update_best
    @question = @answer.question
    if @question.best_answers?
      @question.answers.where(best: true).update(best: false)
    end    
    @answer.update!(best: true)
  end

  def destroy
    if current_user.author_of?(@answer)
      @question = @answer.question
      @answer.destroy
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
    params.require(:answer).permit(:body)    
  end
end
