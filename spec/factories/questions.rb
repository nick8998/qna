FactoryBot.define do 
  factory :question do
    sequence(:title) { |n| "Question title #{n}" }
    sequence(:body) { |n| "Question body #{n}" }

    trait :invalid do
      title { nil }
    end
  end
end
