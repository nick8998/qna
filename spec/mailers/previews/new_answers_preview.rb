# Preview all emails at http://localhost:3000/rails/mailers/new_answers
class NewAnswersPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_answers/new_answers
  def new_answers
    NewAnswersMailer.new_answers
  end

end
