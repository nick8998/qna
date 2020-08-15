class User < ApplicationRecord
  has_many :authored_questions, foreign_key: "author_id", class_name: "Question", dependent: :destroy
  has_many :authored_answers, foreign_key: "author_id", class_name: "Answer", dependent: :destroy
  has_many :authored_links, foreign_key: "author_id", class_name: "Link", dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :votes_users, dependent: :destroy
  has_many :votes, through: :votes_users, dependent: :destroy



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def author_of?(resourse)
    resourse.author_id == id
  end
end
