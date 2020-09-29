class NewAnswersJob < ApplicationJob
  queue_as :default

  def perform
    NewAnswers.new.send_answers
  end
end
