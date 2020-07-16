FactoryBot.define do
  factory :answer do
    body { "MyText" }
  end

  trait :invalid do
    body { nil }
  end
end
