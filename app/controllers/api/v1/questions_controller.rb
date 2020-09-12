class Api::V1::QuestionsController < Api::V1::BaseController

  def index
    @questions = Question.all
    render json: @questions
  end
=begin
  
{"access_token":"CNXyeiulKoxhMCrQj9z1TyqTeIFzKlPb1aq-wWLi1dU","token_type":"Bearer","expires_in":86400,"scope":"'","created_at":1599910858}
  
=end
end