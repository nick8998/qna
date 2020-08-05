class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy update_best]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
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
    if current_user.author_of?(@question)
      @question.update(question_params)
      flash[:notice] = "Your question was updated"
    else
      flash[:alert] = "You can't update question" 
    end
  end

  def delete_file
    @file = ActiveStorage::Attachment.find(params[:id])
    @question = @file.record
    @file.purge
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
    @question = Question.with_attached_files.find(params[:id])
  end

  
  def question_params
    params.require(:question).permit(:title, :body, files: [])    
  end
end
