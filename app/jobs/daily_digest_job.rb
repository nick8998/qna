class DailyDigestJob < ApplicationJob
  queue_as :default

  def perform
    DailyDigest.new.send_digest
  end
end
