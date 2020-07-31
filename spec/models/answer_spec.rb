require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to(:author).class_name('User').optional }
  it { should belong_to :question }
end
