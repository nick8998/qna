class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy update_best]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @best_answer = @question.answers.where(best: true).first
  end

  def new
    @question = Question.new
  end

  def edit;  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user
    if @question.save
      redirect_to @question, notice: "Your question successfully created."
    else 
     render :new
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
      redirect_to questions_path, notice: "Question was destroyed"
    else
      redirect_to questions_path, alert: "You can't destroy question"
    end
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  
  def question_params
    params.require(:question).permit(:title, :body)    
  end
end
