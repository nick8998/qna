class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  belongs_to :author, class_name: "User", optional: true 

  validates :name, :url, presence: true

  validates :url, url: true

  def gist?
    url.include?("https://gist.github.com/")
  end
end
