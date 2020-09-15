class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :links, :files, :comments, :votes
  belongs_to :author, class_name: "User", optional: true 
end
