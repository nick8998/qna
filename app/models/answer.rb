class Answer < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true 
  belongs_to :question

  validates :body, presence: true
end
