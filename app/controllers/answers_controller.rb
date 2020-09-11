class AnswersController < ApplicationController
  include Votable
  include Commentable
  before_action :find_answer, only: %i[destroy update update_best]
  before_action :find_question, only: %i[create]
  after_action :publish_answer, only: %i[create]
  authorize_resource

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
    @comment = Comment.new
    @answer.update(answer_params)
    @question = @answer.question
  end

  def update_best 
    @comment = Comment.new
    @question = @answer.question
    @answer.choose_best
  end

  def destroy
    @question = @answer.question
    @answer.destroy
  end

  private 

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast( 
      "/questions/#{params[:id]}/answers",
      { answer: @answer } )  
  end

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
