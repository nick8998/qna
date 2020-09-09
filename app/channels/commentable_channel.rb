class CommentableChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "/questions/#{params["id"]}/create_comment"
  end
end
