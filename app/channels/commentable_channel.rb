class CommentableChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "/questions/#{params['id']}/create_comment"
    stream_from "/answers/#{params['id']}/create_comment"
  end
end
