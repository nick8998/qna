class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[destroy update]
  before_action :find_question, only: %i[create]

  def create
    @answer = @question.answers.create(answer_params)
    @answer.update(author_id: current_user.id)
  end

  def update
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    end
  end

  def update_best
    @answer = Answer.find(params[:answer_id])
    @question = @answer.question 
    if current_user.author_of?(@question)
      @answer.choose_best(@question)
    end
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
