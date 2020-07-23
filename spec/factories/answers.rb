FactoryBot.define do
  factory :answer do
    sequence(:body) { |n| "Answer body #{n}" }
  end

  trait :invalid do
    body { nil }
  end
end
