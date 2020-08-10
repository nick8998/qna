class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true

  validates :url, url: true

  def gist?
    url.include?("https://gist.github.com/")
  end
end
