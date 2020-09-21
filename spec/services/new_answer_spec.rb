require 'rails_helper'

RSpec.describe NewAnswer do
  let(:user) { create(:user) }

  it 'sends new answer for author' do
    user.
    users.each { |user| expect(DailyDigestMailer).to receive(:digest).with(user).and_call_original }
    subject.send_digest
  end
end