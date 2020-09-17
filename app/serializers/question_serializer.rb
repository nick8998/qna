class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :short_title, :links, :reward, :files, :comments, :votes
  has_many :answers
  belongs_to :author, class_name: "User", optional: true 

  def short_title
    object.title.truncate(7)
  end
end
