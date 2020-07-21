class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :find_answer, only: %i[edit update destroy]
  before_action :find_question, only: %i[new create]

  def edit;  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to @answer.question, notice: "Your answer successfully created."
    else 
      redirect_to @answer.question
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render :edit
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      redirect_to @answer.question, notice: "Answer was destroyed"
    else
      redirect_to @answer.question, alert: "You can't destroy answer"
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
