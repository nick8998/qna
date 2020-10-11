require 'rails_helper'

RSpec.describe NewAnswers do
  let(:subs) { create_list(:subscription, 3) }

  it 'sends new answers to subscribed users' do
    subs.each { |sub| expect(NewAnswersMailer).to receive(:new_answers).with(sub.question).and_call_original }
    subject.send_answers
  end
end