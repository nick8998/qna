require 'rails_helper'

RSpec.describe NewAnswersJob, type: :job do
  let(:service) { double('NewAnswers') }

  before do
    allow(NewAnswers).to receive(:new).and_return(service)
  end

  it 'calls DailyDigest#send_digest' do
    expect(service).to receive(:send_answers)
    NewAnswersJob.perform_now
  end
end
