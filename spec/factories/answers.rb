FactoryBot.define do
  sequence :body do |n|
    "MyText#{n}"
  end

  factory :answer do
    body { "MyText" }
  end

  factory :answers, parent: :answer do
    body
  end

  trait :invalid do
    body { nil }
  end
end
