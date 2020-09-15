class Api::V1::AnswersController < Api::V1::BaseController
  before_action :find_answer, only: %i[show destroy update]
  before_action :find_question, only: %i[create]

  def show
    render json: @answer
  end

  def create
    @answer = @question.answers.create(answer_params.merge(author: current_user))
    if @answer.save
      render json: @answer
    else 
     render json: {
            status: :unprocessable_entity, # 422
        }
    end
  end

  def destroy
    @answer.destroy
    if @answer.errors.any?
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
    @answer.update(answer_params)
    render json: @answer
  end


  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:id, :name, :url, :_destroy])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def find_question
    @question = Question.with_attached_files.find(params[:question_id])
  end
end