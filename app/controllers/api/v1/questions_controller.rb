class Api::V1::QuestionsController < Api::V1::BaseController
  authorize_resource
  before_action :find_question, only: %i[show destroy update]

  def index
    @questions = Question.all
    render json: @questions
  end

  def show
    render json: @question
  end

  def create
    @question = Question.new(question_params.merge(author: current_user))
    if @question.save
      render json: @question
    else 
      head :forbidden
    end
  end

  def destroy
    @question.destroy
    if @question.errors.any?
      head :forbidden
    else
      head :ok
    end
  end

  def update
    
    if @question.update(question_params)
      render json: @question
    else
      head :forbidden
    end
  end

  private

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:id, :name, :url, :_destroy], reward_attributes: [:title, :image])    
  end
end