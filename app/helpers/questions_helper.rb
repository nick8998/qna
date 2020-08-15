module QuestionsHelper
  def add_author_to_links
    self.links.each do |link|
      link.author = current_user
    end
  end
end
