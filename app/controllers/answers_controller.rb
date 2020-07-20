class AnswersController < ApplicationController

  before_action :authenticate_user!, except: %i[index show]
  before_action :load_answer, only: %i[show edit update destroy]
  before_action :find_question, only: %i[new create]

  def index;  end
  
  def show;  end

  def new
    @answer = @question.answers.new
  end

  def edit;  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author_id = current_user.id
    if @answer.save
      redirect_to @answer.question, notice: "Your answer successfully created."
    else 
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @answer
    else
      render :edit
    end
  end

  def destroy
    if @answer.author_id == current_user.id
      @answer.destroy
      redirect_to @answer.question, notice: "Answer was destroyed"
    else
      redirect_to @answer.question, alert: "You can't destroy answer"
    end
  end

  private 

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)    
  end
end
