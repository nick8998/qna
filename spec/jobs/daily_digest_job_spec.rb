require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:service) { double('DailyDigest') }

  before do
    allow(DailyDigest).to receive(:new).and_return(service)
  end

  it 'calls DailyDigest#send_digest' do
    expect(service).to receive(:send_digest)
    DailyDigestJob.perform_now
  end 
end
