class QuestionsController < ApplicationController
  include Votable
  include Commentable
  before_action :find_question, only: %i[show edit update destroy update_best]

  after_action :publish_question, only: %i[create]

  authorize_resource

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @comment = Comment.new
    @answer.links.new
  end

  def new
    @question = Question.new
    @question.links.new
    @question.build_reward
  end

  def edit;  end

  def create
    @question = Question.new(question_params.merge(author: current_user))
    if @question.save
      redirect_to @question, notice: "Your question successfully created."
    else 
     render :new
    end
  end

  def update
    @comment = Comment.new
    if current_user.author_of?(@question)
      @question.update(question_params)
      flash[:notice] = "Your question was updated"
    else
      flash[:alert] = "You can't update question" 
    end
    
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
  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast( 
      'questions', 
      ApplicationController.render(
        partial: 'questions/question_for_index',
        locals: { question: @question }
        )
      )
  end

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  
  def question_params
    params.require(:question).permit(:title, :body, files: [], links_attributes: [:id, :name, :url, :_destroy], reward_attributes: [:title, :image])    
  end

  
end
