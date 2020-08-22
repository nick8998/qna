class AnswersController < ApplicationController
  include Votable
  before_action :authenticate_user!
  before_action :find_answer, only: %i[destroy update update_best]
  before_action :find_question, only: %i[create]

  def create
    @answer = @question.answers.create(answer_params.merge(author: current_user))
    respond_to do |format|
      if @answer.save
        format.json { render json: @answer }
      else
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
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
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def find_question
    @question = Question.with_attached_files.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:id, :name, :url, :_destroy])    
  end
end
