FactoryBot.define do
  factory :comment do
    sequence(:body) { |n| "Comment body #{n}" }
  end
end
