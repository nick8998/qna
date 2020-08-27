class AnswersChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "/questions/#{data['id']}/answers"
  end
end
