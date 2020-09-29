require "rails_helper"

RSpec.describe NewAnswersMailer, type: :mailer do
  describe "new_answers" do
    let(:mail) { NewAnswersMailer.new_answers }

    it "renders the headers" do
      expect(mail.subject).to eq("New answers")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
