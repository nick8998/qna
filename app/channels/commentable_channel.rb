class CommentableChannel < ApplicationCable::Channel
  def follow(data)
    #не получается через data, как в answers_channel получить id и type
    stream_from "/questions/#{params["id"]}/create_comment"
  end
end
