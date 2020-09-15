class Api::V1::QuestionsController < Api::V1::BaseController

  def index
    @questions = Question.all
    render json: @questions
  end

  def show
    @question = Question.with_attached_files.find(params[:id])
    render json: @question
  end

  def create
    @question = Question.new(question_params.merge(author: current_user))
    if @question.save
      render json: @question
    else 
     render json: {
            status: :unprocessable_entity, # 422
        }
    end
  end

  def destroy
    @question = Question.with_attached_files.find(params[:id])
    @question.destroy
    if @question.errors.any?
        render json: {
            status: :unprocessable_entity, # 422
        }
    else
        render json: {
            status: :ok, # 200
        }
    end
  end

  def update
    @question = Question.with_attached_files.find(params[:id])
    @question.update(question_params)
    render json: @question
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:id, :name, :url, :_destroy], reward_attributes: [:title, :image])    
  end
end